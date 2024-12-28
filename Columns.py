import pandas as pd
from pandas import DataFrame

df = pd.read_csv('shopping_trends.csv')
print(df, "this works")

items = ['blouse', 'sweater', 'jeans', 'fsdfsdf', 'w4309jfls',
         'w4309jfls', 'w4309jfls', 'w4309jfls', 'w4309jfls']

print(df.columns)

item_purchased = df['Item Purchased'].str.strip().str.lower()

print(item_purchased, "this works >>>")

is_listed = []
not_listed = []
# the above is to start creating lists with items that are in the list and not in the list

for item in items:
    if item in item_purchased.values:
        is_listed.append(item)
    else:
        not_listed.append(item)

items_found = {'items found': [is_listed]}
items_not_found = {'items not found': [not_listed]}

itf = pd.DataFrame(items_found)
itnf = pd.DataFrame(items_not_found)

print("Items found:")
for item in is_listed:
    print(f"    {item}")

print("\n Items not found")
for item in not_listed:
    print(f"    {item}")
