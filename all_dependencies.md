### Oracle: Bestimmung der Create Reihenfolge für Views über Dependencies

compute view order, where depended view appear before using view:
```sql
with x (iter, owner, object_name) as
( select 1 , o.owner, o.object_name from all_objects o where object_type = 'VIEW' and owner = 'QQRPAASDB'
  and not exists (select 1 from ALL_DEPENDENCIES d where type like 'VIEW'
        and referenced_type = 'VIEW' and referenced_owner = o.owner
        and d.owner = o.owner and o.object_name=d.name)
union all
  select iter + 1, d.owner, d.name from ALL_DEPENDENCIES d
     join x on d.referenced_owner = x.owner and d.referenced_name = x.object_name
    where type like 'VIEW' and referenced_type = 'VIEW'
)
select max(iter) iter, owner, object_name from x
group by owner, object_name
order by iter asc, 2, 3
  ;
```

