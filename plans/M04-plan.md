# M04 Plan — Spring MVC Fundamentals

**Track:** Spring Core Fundamentals (color: #6ea3d8) — LAST of Track 1
**Level:** Foundational
**Status:** ✅ BUILT

## Concepts

1. **The DispatcherServlet: Spring's Front Controller**
   - Visual: `m04-dispatcher` — many request types funnel into one DispatcherServlet that
     routes each to the right handler
   - Key point: one front controller, not one servlet per URL; Boot auto-registers it at "/"

2. **The Request Processing Lifecycle**
   - Visual: `m04-request-lifecycle` — hub-and-spoke: Client → DispatcherServlet →
     HandlerMapping → Controller → ViewResolver → View → response (numbered 1–8)
   - Key point: the DispatcherServlet orchestrates every step; you only write the controller

3. **Controllers & Request Mapping**
   - Visual: `m04-mapping` — a URL decomposed into HTTP method + path variable → handler method
   - Code: `@Controller` + `@GetMapping("/{authNumber}")` + `@PathVariable` + `Model`
   - Key point: annotations declare which requests a method handles

4. **Models, Views, and Where REST Diverges**
   - Visual: `m04-model-view` — two paths after the controller: Model + ViewResolver → HTML,
     vs `@ResponseBody` → HttpMessageConverter → JSON
   - Code: same handler as a view-returning method vs a `@ResponseBody` method
   - Key point: `@RestController` (Track 3) = `@Controller` + `@ResponseBody`; skips view resolution

## Coming From Java Angle

Raw Servlets: one `HttpServlet` per URL, hand-written `doGet`/`doPost`, manual param parsing,
`web.xml` wiring, writing the response by hand. Spring MVC: one DispatcherServlet + annotated
handler methods.

## Code Examples

- `@Controller` with `@GetMapping` / `@PathVariable` / `Model` (~12 lines)
- view-returning vs `@ResponseBody` handler contrast (~12 lines)

## SVG Diagrams

- dispatcher: 640×280, requests funnel → front controller → handlers
- request-lifecycle: 680×330, numbered hub-and-spoke flow + legend
- mapping: 640×230, URL → method + @PathVariable → handler
- model-view: 640×300, two-path divergence (HTML view vs JSON body)
