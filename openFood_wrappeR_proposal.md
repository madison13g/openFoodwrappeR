# Template for the Project Proposal

## Group information
- openFood_wrappeR
- Madison Greenough, Ricky Heinrich, Jonah Edmundson

## Description and Motivation of the API
- The [Open Food Facts](https://world.openfoodfacts.org/) database contains nutrition information on a vast array of food items. Examples of data points include keywords, category, calories, and sugars, [among others](https://world.openfoodfacts.org/api/v0/product/737628064502.json).

API calls are very simple, and are made by food product barcode:
> `https://world.openfoodfacts.org/api/v0/product/[barcode].json`

XML can also be requested by replacing the `.json` with `.xml`.

## Intended users and outcome
- Intended users include those people interested in researching or knowing more about the food they are consuming. For example, machine learning applications are not difficult to imagine: an ideal diet could be determined by setting certain fixed criterion (X grams daily protein, Y grams daily carbs, etc.) and then asking the algorithm to minimize on sugar and fat variables.
- Generally speaking, API wrappers increase the ease by which a database is queried. This is also the main goal of the present project. Secondary functions that facilitate data point comparison may also be included (ex. standardizing nutrient weight value to 100g serving).

## Proposed Functions
- Output nutrition information graph in the format of a traditional nutrition label
- Allergen search (for things with and without specific allergens)
- Search by availability of food products in specific country
- Search for specific nutrition information filtered by brand, product type, allergens, etc.
- Sort by nutrition information (healthy options)
- Type in a product name, and n results will populate (potential webscraping)
- Filtering by nutrition score and ranking alternatives
- View product image
