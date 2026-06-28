# M06 Plan — Auto-Configuration & Starters

**Track:** Spring Boot Essentials (key: boot, color: #5e86c7)
**Level:** Foundational
**Status:** ✅ BUILT

## Concepts

1. **What Auto-Configuration Actually Does**
   - Visual: `m06-autoconfig-flow` — classpath + properties → auto-config engine → default beans
   - Key point: Boot registers sensible default beans you never declared (bridges M05's
     @EnableAutoConfiguration)

2. **Conditional Beans: @ConditionalOnClass / @ConditionalOnMissingBean**
   - Visual: `m06-conditional` — decision flow: on classpath? user-defined bean? → register/back off
   - Code: a simplified `DataSourceAutoConfiguration` with @ConditionalOnClass + @ConditionalOnMissingBean
   - Key point: every auto-config bean is gated by conditions and backs off when you override

3. **Starters: Curated Dependency Bundles**
   - Visual: `m06-starters` — one starter → fans out to version-aligned libs → triggers auto-config
   - Code: `spring-boot-starter-data-jpa` pom dep + what it transitively pulls
   - Key point: a starter is a POM of compatible deps; libs-on-classpath is what fires auto-config

4. **Overriding & Inspecting Auto-Config**
   - Visual: `m06-override` — precedence: your @Bean > properties > Boot defaults
   - Code: defining your own DataSource @Bean to win; properties to tune defaults
   - Key point: override via your bean (@ConditionalOnMissingBean) or properties; inspect with
     --debug / actuator conditions report

## Coming From Java Angle

Pre-Boot: hand-write XML/Java config for DataSource, EntityManagerFactory, transaction manager,
ObjectMapper — pages of boilerplate kept in sync by hand. Boot auto-configures them from the
classpath; you override only what differs.

## Code Examples

- simplified `@AutoConfiguration` with conditions (~10 lines)
- starter pom dependency + transitive comment (~8 lines)
- override with your own @Bean (~6 lines)

## SVG Diagrams

- autoconfig-flow: 640×280, inputs → engine → default beans
- conditional: 640×280, decision diamonds (classpath? own bean?)
- starters: 640×260, one starter fans out to libs
- override: 640×240, precedence ladder (bean > properties > defaults)
