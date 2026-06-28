# M13 Lab — Understand It Path

> **Module:** M13 · Entities & Repositories
> **Track:** Data Access with JPA
> **Time:** ~30 minutes

---

## Goal

Understand how a Java class becomes a database table and how an empty repository interface gives
you full persistence — for the Prior Authorization entity.

---

## Part 1: Read the Code (10 min)

```java
@Entity
@Table(name = "prior_auth")
public class PriorAuth {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(unique = true, nullable = false)
    private String authNumber;
    private String patientMemberId;
    @Enumerated(EnumType.STRING)
    private AuthStatus status;
    private LocalDate requestDate;
}

public interface PriorAuthRepository extends JpaRepository<PriorAuth, Long> {
    Optional<PriorAuth> findByAuthNumber(String authNumber);
    long countByStatus(AuthStatus status);
}
```

**Questions to answer:**

1. What table, columns, and primary key does the entity map to? Who assigns the `id`?
2. Why `@Enumerated(EnumType.STRING)` rather than the default ordinal — what breaks if a new
   enum value is inserted in the middle later?
3. `PriorAuthRepository` has no implementation. Where does the real one come from, and when?
4. What SQL do `findByAuthNumber` and `countByStatus` translate to?

---

## Part 2: Map Method Names → SQL (10 min)

| Repository method | SQL it generates |
|-------------------|------------------|
| `findByStatus(AuthStatus s)` | |
| `findByPatientMemberIdAndStatus(...)` | |
| `existsByAuthNumber(String n)` | |
| `findTop10ByOrderByRequestDateDesc()` | |

Which prefix returns a count? Which returns a boolean?

---

## Part 3: H2 vs PostgreSQL (10 min)

| Question | Answer |
|----------|--------|
| Which DB runs in the `dev` profile, and where does its data live? | |
| What changes in your Java to switch to PostgreSQL? | |
| What does `spring.jpa.hibernate.ddl-auto` do, and which value belongs in prod? | |
| Why is an in-memory DB ideal for tests? | |

---

## You'll know it worked when:

- [ ] You can map an entity's fields/annotations to table columns
- [ ] You can translate a derived method name into SQL
- [ ] You can explain where the repository implementation comes from
- [ ] You can describe how the same code targets H2 and PostgreSQL
