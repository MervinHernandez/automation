# Household Automations

## [WIP] Pantry Inventory

### 1. Record Purchases
1. Scan an item's bar code
2. Enter a price
3. Enter a quantity
4. Enter a sale (Example: 3x for $ 5)

### 2. Inventory
1. Search for barcode on the internet
   1. Query Data
   ```
   Method 1 - BarCode Spider   
   via curl https://www.barcodespider.com/071537001204 -o 071537001204.txt
   and save the output of the query to a file
   
   Method 2 - UPC Item DB 
   via curl https://www.upcitemdb.com/upc/77745291864 -o 77745291864.txt   
   and save the output of the query to a file
   
   Method 3 - UPC Index
   via curl https://www.upcindex.com/77745291864 -o 77745291864.txt    
   ```
   2. Save to a file
   3. Look for "associated with"
   4. Grab the contents of the "<h2>" following that text string
2. Retrieve metadata
   1. Item Name
   2. Item Unit (size)
   3. Item Size
   4. Item Category
   5. Item Brand
3. Enter information into My Database (datestamped)

### 3. Inventory Report
1. Spit out report of what is in the pantry

### 4. Usage of Items
1. Record use (or exhausted) item
2. Ask whether to log for future purchase