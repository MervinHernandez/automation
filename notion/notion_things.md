# Notion "Mervin" Edition

## Property: `Due In`
1. Determine if the `Date Range` field is empty, if so then display `No Due Date Set`.
2. Determine if the due date has passed, if so then display `OVERDUE`.
3. Display the calculated days between `today` and `the due date`.

```text
if(empty(dateBetween(end(prop("Date Range")), now(), "days")), "No Due Date Set", 
    if(dateBetween(end(prop("Date Range")), now(), "days") < 0, "OVERDUE", 
        concat("Due in " + format(dateBetween(end(prop("Date Range")), now(), "days")) + " days")
    )
)
```