# computercraft turtle lua improved commands

improving commands in lua for computer craft turtle

### todo to version 0.1.0

- [ ] refuel([item Name/Slot=selected slot][, count=stack]) refuel the turtle with item name, item in slot, or item in selected slot.
- [ ] equip([sHand=empty][, item Name]) equip tool to left or right hand, from inventory or selected slot, with item Name.

### OPTIONAL

- [x] checkType(sType, ...) Checks if parameters are from sType.
- [x] getParam(sParamOrder, tDefault, ...) Sorts parameters by type.
- [x] tableInTable(tSearch, t) Verifies if tSearch is in table t.
- [x] sign(value) Returns: -1 if value < 0, 0 if value == 0, 1 if value > 0


### POSTPONED

- [x] setCoords(x,y,z) sets coords x, y, z for turtle. x
- [x] distTo(x, y, z) gets the three components of the distance from the turtle to point.
- [x] getCoords() gets coords from turtle.
- [ ] itemSpace(selected slot/slot/"inventory"/"itemName") get item space in selected slot, slot, or when specified "inventory" or "itemName" in all inventory.
- [ ] detectUp([Blocks=1]) detects if upwards the turtle are blocks in a strait line, stops when there isn't or blocked.
- [ ] detectDown([Blocks=1]) detects if downwards the turtle are blocks in a strait line, stops when there isn't or blocked.
- [ ] detectLeft([Blocks=1]) detects if on the left of the turtle are blocks in a strait line, stops when there isn't or blocked.
- [ ] detectRight([Blocks=1]) detects if on the right of the turtle are blocks in a strait line, stops when there isn't or blocked.
- [ ] detectBack([Blocks=1]) detects if on the turtle backs are blocks in a strait line, stops when there isn't or blocked.
- [ ] compare([Blocks=1]) compare blocks in front of turtle in a strait line with selected slot or inventory.
- [ ] compareUp([Blocks=1]) compare blocks upwards in a strait line with selected slot or inventory.
- [ ] compareDown([Blocks=1]) compare blocks downwards in a strsit line with selected slot or inventory.
- [ ] compareLeft([Blocks=1]) compare blocks left of the turtle in a strait line with selected slot or inventory.
- [ ] compareRight([Blocks=1]) compare blocks Right of the turtle in a strait line with selected slot or inventory.


### IN PROGRESS


### DONE

- [x] itemName([Slot=Selected slot]) gets the item name from Slot.
- [x] inspectDir([sDir="forward]) turtle inspect block in sDir direction {"forward", "right", "back", "left", "up", "down"}.
- [x] suckDir([sDir="forward"][,count=all the items]) sucks items from sDir direction {"forward", "right", "back", "left", "up", "down"}.
- [x] attackDir([sDir="forward"]) Turtle attack in sDir direction {"forward", "right", "back", "left", "up", "down"}.
- [x] compareAbove([Blocks=1]) compare blocks above the turtle in a strait line with selected slot.
- [x] compareBelow([Blocks=1]) compare blocks below the turtle in a strait line with selected slot.
- [x] detectAbove([Blocks=1]) detects if exits Blocks above the turtle in a strait line forward or backwards.
- [x] detectBelow([Blocks=1]) detects if exits Blocks below the turtle in a strait line forward or backwards.
- [x] detectDir([Direction="forward"]) detects if there is a block in Direction { "forward", "right", "back", "left", "up", "down" }.
- [x] itemCount([selected slot/slot/inventory/item name]) counts items in inventory.
- [x] itemSelect([Slot/Item Name]) selects slot [1..16] or first item with Item Name, or the turtle selected slot.
- [x] Search([ItemName[, StartSlot=Selected Slot]]) Search inventory for ItemName, starting at StartSlot. 
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
- [x] goDir([Direction="forward][, nBlocks]) turtle goes in Direction { "forward", "right", "back", "left", "up", "down" } nBlocks until blocked.
- [x] goLeft(nBlocks) turns left or  right if nBlocks <0, and advances nBlocks until blocked.
- [x] goRight(nBlocks) turns right or left if nBlocks < 0, and advances nBlocks until blocked.
- [x] goBack(nBlocks) turns back or not if nBlocks < 0, and advances nBlocks until blocked.
- [x] down([Blocks=1]) moves the turtle down blocks, until it hits something.
- [x] up([Blocks=1]) moves the turtle up blocks, until it hits something.
- [x] back([Blocks=1]) moves the turtle backwards blocks, until it hits something.
- [x] forward([Blocks=1]) moves the turtle forward blocks, until it hits something.
- [x] dropDir([sDir="forward"][, nBlocks=1]) drops nBlocks from selected slot and inventory in the world in front, up or down the turtle.
- [x] drop(nBlocks) drops nBlocks from selected slot and inventory in the world in front of the turtle.
- [x] dropUp(nBlocks) drops nBlocks from selected slot and inventory in the world upwards.
- [x] dropDown(nBlocks) drops nBlocks from selected slot and inventory in the world downwards.
