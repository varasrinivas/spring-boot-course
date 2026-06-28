# M09 Plan — REST Controllers

**Track:** Building REST APIs (key: rest, color: #2dd4bf) — START of Track 3
**Level:** Intermediate
**Status:** ✅ BUILT

## Concepts

1. **@RestController & Resource Mapping**
   - Visual: `m09-rest-resource` — collection (/api/prior-auths) vs item (/{authNumber})
     resources with their verb chips
   - Code: PriorAuthController skeleton with @RestController + @RequestMapping base path
   - Key point: resources are nouns (plural); builds on M04's @RestController

2. **Mapping HTTP Verbs to Methods**
   - Visual: `m09-verb-methods` — verb → annotation → URL → action → status grid
   - Code: GET list/read, POST submit with @RequestBody, @PathVariable, @RequestParam
   - Key point: each verb annotation maps a method; Spring (de)serializes JSON automatically

3. **ResponseEntity: Status, Headers & Body**
   - Visual: `m09-responseentity` — anatomy: status line + headers (Location) + body
   - Code: 201 Created + Location, 204 No Content, 200 OK
   - Key point: ResponseEntity gives full control over the HTTP response

4. **REST Conventions & Status Codes**
   - Visual: `m09-status-codes` — 2xx/4xx/5xx grouped with prior-auth scenarios
   - Key point: return the code that matches the outcome; 4xx error handling detail → M10

## Coming From Java Angle

Raw servlets: parse method/path, switch on the verb, set status + headers by hand, serialize
JSON yourself. Spring REST: declarative verb mappings, automatic (de)serialization,
ResponseEntity for status/headers.

## Code Examples

- PriorAuthController with @GetMapping/@PostMapping (~14 lines)
- ResponseEntity 201/204/200 (~10 lines)

## SVG Diagrams

- rest-resource: 640×280, collection vs item resources + verbs
- verb-methods: 640×300, verb→annotation→url→action→status grid
- responseentity: 640×260, response anatomy (status/headers/body)
- status-codes: 640×280, 2xx/4xx/5xx grouped scenarios
