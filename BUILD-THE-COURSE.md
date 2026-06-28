# BUILD-THE-COURSE.md — Windows Step-by-Step Guide

## Prerequisites

Install these via PowerShell (admin):

```powershell
winget install Nodejs.NodeJS.LTS        # for node --check validation
winget install Git.Git                   # version control
```

You should already have Claude Code installed.

## 1. Unzip & Initialize

```powershell
# Extract the course kit
Expand-Archive spring-course-kit.zip -DestinationPath C:\Projects\spring-course-kit

# Navigate into it
cd C:\Projects\spring-course-kit

# Initialize git
git init
git add -A
git commit -m "Initial course kit scaffold with M00"
```

## 2. Set PowerShell Execution Policy

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

## 3. Preview M00 in Browser

```powershell
Start-Process "course\index.html"
```

Verify you see the Course Orientation module with:
- Sidebar with track groups
- 8-track overview SVG diagram
- Prior Authorization domain model SVG
- Dev stack SVG
- "Coming From Java" callout

## 4. Validate M00

```powershell
.\scripts\validate-module.ps1 -ModuleId M00
```

All 20 checks should pass (labs may show as WARN until you create them).

## 5. Start Building Modules — One Per Session

Launch Claude Code in the project directory:

```powershell
cd C:\Projects\spring-course-kit
claude
```

### Session workflow:

```
Step 1:  /plan-module M01
         → Creates plans\M01-plan.md
         → Review the plan, ask Claude to refine if needed

Step 2:  /build-module M01
         → Injects module JSON into MODS array
         → Injects renderVisual cases
         → Runs validation

Step 3:  Preview in browser
         Start-Process "course\index.html"
         → Navigate to M01 in sidebar

Step 4:  /validate-module M01
         → 20-point checklist

Step 5:  /build-lab M01
         → Creates labs\M01-lab-understand.md
         → Creates labs\M01-lab-build.md

Step 6:  Git commit
         git add -A
         git commit -m "Add M01: Your First Spring Boot App"

Step 7:  /clear
         → Start fresh for next module
```

### Recommended build order:

Follow the track sequence — each track builds on the previous:

| Session | Module | Title |
|---------|--------|-------|
| 1 | M01 | Your First Spring Boot App |
| 2 | M02 | Auto-Configuration & Starters |
| 3 | M03 | Configuration & Profiles |
| 4 | M04 | DevTools & Actuator |
| 5 | M05 | REST Controllers |
| ... | ... | ... |
| 32 | M32 | CI/CD Pipeline |

## 6. Validate Everything

After building all modules:

```powershell
.\scripts\validate-all.ps1
```

## 7. Troubleshooting

| Problem | Solution |
|---------|----------|
| `node --check` fails | Run `node -e "JSON.parse(require('fs').readFileSync('temp.json','utf8'))"` to find JSON syntax errors |
| SVG not rendering | Check for unescaped `<` or `>` in template literals |
| Module not in sidebar | Verify the module JSON was injected before `];\n\nconst TRACK_META` |
| File size > 500KB | Split large SVG visuals; compress verbose explanations |
| PowerShell script won't run | `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` |
| Claude Code loses context | Plan files in `plans\` persist across `/clear` — they're your durable memory |

## 8. Tips

- **Always use Python injection** — never ask Claude Code to rewrite the full HTML
- **Plan files are your memory** — they survive `/clear` and give Claude Code context
- **One module per session** — keeps context focused and prevents drift
- **Git commit after each module** — easy rollback if something breaks
- **Preview after every build** — catch visual issues early
