# CLAUDE.md — Spring Boot & Microservices Course

## Project Overview

Interactive single-file HTML course: **Spring Boot & Microservices for Java Developers**.  
37 modules (M00–M36) across 9 tracks. Domain anchor: **Prior Authorization Service** (healthcare: a provider requests payer approval before delivering a service).  
Target: Java developers who know core Java but are new to Spring.

**Theme:** dark. Surface colors live in CSS custom properties (`--paper/--ink/--muted/--line/--card`); SVG visuals reference them via `var(--card)`, `var(--ink)`, etc. so they theme automatically. Track colors are dark-friendly (`--t0`…`--t9`); use `var(--tN)` inside SVGs rather than hardcoded hex.

## Architecture

- **Render engine:** `course/index.html` — single self-contained HTML file
- **Data model:** JavaScript `MODS` array inside the HTML; each element is a module object
- **Visuals:** `renderVisual(type)` switch returns inline SVG/HTML per module
- **Labs:** Markdown files in `labs/MXX-lab-understand.md` and `labs/MXX-lab-build.md`
- **Plans:** Per-module plan files in `plans/MXX-plan.md` (durable cross-session memory)

## Design System

| Token | Value |
|-------|-------|
| Display font | `Fraunces` (Google Fonts, opsz 9–144, weights 400/600/700) |
| Code font | `JetBrains Mono` (Google Fonts, weights 400/600) |
| Body font | `Georgia, 'Times New Roman', serif` |
| Background | `#0f1117` (dark) |
| Ink | `#e7e4dc` |
| Muted | `#9aa3b4` |
| Card | `#1a1e27` |
| Line | `#2a2f3a` |
| Code block bg | `#0b0d12` |

### Track Colors (dark-friendly)

| Track | Color | CSS var |
|-------|-------|---------|
| 0 — Orientation | `#818cf8` | `--t0` |
| 1 — Spring Core | `#6ea3d8` | `--t1` |
| 2 — Boot Essentials | `#5e86c7` | `--t2` |
| 3 — REST APIs | `#2dd4bf` | `--t3` |
| 4 — Data Access JPA | `#f59e0b` | `--t4` |
| 5 — Security | `#f87171` | `--t5` |
| 6 — Microservices | `#a78bfa` | `--t6` |
| 7 — Communication | `#22d3ee` | `--t7` |
| 8 — Resilience | `#f472b6` | `--t8` |
| 9 — Deployment | `#34d399` | `--t9` |

## Module Schema

Every module in the `MODS` array follows this structure:

```json
{
  "id": "M01",
  "track": "foundations",
  "track_label": "Spring Boot Foundations",
  "track_color": "#2b4a7e",
  "level": "Foundational",
  "title": "Your First Spring Boot App",
  "subtitle": "One-sentence hook.",
  "objectives": ["Obj 1", "Obj 2", "Obj 3"],
  "intro": "2–3 paragraph intro. Use Prior Authorization domain examples.",
  "concepts": [
    {
      "title": "Concept Name",
      "body": "Explanation (HTML allowed). Use <code> for inline code.",
      "visual": "visual-type-key",
      "code": "// Optional code block\n@SpringBootApplication\npublic class App { }"
    }
  ],
  "comingFrom": {
    "java": "How a pure-Java developer would do this without Spring.",
    "context": "Why Spring's approach is better and what it automates."
  },
  "keyTakeaways": ["Takeaway 1", "Takeaway 2", "Takeaway 3"]
}
```

## Authoring Rules

1. **Content depth:** Each module has 3–5 concepts, each with a clear explanation
2. **Code examples:** ALL code uses the Prior Authorization domain (PriorAuthController, PriorAuthRequest, PriorAuthRepository, Patient, Provider, RequestedService, etc.)
3. **Visuals:** Every module MUST have at least one `renderVisual()` type — SVG diagram, flow, or architecture
4. **"Coming From Java" callout:** Every module compares Spring approach vs plain Java approach
5. **No quizzes or exercises inside the HTML** — those live in the lab markdown files
6. **Accessibility:** All SVGs must have `role="img"` and `aria-label`; respect `prefers-reduced-motion`
7. **File size:** Single-file course by design — the validator and the self-contained rule both depend on `MODS`/`renderVisual` living in `index.html`, so do NOT split into external `.js`. The full 37-module course is ~740KB, which a browser loads instantly; cap is 1.5MB.
8. **Self-contained:** No external JS/CSS dependencies (Google Fonts exception)

## Slash Commands

### /plan-module MXX

Creates `plans/MXX-plan.md` with:
- Module title and track
- 3–5 concept outlines with visual types
- "Coming From Java" angle
- Estimated code examples
- SVG diagram description

### /build-module MXX

Reads `plans/MXX-plan.md`, then:
1. Writes the module JSON object
2. Writes matching `renderVisual()` case entries
3. Injects both into `course/index.html` using Python script (NOT full-file rewrite)
4. Runs `node --check` equivalent validation
5. Updates sidebar module count

### /build-lab MXX

Creates two files from templates:
- `labs/MXX-lab-understand.md` — guided walkthrough, conceptual exercises
- `labs/MXX-lab-build.md` — hands-on coding with Claude Code assistance

### /validate-module MXX

Runs `scripts\validate-module.ps1 -ModuleId MXX`:
- Checks module exists in MODS array
- Validates JSON structure (all required fields)
- Checks renderVisual case exists
- Verifies code blocks have Prior Authorization domain references
- Checks "Coming From Java" callout exists
- Validates SVG accessibility attributes
- Checks file size < 500KB
- Runs `node --check` on extracted JS

### /validate-all

Runs `scripts\validate-all.ps1`:
- Iterates all modules M00–M36
- Runs full validation on each
- Outputs summary report

## Workflow: One Module Per Session

```
1. /plan-module MXX          → creates plans/MXX-plan.md
2. Review & refine the plan
3. /build-module MXX          → injects into course/index.html
4. Preview in browser:        Start-Process "course\index.html"
5. /validate-module MXX       → run 20-point checklist
6. /build-lab MXX             → create lab files
7. /clear                     → start next session fresh
```

Plan files persist across sessions as durable memory.

## Injection Pattern (Python)

NEVER rewrite the full HTML file. Use Python to inject module data:

```python
import json

# Read current HTML
with open("course/index.html", "r", encoding="utf-8") as f:
    src = f.read()

# Find MODS array end and inject new module
marker = "];\n\nconst TRACK_META"
new_module = json.dumps(module_obj, indent=2)
src = src.replace(marker, f",\n{new_module}\n{marker}")

# Find renderVisual switch and inject new case
visual_marker = "default: return '';"
new_visual = f'case "{visual_key}": return `{svg_html}`;'
src = src.replace(visual_marker, f'{new_visual}\n      {visual_marker}')

with open("course/index.html", "w", encoding="utf-8") as f:
    f.write(src)
```

## File Layout

```
spring-course-kit/
├── CLAUDE.md                  ← this file (Claude Code context)
├── BUILD-THE-COURSE.md        ← step-by-step Windows guide
├── curriculum-map.md          ← full 33-module blueprint
├── course/
│   └── index.html             ← single-file course player (M00 seeded)
├── labs/
│   ├── M00-lab-understand.md
│   └── M00-lab-build.md
├── plans/
│   └── M00-plan.md            ← (auto-created per module)
├── templates/
│   ├── module-schema.json     ← copy-paste module template
│   ├── lab-understand.md      ← lab template (Understand It)
│   └── lab-build.md           ← lab template (Build It with AI)
└── scripts/
    ├── validate-module.ps1    ← per-module validation (20 checks)
    └── validate-all.ps1       ← batch validation
```

## Windows Notes

- All paths use backslashes in PowerShell commands
- Browser preview: `Start-Process "course\index.html"`
- Node check: `node -e "JSON.parse(require('fs').readFileSync('temp.json','utf8'))"`
- PowerShell execution policy: `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`
