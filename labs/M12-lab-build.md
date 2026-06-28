# M12 Lab — Build It with AI Path

> **Module:** M12 · Pagination, Filtering & HATEOAS
> **Track:** Building REST APIs
> **Time:** ~50 minutes
> **Requires:** Claude Code, JDK 21, IDE

---

## Goal

Upgrade `GET /api/prior-auths` from "return everything" to a paged, filterable, sortable, and
hypermedia-navigable endpoint — with Claude Code. Then verify the response shape with real calls.

---

## Setup

```powershell
cd C:\Projects\prior-auth-service
claude
```

---

## Step 1: Paginate (15 min)

Ask Claude Code:

> "Change the list endpoint to accept a `Pageable` (with `@PageableDefault(size=20,
> sort=\"requestDate\")`) and return `Page<PriorAuthResponse>`. Seed ~50 prior-auths so paging
> is visible."

Verify the metadata and slicing:

```powershell
curl "http://localhost:8080/api/prior-auths?page=0&size=20" | ConvertFrom-Json |
  Select-Object totalElements, totalPages, number, size
curl "http://localhost:8080/api/prior-auths?page=1&size=20&sort=requestDate,desc"
```

---

## Step 2: Filter & Sort (15 min)

> "Add optional `status` and `cptCode` query params. Implement filtering with a `Specification`
> that composes only the supplied predicates, applied together with the `Pageable`. Keep the
> controller thin."

Test combinations:

```powershell
curl "http://localhost:8080/api/prior-auths?status=PENDING&sort=requestDate,desc"
curl "http://localhost:8080/api/prior-auths?status=APPROVED&cptCode=70553"
```

**Your judgment call:** Confirm that omitting a filter widens the results rather than returning
nothing. Why does a `Specification` make that clean?

---

## Step 3: Add Hypermedia (15 min)

> "Add `spring-boot-starter-hateoas`. Wrap items in `EntityModel` with `self` and `decision`
> links built via `linkTo(methodOn(...))`, and return a `PagedModel` using
> `PagedResourcesAssembler`. Show the `_embedded`, `page`, and `_links` sections."

```powershell
curl "http://localhost:8080/api/prior-auths?page=1&size=20" | ConvertFrom-Json |
  Select-Object -ExpandProperty _links
```

Confirm `first/prev/self/next/last` links exist and that following `next` returns page 2.

---

## Step 4: Reflect (5 min)

- [ ] How much paging/counting logic did you write yourself vs. Spring providing it?
- [ ] Why is a self-describing `PagedModel` valuable to an API gateway or a generated client?
- [ ] Which links did you derive from controller methods, and why is that safer?

---

## You'll know it worked when:

- [ ] The endpoint returns one page with correct `totalElements`/`totalPages`
- [ ] Optional `status`/`cptCode` filters compose and combine correctly
- [ ] Responses include `_embedded`, `page`, and `_links` navigation
- [ ] Following the `next` link fetches the subsequent page
