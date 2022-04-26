# computercraft turtle lua improved commands

improving commands in lua for computer craft turtle.

## TODO TO VERSION 0.3.0

- [ ] refuel(quantity of fuel/item Name)
- [ ] checkfuel(nActions) check if the fuel is enough for that action.

## TODO TO VERSION 0.2.0

### OPTIONAL

- [x] flattenInventory() averages all the item stacks in inventory.
- [x] calcAverage(tSlots, tIng) builds a table with item and average between items and slots.
- [x] recipeSlots(sRecipe) builds a table with item and quantity of slots ocupied by the recipe.
- [x] leaveItems(sItemName, nQuant, bWrap) leaves nQuant of item in Selected Slot, moving item from or to another slot.
- [x] searchSpace(sItemName, nStartSlot, bWrap) search for space in a slot that has sItemName.
- [x] haveIngredients(sRecipe, nLimit) builds a table with the diference between the recipe and the inventory.
- [x] ingredients(sRecipe) builds a table with items and quantities in a recipe.
- [x] invIngredients() builds a table with the items and quantities in inventory.
- [x] invLowerStack(sItem) returns the lower stack of items in inventory, the slot and the name of item.
- [x] saveTable(t, sFileName) saves a table into a text file.
- [x] loadTable(sFileName) loads a text file into a table.
- [x] isValue(value, t) checks if value is in t table.

### POSTPONED

### IN PROGRESS


### DONE

- [x] fsGetFreeSpace() gets the total free space on disk.
- [x] selectFreeSlot(nStartSlot, bWrap) selects the first free slot starting at nStartSlot, and if the search wraps or not.
- [x] itemCount(nSlot) counts items in inventory
- [x] isEmptySlot(nSlot) checks if nSlot is empty.
- [x] incSlot(nSlot, bWrap) increases nSlot in range [1..16].
- [x] decSlot(nSlot, bWrap) decreases nSlot in range [1..16].
- [x] getInventory() builds a table with the slot, the name and quantity of items in inventory.
- [x] countItemSlots() counts how many slots is ocupied with each item.
- [x] ingDontBelong(sRecipe) checks if all the items in inventory belong to a recipe.
- [x] setCraftSlot(nSlot) sets the craft resulting slot, in tRecipes CSlot
- [x] arrangeRecipe(sRecipe) arranges items in inventory to craft a recipe.
- [x] transferFrom(nSlot, nItems) transfer nItems from nSlot to selected slot.
- [x] INIT() loads tables from text files.
- [x] TERMINATE() saves tables to text files.
- [x] setStack(sItemName, nStack) sets the item stack value in tStacks.
- [x] getStack(nSlot/sItemName) returns how many items can stack.
- [x] loadStacks() loads tStacks.txt to tStacks.
- [x] saveStacks() saves tStacks to tStacks.txt
- [x] setCoords(x,y,z) sets coords x, y, z for turtle. x
- [x] distTo(x, y, z) gets the three components of the distance from the turtle to point.
- [x] getCoords() gets coords from turtle.
- [x] craftRecipe(\[sRecipeName=lastRecipe\]\[, limit=64\]) craft a recipe limit number of times.
- [x] addSteps(\[nSteps=1\]) adds nSteps to coords of turtle.
- [x] freeCount() get free slots in turtle's inventory.
- [x] getFreeSlot(nStartSlot) get the first free slot.
- [x] groupItems() groups the same type of items in one slot in inventory.
- [x] incFacing(nTurns) increments tTurtle.facing by nTurns
- [x] decFacing(nTurns) decrements tTurtle.facing by nTurns
- [x] saveRecipes() saves tRecipes in a file as "tRecipes.txt"
- [x] loadRecipes() loads tRecipes from file "tRecipes.txt"
- [x] clearSlot(nSlot) clears content of slot, moving items to another slot.
- [x] getFirstItemCoords(sRecipe) returns the column and line=0 of the first item in the recipe.
- [x] getMaxCraft() returns maximum limit to craft the recipe on inventory.
- [x] getInvRecipe() builds a table with items and their position (the recipe).
- [x] setFacing(sFacing) sets tTurtle.facing.
- [x] getFacing() returns tTurtle.facing.
- [x] saveTurtle() saves tTurtle to file tTurtle.txt.
- [x] loadTurtle() loads tTurtle from file tTurtle.txt.
- [x] getFreeHand() gets turtle free hand: "left"|"right"|false.
- [x] all base movement functions (forward, up, down, back) must change the coords in tTurtle.
  - [x] down([Blocks=1]) moves the turtle down blocks, until it hits something.
  - [x] up([Blocks=1]) moves the turtle up blocks, until it hits something.
  - [x] back([Blocks=1]) Moves the turtle backwards or forward blocks, until blocked.
  - [x] forward([Blocks=1]) Moves nBlocks forward or backwards, until blocked.
  
- [x] All base rotation functions (turn left and right) must update tTurtle.facing.
  - [x] turnDir([Direction="back"]) rotates turtle back, left or right.
- [x] setCoords(x,y,z) sets coords x, y, z for turtle. x
- [x] distTo(x, y, z) gets the three components of the distance from the turtle to point.
- [x] getCoords() gets coords from turtle.

## TODO TO VERSION 0.1.0

### OPTIONAL

- [x] isKey(Key, t) Checks if Key is in t table.
- [x] checkType(sType, ...) Checks if parameters are from sType.
- [x] getParam(sParamOrder, tDefault, ...) Sorts parameters by type.
- [x] tableInTable(tSearch, t) Verifies if tSearch is in table t.
- [x] sign(value) Returns: -1 if value < 0, 0 if value == 0, 1 if value > 0

### POSTPONED

- [ ] detectUp([Blocks=1]) detects if upwards the turtle are blocks in a strait line, stops when there isn't or blocked.
- [ ] detectDown([Blocks=1]) detects if downwards the turtle are blocks in a strait line, stops when there isn't or blocked.
- [ ] detectLeft([Blocks=1]) detects if on the left of the turtle are blocks in a strait line, stops when there isn't or blocked.
- [ ] detectRight([Blocks=1]) detects if on the right of the turtle are blocks in a strait line, stops when there isn't or blocked.
- [ ] detectBack([Blocks=1]) detects if on the turtle backs are blocks in a strait line, stops when there isn't or blocked.

- [ ] compareUp([Blocks=1]) compare blocks upwards in a strait line with selected slot or inventory.
- [ ] compareDown([Blocks=1]) compare blocks downwards in a strsit line with selected slot or inventory.
- [ ] compareLeft([Blocks=1]) compare blocks left of the turtle in a strait line with selected slot or inventory.
- [ ] compareRight([Blocks=1]) compare blocks Right of the turtle in a strait line with selected slot or inventory.

### IN PROGRESS

### DONE

- [x] refuel(\[nItems=stack\]) refuels the turtle with nItems.
- [x] itemSpace(\[slot/item Name=selected slot\]) get the how many items more you can store in inventory.
- [x] equip(\[side=empty hand\]) equip tool to left or right hand, from selected slot.
- [x] itemName([Slot=Selected slot]) gets the item name from Slot.
- [x] inspectDir([sDir="forward]) turtle inspect block in sDir direction {"forward", "right", "back", "left", "up", "down"}.
- [x] suckDir([sDir="forward"][,count=all the items]) sucks items from sDir direction {"forward", "right", "back", "left", "up", "down"}.
- [x] attackDir([sDir="forward"]) Turtle attack in sDir direction {"forward", "right", "back", "left", "up", "down"}.
- [x] compareDir([sDir="forward"][, nSlot=selected slot]) Compares item in slot with block in sDir direction.
- [x] compareAbove([Blocks=1]) compare blocks above the turtle in a strait line with selected slot.
- [x] compareBelow([Blocks=1]) compare blocks below the turtle in a strait line with selected slot.
- [x] detectAbove([Blocks=1]) detects if exits Blocks above the turtle in a strait line forward or backwards.
- [x] detectBelow([Blocks=1]) detects if exits Blocks below the turtle in a strait line forward or backwards.
- [x] detectDir([Direction="forward"]) detects if there is a block in Direction { "forward", "right", "back", "left", "up", "down" }.
- [x] itemCount([selected slot/slot/inventory/item name]) counts items in inventory.
- [x] itemSelect([Slot/Item Name]) selects slot [1..16] or first item with Item Name, or the turtle selected slot.
- [x] search([ItemName[, StartSlot=Selected Slot]]) Search inventory for ItemName, starting at StartSlot. 
- [x] placeBelow([Blocks=1]) places inventory selected Blocks in a strait line 1 block below the turtle and forward, and returns to initial position.
- [x] placeAbove([Blocks=1]) places inventory selected Blocks in a strait line 1 block above the turtle and forward, and returns to initial position.
- [x] placeRight([Blocks=1]) rotates turtle Right, places inventory selected Blocks in a strait line forward, and returns to initial position.
- [x] placeLeft([Blocks=1]) rotates turtle left, places inventory selected Blocks in a strait line forward, and returns to initial position.
- [x] place([Blocks=1]) places inventory selected Blocks in a strait line forward.
- [x] placeDown([Blocks=1]) places inventory selected Blocks in a strait line downward, and returns to initial position.
- [x] placeUp([Blocks=1]) places inventory selected Blocks in a strait line upward, and returns to initial position.
- [x] placeDir([Direction="forward"]) places inventory selected Block in Direction { "forward", "right", "back", "left", "up", "down" }.
- [x] digBack([Blocks=1]) rotates turtle back or not and dig Blocks forward.
- [x] digAbove([Blocks=1]) dig Blocks, 1 block above the turtle, and forward or backwards.
- [x] digBelow([Blocks=1]) dig Blocks, 1 block below the turtle, and forward or backwards.
- [x] digUp([Blocks=1]) dig Blocks upwards or downwards.
- [x] digDown([Blocks=1]) dig Blocks downwards or upwards.
- [x] digRight([Blocks=1]) rotates turtle Right or left and dig Blocks forward with tool.
- [X] digLeft([Blocks=1]) rotates turtle left or right and dig Blocks forward with tool.
- [x] dig([Blocks=1]) dig Blocks forward or backwards with tool.
- [x] digDir([Direction="forward"][, Blocks=1]) turtle digs in Direction direction Blocks.
- [X] turnDir([Direction="back"]) rotates turtle back, left or right.
- [x] turnBack() Turtle turns back.
- [x] goDir([Direction="forward][, nBlocks]) turtle goes in Direction { "forward", "right", "back", "left", "up", "down" } nBlocks until blocked.
- [x] goLeft(nBlocks) turns left or  right if nBlocks <0, and advances nBlocks until blocked.
- [x] goRight(nBlocks) turns right or left if nBlocks < 0, and advances nBlocks until blocked.
- [x] goBack(nBlocks) turns back or not if nBlocks < 0, and advances nBlocks until blocked.
- [x] down([Blocks=1]) moves the turtle down blocks, until it hits something.
- [x] up([Blocks=1]) moves the turtle up blocks, until it hits something.
- [x] back([Blocks=1]) Moves the turtle backwards or forward blocks, until blocked.
- [x] forward([Blocks=1]) Moves nBlocks forward or backwards, until blocked.
- [x] dropDir([sDir="forward"][, nBlocks=stack of items]) drops nBlocks from selected slot and inventory in the world in front, up or down the turtle.
- [x] drop(nBlocks) drops nBlocks from selected slot and inventory in the world in front of the turtle.
- [x] dropUp(nBlocks) drops nBlocks from selected slot and inventory in the world upwards.
- [x] dropDown(nBlocks) drops nBlocks from selected slot and inventory in the world downwards.
- [x] dropLeft(nBlocks) Rotate left and drops or sucks nBlocks forward.
- [x] dropRight(nBlocks) Rotate right and drops or sucks nBlocks forward.
- [x] dropBack(nBlocks) Rotate back and drops or sucks nBlocks forward.
