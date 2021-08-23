# computercraft turtle lua improved commands

improving commands in lua for computer craft turtle

### todo to version 0.1.0

- [ ] back([Blocks=1]) moves the turtle backwards blocks, until it hits something.
- [ ] up([Blocks=1]) moves the turtle up blocks, until it hits something.
- [ ] down([Blocks=1]) moves the turtle down blocks, until it hits something.
- [ ] goLeft([Blocks=1]) rotates turtle to the left, and moves blocks forward, until it hits something.
- [ ] goRight([Blocks=1]) rotates turtle to the right, and moves blocks forward, until it hits something.
- [ ] goBack([Blocks=1]) rotates turtle back, and moves blocks forward, until it hits something.
- [ ] turn([Direction="back"]) rotates turtle back, left or right.
- [ ] dig([Blocks=1]) dig Blocks forward.
- [ ] digLeft([Blocks=1]) rotates turtle left and dig Blocks forward.
- [ ] digRight([Blocks=1]) rotates turtle Right and dig Blocks forward.
- [ ] digUp([Blocks=1]) dig Blocks upwards.
- [ ] digDown([Blocks=1]) dig Blocks downwards.
- [ ] digAbove([Blocks=1]) dig Blocks, 1 block above the turtle, and forward.
- [ ] digBelow([Blocks=1]) dig Blocks, 1 block below the turtle, and forward.
- [ ] digBack([Blocks=1]) rotates turtle back and dig Blocks, and rotates turtle again forward.
- [ ] place([Blocks=1]) places inventory selected Blocks in a strait line forward.
- [ ] placeUp([Blocks=1]) places inventory selected Blocks in a strait line upward.
- [ ] placeDown([Blocks=1]) places inventory selected Blocks in a strait line downward.
- [ ] placeLeft([Blocks=1]) rotates turtle left, places inventory selected Blocks in a strait line forward.
- [ ] placeRight([Blocks=1]) rotates turtle Right, places inventory selected Blocks in a strait line forward.
- [ ] drop([Blocks=all]) drops all blocks from selected slot, or in inventory ex: drop(197), drops 197 brocks of the same type from inventory.
- [ ] dropUp([Blocks=all]) drops all blocks from selected slot to inventory above, or in inventory ex: drop(197), drops 197 brocks of the same type from inventory.
- [ ] dropDown([Blocks=all]) drops all blocks from selected slot to inventory below, or in inventory ex: drop(205), drops 205 brocks of the same type from inventory.
- [ ] select(Slot/Item Name) selects slot [1..16] or first item with Item Name.
- [ ] getItemCount(selected slot/slot/inventory) count the item in selected slot, in a slot from 1 to 16, or when specified "inventory" in all inventory.
- [ ] getItemSpace(selected slot/slot/inventory) get the item space in selected slot, in a slot from 1 to 16, or when specified "inventory" in all inventory.
- [ ] detect([Blocks=1]) detects if there is no blocks in a strait line forward, stops when there is.
- [ ] detectUp([Blocks=1]) detects if there is no blocks in a strait line upwards, stops when there is.
- [ ] detectDown([Blocks=1]) detects if there is no blocks in a strait line downwards, stops when there is.
- [ ] detectLeft([Blocks=1]) rotate turtle left and detects if there is no blocks in a strait line forward, stops when there is.
- [ ] detectRight([Blocks=1]) rotate turtle right and detects if there is no blocks in a strait line forward, stops when there is.
- [ ] detectAbove([Blocks=1]) detects if above the turtle is no blocks in a strait line forward, stops when there is.
- [ ] detectBelow([Blocks=1]) detects if below is no blocks in a strait line forward, stops when there is.
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

- [ ] forward([Blocks=1]) moves the turtle forward blocks, until it hits something.

### done
