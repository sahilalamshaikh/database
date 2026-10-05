# Transactions

A transaction groups related database operations into one logical unit. It
helps ensure that a change is applied completely or not at all, even when an
operation fails.

## ACID properties

- **Atomicity:** all operations in the transaction succeed, or their changes
  are rolled back.
- **Consistency:** committed changes preserve the database's declared rules.
- **Isolation:** concurrent transactions are controlled so they do not
  observe or cause unacceptable interference.
- **Durability:** committed changes survive failures according to the
  database's guarantees.

These properties describe goals; exact behavior depends on engine settings,
storage, and transaction isolation level.

## Commit and rollback

A transfer illustrates why multiple statements may need to form one unit:

```sql
BEGIN;

UPDATE account
SET balance = balance - 50
WHERE account_id = 1;

UPDATE account
SET balance = balance + 50
WHERE account_id = 2;

COMMIT;
```

If a step fails or a business rule is violated, the application can issue
`ROLLBACK` instead of `COMMIT`. A real transfer should also check that the
source account exists and has sufficient funds, and should verify that the
expected rows were updated.

## Isolation and concurrency

Concurrent transactions can encounter phenomena such as dirty reads, non-repeatable
reads, and phantom rows. Isolation levels specify which phenomena an engine
prevents or permits. Stronger isolation can reduce anomalies but may increase
blocking, retries, or other costs.

Applications should keep transactions focused and short. Long-running
transactions hold resources and can delay other work. When a transaction may
be retried after a conflict, its operations should be designed to be safe to
retry.

## Check your understanding

1. What does atomicity promise if the second update in a transfer fails?
2. How does isolation relate to concurrent transactions?
3. Why should transactions generally be kept short?