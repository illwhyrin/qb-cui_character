In qb-interior/client/furnished.lua at line 188 replace:

```TriggerEvent('qb-clothes:client:CreateFirstCharacter')```

with

```TriggerEvent('cui_character:open', { 'identity', 'features', 'style', 'apparel' }, false)```
