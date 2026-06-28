# M05 Plan — Your First Spring Boot App

**Track:** Spring Boot Essentials (key: boot, color: #5e86c7) — START of Track 2
**Level:** Foundational
**Status:** ✅ BUILT

## Concepts

1. **What Spring Boot Adds Over Core Spring**
   - Visual: `m05-boot-vs-core` — two columns: manual core-Spring setup steps vs Boot's
     automated equivalents (bridges back to M04's DispatcherServlet wiring)
   - Key point: Boot is convention + auto-config over the same core container you already know

2. **@SpringBootApplication: The Meta-Annotation**
   - Visual: `m05-sba-annotation` — decompose into @Configuration + @EnableAutoConfiguration
     + @ComponentScan
   - Code: `PriorAuthServiceApplication` main class with `SpringApplication.run(...)`
   - Key point: one annotation = config source + auto-config + component scan of its package

3. **start.spring.io & Project Structure**
   - Visual: `m05-initializr` — Initializr selections → generated standard Maven layout
   - Code: a `curl start.spring.io` generation command with starter dependencies
   - Key point: starters bundle compatible dependency versions; layout is conventional

4. **Embedded Server & the Executable JAR**
   - Visual: `m05-embedded-jar` — fat JAR (your classes + deps + embedded Tomcat + manifest);
     `java -jar` boots context + server; contrast with old WAR-on-external-Tomcat
   - Code: `mvnw clean package` then `java -jar` run commands
   - Key point: the server ships inside the app; `main()` starts everything

## Coming From Java Angle

Pre-Boot core Spring: pick a servlet container, register the DispatcherServlet (M04) via
web.xml/Java config, curate a BOM of compatible library versions, build a WAR, deploy to an
external Tomcat. Boot: one annotation + starters + embedded server + `java -jar`.

## Code Examples

- `@SpringBootApplication` main class (~10 lines)
- `curl https://start.spring.io/starter.zip ...` (~5 lines)
- `mvnw clean package` + `java -jar` (~3 lines)

## SVG Diagrams

- boot-vs-core: 640×300, manual vs automated two-column checklist
- sba-annotation: 640×240, meta-annotation decomposition
- initializr: 640×280, Initializr form → project tree
- embedded-jar: 640×260, fat JAR contents + java -jar boot flow
