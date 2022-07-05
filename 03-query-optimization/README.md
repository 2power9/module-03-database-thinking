# 03-Query Optimization

1. Add missing indexes

2. Check for unused indexes

3. Avoid using multiple `OR` in the `FILTER` predicate

4. Use wildcards at the end of a phrase only

5. Avoid too many `JOINs`

6. Avoid using `SELECT DISTINCT`

7. Use `SELECT <fields>` instead of `SELECT *`

8. Use `TOP` to sample query results

9. Run the query during off-peak hours

10. Minimize the usage of any query hint

11. Minimize large write operations

12. Create `JOINs` with `INNER JOIN` (not `WHERE`)

#### References

<https://blog.devart.com/how-to-optimize-sql-query.html>
