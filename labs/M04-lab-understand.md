# M04 Lab — Understand It Path

> **Module:** M04 · Spring MVC Fundamentals
> **Track:** Spring Core Fundamentals
> **Time:** ~30 minutes

---

## Goal

Trace a request through Spring MVC and see exactly where view rendering and JSON serialization
diverge — using a Prior Authorization detail endpoint.

---

## Part 1: Read the Code (10 min)

```java
@Controller
@RequestMapping("/prior-auths")
public class PriorAuthViewController {

    private final PriorAuthService service;
    public PriorAuthViewController(PriorAuthService service) { this.service = service; }

    @GetMapping("/{authNumber}")
    public String view(@PathVariable String authNumber,
                       @RequestParam(required = false) String tab,
                       Model model) {
        model.addAttribute("request", service.findByNumber(authNumber));
        return "prior-auth-detail";
    }
}
```

**Questions to answer:**

1. For the request `GET /prior-auths/PA-2026-000123?tab=services`, what value does
   `authNumber` receive? What does `tab` receive? What handles a *missing* `tab`?
2. The method returns the `String` `"prior-auth-detail"`. Is that the HTML sent to the browser?
   If not, what is it, and which component turns it into a page?
3. Where did the `PriorAuthService` come from — and which earlier module's mechanism put it there?
4. Add `@ResponseBody` to this method. What changes about the response? What is no longer used?

---

## Part 2: Order the Lifecycle (10 min)

Number these steps in the order they happen for the request above:

- [ ] `ViewResolver` turns `"prior-auth-detail"` into a concrete View
- [ ] `HandlerMapping` decides `view()` handles this URL + method
- [ ] The `DispatcherServlet` receives the request
- [ ] `view()` runs and populates the `Model`
- [ ] The View renders the model into HTML
- [ ] The response goes back to the client

Which single component is involved in **every** step above?

---

## Part 3: Predict & Verify (10 min)

| Change | Your Prediction | Actual Result |
|--------|----------------|---------------|
| Change `@GetMapping` to `@PostMapping`, then `GET` the URL | | |
| Request `/prior-auths/PA-1` with no `?tab=` | | |
| Add `@ResponseBody` and request the URL with `Accept: application/json` | | |
| Use `@RestController` on the class instead of `@Controller` | | |

---

## You'll know it worked when:

- [ ] You can name every component in the MVC lifecycle and what it does
- [ ] You can explain what a "logical view name" is vs the rendered HTML
- [ ] You can state exactly what `@ResponseBody` changes
- [ ] You can explain why `@RestController` = `@Controller` + `@ResponseBody`
