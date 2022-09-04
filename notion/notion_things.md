# Notion "Mervin" Edition

## Property: `Due In`
1. Determine **if task is done yet**   
   `if(prop("Status") == "Completed", "Done"...`
2. Determine if the **Date Range field is empty**   
   `if(empty(dateBetween(end(prop("Date Range")), now(), "days")), "No Due Date Set"...`
3. Determine if the **due date has passed**   
   `if(dateBetween(end(prop("Date Range")), now(), "days") < 0, "OVERDUE", ...`
4. Display the calculated number of days between `today` and `the due date`.   
   `concat("Due in " + format(dateBetween(end(prop("Date Range")), now(), "days")) + " days")`

```text
if(prop("Status") == "Completed", "Done",
    if(empty(dateBetween(end(prop("Date Range")), now(), "days")), "No Due Date Set", 
        if(dateBetween(end(prop("Date Range")), now(), "days") < 0, "OVERDUE", 
            concat("Due in " + format(dateBetween(end(prop("Date Range")), now(), "days")) + " days")
        )
    )
)
```