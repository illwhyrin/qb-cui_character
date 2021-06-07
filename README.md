**In qb-interior/client/furnished.lua at line 188 replace:**

```TriggerEvent('qb-clothes:client:CreateFirstCharacter')```

with

```TriggerEvent('cui_character:open', { 'identity', 'features', 'style', 'apparel' }, false)```

**In qb-multicharacter/client/main.lua at line 114 replace:**

```TriggerEvent('qb-clothing:client:loadPlayerClothing', data, charPed)```

with

```TriggerEvent('cui_character:loadClothes', data, charPed)```
