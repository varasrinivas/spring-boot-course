# M11 Plan — API Documentation

**Track:** Building REST APIs (key: rest, color: #2dd4bf)
**Level:** Intermediate
**Status:** ✅ BUILT

## Concepts

1. **OpenAPI & springdoc: Docs From Code**
   - Visual: `m11-springdoc-flow` — controllers/DTOs → springdoc scans → /v3/api-docs (OpenAPI
     JSON) → Swagger UI
   - Code: springdoc dependency + the two URLs
   - Key point: the spec is generated from your code (mappings, DTOs, validation), always in sync

2. **Swagger UI: Interactive Docs**
   - Visual: `m11-swagger-ui` — stylized Swagger UI mock with verb rows + try-it-out
   - Code: an OpenAPI info @Bean (title/version/description)
   - Key point: a live, explorable, try-it page generated for free

3. **Enriching the Spec: @Operation, @ApiResponse, @Tag**
   - Visual: `m11-annotations` — annotated method → richer doc entry (summary + responses)
   - Code: annotated submit() with @Operation + @ApiResponse 201/400/409
   - Key point: annotations add human context the code alone can't express

4. **Documenting Models & Errors: @Schema & examples**
   - Visual: `m11-schema` — DTO @Schema fields → model doc with descriptions + example JSON
   - Code: @Schema(description/example) on SubmitPriorAuthRequest
   - Key point: document field meaning/examples and the ProblemDetail error shapes (M10)

## Coming From Java Angle

Hand-written API docs (wiki/Word) that drift out of sync, manually curated Postman collections,
no machine-readable contract. springdoc: docs generated from code, always current, interactive,
and consumable by codegen/gateways.

## Code Examples

- springdoc dependency + /v3/api-docs, /swagger-ui.html (~6 lines)
- OpenAPI info @Bean (~7 lines)
- @Operation + @ApiResponse on submit() (~10 lines)
- @Schema on DTO fields (~8 lines)

## SVG Diagrams

- springdoc-flow: 640×260, code → spec → Swagger UI pipeline
- swagger-ui: 640×300, stylized interactive docs mock
- annotations: 640×260, annotated method → doc entry
- schema: 640×260, DTO @Schema → model doc + example
