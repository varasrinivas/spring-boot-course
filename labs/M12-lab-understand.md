# M12 Lab — Understand It Path

> **Module:** M12 · Pagination, Filtering & HATEOAS
> **Track:** Building REST APIs
> **Time:** ~30 minutes

---

## Goal

Understand how Spring turns query parameters into paged, filtered, sorted, navigable responses
for the Prior Authorization collection.

---

## Part 1: Read the Code (10 min)

```java
@GetMapping
public PagedModel<EntityModel<PriorAuthResponse>> list(
        @RequestParam(required = false) Status status,
        @RequestParam(required = false) String cptCode,
        @PageableDefault(size = 20, sort = "requestDate") Pageable pageable,
        PagedResourcesAssembler<PriorAuthResponse> assembler) {

    Specification<PriorAuth> spec = Specification.where(byStatus(status)).and(byCptCode(cptCode));
    Page<PriorAuthResponse> page = service.search(spec, pageable);
    return assembler.toModel(page);
}
```

**Questions to answer:**

1. For `GET /api/prior-auths?page=2&size=20&sort=requestDate,desc`, what does `pageable` contain,
   and how many records come back?
2. A client sends neither `status` nor `cptCode`. What does the `Specification` resolve to, and
   how many filters apply?
3. What does `Page<PriorAuthResponse>` know that a plain `List` does not?
4. What three sections will `assembler.toModel(page)` put in the response body?

---

## Part 2: Map Params → Query (10 min)

| Query parameter | Effect on the query |
|-----------------|---------------------|
| `page=2` | |
| `size=20` | |
| `sort=requestDate,desc` | |
| `status=PENDING` | |

What's the advantage of a `Specification` over building the WHERE clause with `if` statements?

---

## Part 3: Read a PagedModel (10 min)

```json
{
  "_embedded": { "priorAuths": [ /* 20 items, each with _links */ ] },
  "page": { "size": 20, "totalElements": 138, "totalPages": 7, "number": 1 },
  "_links": { "first": {…}, "prev": {…}, "self": {…}, "next": {…}, "last": {…} }
}
```

1. How does a client fetch the next page *without* constructing a URL itself?
2. Which Richardson maturity level does the `_links` block represent?
3. Why are HATEOAS links built from controller methods safer than string concatenation?

---

## You'll know it worked when:

- [ ] You can explain what `Pageable` binds and what `Page` returns
- [ ] You can describe how optional filters compose as Specifications
- [ ] You can read a `PagedModel` and find items, totals, and navigation
- [ ] You can define HATEOAS and place it on the maturity model
