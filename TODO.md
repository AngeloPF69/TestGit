# computercraft turtle lua improved commands

improving commands in lua for computer craft turtle

### todo to version 0.1.0


- [ ] inspectLeft() rotate left and inspect block in front of turtle.
- [ ] inspectRight() rotate right and inspect block in front of turtle.
- [ ] inspectBack() rotate back and inspect block in front of turtle.
- [ ] getItemName([Slot=Selected slot]) gets the item name from Slot.

### OPTIONAL

- [x] sign(value) Returns: -1 if value < 0, 0 if value == 0, 1 if value > 0
- [x] isInTable(value, t) Verifies if value is in table t, value can be a table too.
- [x] getParam(sParamOrder, tDefault, ...) Sorts parameters by type.
- [x] checkType(sType, ...) Checks if parameters are from sType.
- [x] getDistTo(x, y, z) gets the three components of the distance from the turtle to point.
- [x] setCoords(x,y,z) sets coords x, y, z for turtle.
- [x] getCoords() gets coords from turtle.

### POSTPONED

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

- [ ] suckLeft([count]) rotate left and sucks count items in front of turtle.
- [ ] suckRight([count]) rotate left and sucks count items in front of turtle.
- [ ] suckBack([count]) rotate back and sucks count items in front of turtle.
- [ ] suckDir([sDir="forward"]) sucks items from sDir direction {"forward", "right", "back", "left", "up", "down"}.

### DONE

- [x] attackDir([sDir="forward"]) Turtle attack in sDir direction {"forward", "right", "back", "left", "up", "down"}.
- [x] attackLeft([Side]) rotate left and attack the entity in front.
- [x] attackRight([Side]) rotate right and attack the entity in front.
- [x] attackBack([Side]) rotate back and attack the entity in front.
- [x] compareAbove([Blocks=1]) compare blocks above the turtle in a strait line with selected slot.
- [x] compareBelow([Blocks=1]) compare blocks below the turtle in a strait line with selected slot.
- [x] detectAbove([Blocks=1]) detects if exits Blocks above the turtle in a strait line forward or backwards.
- [x] detectBelow([Blocks=1]) detects if exits Blocks below the turtle in a strait line forward or backwards.
- [x] detectDir([Direction="forward"]) detects if there is a block in Direction { "forward", "right", "back", "left", "up", "down" }.
- [x] itemCount([selected slot/slot/inventory/item name]) counts items in inventory.
- [x] itemSelect([Slot/Item Name]) selects slot [1..16] or first item with Item Name, or the turtle selected slot.
- [x] Search([ItemName[, StartSlot=Selected Slot]]) Search inventory for ItemName, starting at StartSlot. 
- [x] dropUp([Blocks]) drops all blocks from selected slot to inventory above, or in inventory ex: drop(197), drops 197 brocks of the same type from inventory.
- [x] dropDown([Blocks]) drops all blocks from selected slot to inventory below, or in inventory ex: drop(205), drops 205 brocks of the same type from inventory.
- [x] drop([Blocks]) drops all blocks from selected slot, or from inventory.
- [x] placeBelow([Blocks=1]) places inventory selected Blocks in a strait line 1 block below the turtle and forward, and returns to initial position.
- [x] placeAbove([Blocks=1]) places inventory selected Blocks in a strait line 1 block above the turtle and forward, and returns to initial position.
- [x] placeRight([Blocks=1]) rotates turtle Right, places inventory selected Blocks in a strait line forward, and returns to initial position.
- [x] placeLeft([Blocks=1]) rotates turtle left, places inventory selected Blocks in a strait line forward, and returns to initial position.
- [x] place([Blocks=1]) places inventory selected Blocks in a strait line forward.
- [x] placeDown([Blocks=1]) places inventory selected Blocks in a strait line downward, and returns to initial position.
- [x] placeUp([Blocks=1]) places inventory selected Blocks in a strait line upward, and returns to initial position.
- [x] placeDir([Direction="forward"]) places inventory selected Block in Direction { "forward", "right", "back", "left", "up", "down" }.
- [x] digBack([Blocks=1]) rotates turtle back and dig Blocks.
- [x] digAbove([Blocks=1]) dig Blocks, 1 block above the turtle, and forward.
- [x] digBelow([Blocks=1]) dig Blocks, 1 block below the turtle, and forward.
- [x] digUp([Blocks=1]) dig Blocks upwards.
- [x] digDown([Blocks=1]) dig Blocks downwards.
- [x] digRight([Blocks=1]) rotates turtle Right and dig Blocks forward.
- [X] digLeft([Blocks=1]) rotates turtle left and dig Blocks forward.
- [x] dig([Blocks=1]) dig Blocks forward with tool.
- [X] turn([Direction="back"]) rotates turtle back, left or right.
- [x] turnBack() Turtle turns back.
- [x] goBack([Blocks=1]) rotates turtle back, and moves blocks forward, until it hits something.
- [x] goRight([Blocks=1]) rotates turtle to the right, and moves blocks forward, until it hits something.
- [x] goLeft([Blocks=1]) rotates turtle to the left, and moves blocks forward, until it hits something.
- [x] down([Blocks=1]) moves the turtle down blocks, until it hits something.
- [x] up([Blocks=1]) moves the turtle up blocks, until it hits something.
- [x] back([Blocks=1]) moves the turtle backwards blocks, until it hits something.
- [x] forward([Blocks=1]) moves the turtle forward blocks, until it hits something.
