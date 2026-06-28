# M00 Lab — Understand It Path

> **Module:** M00 · Course Orientation & Setup  
> **Track:** Orientation  
> **Time:** ~20 minutes

---

## Goal

Get your development environment ready and verify everything works
before starting Module 01.

---

## Part 1: Install & Verify (10 min)

Run each command and confirm the output:

```powershell
# JDK 21
java --version
# Expected: openjdk 21.x.x

# Node.js (for validation scripts)
node --version
# Expected: v20.x.x or v22.x.x

# Docker
docker --version
# Expected: Docker version 2x.x.x

# Git
git --version
# Expected: git version 2.x.x
```

---

## Part 2: Explore the Domain (10 min)

Answer these questions about the Prior Authorization domain (reference M00 content):

1. What are the four core entities in the Prior Authorization Service?
2. What does the `status` field on a PriorAuthRequest represent? What values can it have?
3. Why is the `cptCode` on a RequestedService important when a payer reviews medical necessity?
4. In the entity relationship diagram, what is the cardinality between PriorAuthRequest and Patient?

---

## You'll know it worked when:

- [ ] JDK 21 is installed and `java --version` returns 21.x
- [ ] Docker Desktop is running
- [ ] You can explain what a prior authorization is and name the four core entities
- [ ] The course player opens in your browser with M00 visible
