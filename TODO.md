# computercraft turtle lua improved commands

improving commands in lua for computer craft turtle

### todo to version 0.1.0

<<<<<<< HEAD
- [ ] detect([Blocks=1]) detects if there is no blocks in a strait line forward, stops when there is.
- [ ] detectUp([Blocks=1]) detects if there is no blocks in a strait line upwards, stops when there is.
- [ ] detectDown([Blocks=1]) detects if there is no blocks in a strait line downwards, stops when there is.
- [ ] detectLeft([Blocks=1]) rotate turtle left and detects if there is no blocks in a strait line forward, stops when there is.
- [ ] detectRight([Blocks=1]) rotate turtle right and detects if there is no blocks in a strait line forward, stops when there is.
- [ ] detectAbove([Blocks=1]) detects if above the turtle is no blocks in a strait line forward, stops when there is.
- [ ] detectBelow([Blocks=1]) detects if below is no blocks in a strait line forward, stops when there is.
=======
- [ ] select(Slot/Item Name) selects slot [1..16] or first item with Item Name.
- [ ] getItemCount(selected slot/slot/inventory) count the item in selected slot, in a slot from 1 to 16, or when specified "inventory" in all inventory.

>>>>>>> 58cdbd24d02c6aee5bfc55dbfd9eb51d13ff6f12
- [ ] compare([Blocks=1]) compare blocks in front of turtle in a strait line with selected slot or inventory.
- [ ] compareUp([Blocks=1]) compare blocks upwards in a strait line with selected slot or inventory.
- [ ] compareDown([Blocks=1]) compare blocks downwards in a strsit line with selected slot or inventory.
- [ ] compareLeft([Blocks=1]) compare blocks left of the turtle in a strait line with selected slot or inventory.
- [ ] compareRight([Blocks=1]) compare blocks Right of the turtle in a strait line with selected slot or inventory.
- [ ] compareAbove([Blocks=1]) compare blocks above the turtle in a strait line with selected slot or inventory.
- [ ] compareBelow([Blocks=1]) compare blocks below the turtle in a strait line with selected slot or inventory.
- [ ] attackLeft([Side]) rotate left and attack the entity in front.
- [ ] attackRight([Side]) rotate right and attack the entity in front.
- [ ] attackBack([Side]) rotate back and attack the entity in front.
- [ ] suckLeft([count]) rotate left and sucks count items in front of turtle.
- [ ] suckRight([count]) rotate left and sucks count items in front of turtle.
- [ ] suckBack([count]) rotate back and sucks count items in front of turtle.
- [ ] inspectLeft() rotate left and inspect block in front of turtle.
- [ ] inspectRight() rotate right and inspect block in front of turtle.
- [ ] inspectBack() rotate back and inspect block in front of turtle.
- [ ] getItemName([Slot=Selected slot]) gets the item name from Slot.

### in progress

<<<<<<< HEAD
- [ ] itemSpace(selected slot/slot/inventory) get the item space in selected slot, in a slot from 1 to 16, or when specified "inventory" in all inventory.
=======
- [ ] detect([Blocks=1]) detects if there is blocks in a strait line forward, stops when there isn't.
- [ ] detectUp([Blocks=1]) detects if there is blocks in a strait line upwards, stops when there isn't.
- [ ] detectDown([Blocks=1]) detects if there is blocks in a strait line downwards, stops when there isn't.
- [ ] detectLeft([Blocks=1]) rotate turtle left and detects if there is blocks in a strait line forward, stops when there isn't.
- [ ] detectRight([Blocks=1]) rotate turtle right and detects if there is blocks in a strait line forward, stops when there isn't.
- [ ] detectAbove([Blocks=1]) detects if above the turtle is blocks in a strait line forward, stops when there isn't.
- [ ] detectBelow([Blocks=1]) detects if below is blocks in a strait line forward, stops when there isn't.
- [ ] getItemSpace(selected slot/slot/inventory) get the item space in selected slot, in a slot from 1 to 16, or when specified "inventory" in all inventory.
>>>>>>> 58cdbd24d02c6aee5bfc55dbfd9eb51d13ff6f12

### done

- [x] itemCount(selected slot/slot/inventory/item name) counts items in inventory.
- [x] select(Slot/Item Name) selects slot [1..16] or first item with Item Name.
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
- [x] placeDir(sDir) places inventory selected Block in sDir direction { "forward", "right", "back", "left", "up", "down" }.
- [x] digBack([Blocks=1]) rotates turtle back and dig Blocks.
- [x] digAbove([Blocks=1]) dig Blocks, 1 block above the turtle, and forward.
- [x] digBelow([Blocks=1]) dig Blocks, 1 block below the turtle, and forward.
- [x] digUp([Blocks=1]) dig Blocks upwards.
- [x] digDown([Blocks=1]) dig Blocks downwards.
- [x] digRight([Blocks=1]) rotates turtle Right and dig Blocks forward.
- [X] digLeft([Blocks=1]) rotates turtle left and dig Blocks forward.
- [x] dig([Blocks=1]) dig Blocks forward with tool.
- [X] turn([Direction="back"]) rotates turtle back, left or right.
- [x] turnBack() new function
- [x] goBack([Blocks=1]) rotates turtle back, and moves blocks forward, until it hits something.
- [x] goRight([Blocks=1]) rotates turtle to the right, and moves blocks forward, until it hits something.
- [x] goLeft([Blocks=1]) rotates turtle to the left, and moves blocks forward, until it hits something.
- [x] down([Blocks=1]) moves the turtle down blocks, until it hits something.
- [x] up([Blocks=1]) moves the turtle up blocks, until it hits something.
- [x] back([Blocks=1]) moves the turtle backwards blocks, until it hits something.
- [x] forward([Blocks=1]) moves the turtle forward blocks, until it hits something.
