# M06 Lab — Understand It Path

> **Module:** M06 · Auto-Configuration & Starters
> **Track:** Spring Boot Essentials
> **Time:** ~30 minutes

---

## Goal

Demystify Boot's "magic" by reading the conditions that drive it — and prove to yourself that
auto-configuration always yields to your own beans and properties.

---

## Part 1: Read the Code (10 min)

```java
@AutoConfiguration
public class DataSourceAutoConfiguration {

    @Bean
    @ConditionalOnClass(HikariDataSource.class)
    @ConditionalOnMissingBean(DataSource.class)
    public DataSource dataSource(DataSourceProperties props) {
        return props.initializeDataSourceBuilder().build();
    }
}
```

**Questions to answer:**

1. Under what *two* conditions does this `dataSource` bean get created? State each in plain
   English.
2. You add your own `@Bean DataSource` to the Prior Authorization Service. Which annotation
   causes Boot's version to step aside, and what is the resulting bean count of type
   `DataSource`?
3. You remove the JDBC driver and pooling library from the project. What happens to this
   auto-configuration, and which annotation is responsible?
4. Where does `DataSourceProperties` get its values from?

---

## Part 2: Trace Starter → Classpath → Auto-Config (10 min)

Fill in the chain for `spring-boot-starter-data-jpa`:

1. The starter is a POM that transitively brings which libraries? (name three)
2. Those libraries landing on the classpath satisfy which *kind* of condition?
3. That condition passing causes Boot to register which beans?
4. In one sentence: why does adding one line to `pom.xml` produce working persistence?

---

## Part 3: Predict the Condition Report (10 min)

You run the app with `--debug`. For each scenario, predict whether the DataSource
auto-configuration appears under **Positive matches** or **Negative matches**:

| Scenario | Positive / Negative | Why |
|----------|--------------------|-----|
| JPA starter present, no custom DataSource bean | | |
| JPA starter present, you defined a `@Bean DataSource` | | |
| No JDBC driver on the classpath | | |
| `spring.datasource.url` set but no driver present | | |

---

## You'll know it worked when:

- [ ] You can read `@ConditionalOnClass` / `@ConditionalOnMissingBean` and say when each passes
- [ ] You can trace starter → classpath → condition → bean
- [ ] You can state the override precedence (your @Bean > properties > default)
- [ ] You know how to get Boot to tell you why a bean does or doesn't exist
