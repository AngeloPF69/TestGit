
# computercraft turtle lua improved commands.


## Settings

    Type of values:
    dirType = { ["forward"]=0, ["right"]=1, ["back"]=2, ["left"]=3, ["up"]=4, ["down"]=8 } --moving direction options
    lookingType = { ["forward"] = 0, ["up"] = 4, ["down"] = 8} --where is the turtle looking, it can't look to the sides or back.
    facingType = {["z-"]=0, ["x+"]=1, ["z+"]=2, ["x-"]=3, ["y+"]=4, ["y-"]=8}
    
    Table for turtle properties.
    tTurtle = { ["x"] = 0, ["y"] = 0, ["z"] = 0, --coords for turtle
			facing = facingType["z-"], --the axis where the turtle is facing at.
			leftHand = "empty",
			rightHand = "empty",
    }
    
    saveTurtle() Saves tTurtle to file tTurtle.txt.
    loadTurtle() Loads tTurtle from file tTurtle.txt.
    -------------------------------------------------
    Table of recipes properties.
    tRecipes = {} --["Name"] = {recipe = {{sItemName = "itemName"}, {sItemName = "itemName", { nCol = nColumn, nLin = nLine}}, ..., },
                                          count = resulting number of items, CSlot = number crafting slot}
    
    saveRecipes() Saves tRecipes in a file as "tRecipes.txt"
    loadRecipes() Loads tRecipes from file "tRecipes.txt"
    
## Initialize

  INIT() Loads tTurtle.txt, tRecipes.txt from files to tables.
	
## Terminate

  TERMINATE() Saves tTurtle, tRecipes to text files.
  
## Measurements

    addSteps(nSteps) Adds nSteps to coords of turtle.
    distTo(x, y, z) Gets the three components of the distance from the turtle to point.
    
## Turtle facing

    setFacing(sFacing) Sets tTurtle.facing.
    getFacing() Returns tTurtle.facing.
    incFacing(nTurns) Increments tTurtle.facing by nTurns
    decFacing(nTurns) Decrements tTurtle.facing by nTurns
    
## Turtle coords

    setCoords(x, y, z) Set coords x, y, z for turtle.
    getCoords() Gets coords from turtle.

## Equip:
  
    getFreeHand() Gets turtle free hand: "left"|"right"|false.
    equip(Side) Equip tool from the selected slot.
    
## Fuel:
  
    refuel([nItems=stack]) Refuels the turtle with nItems.
    
## General:

    saveTable(t, sFileName) Saves a table into a text file.
    loadTable(sFileName) Loads a text file into a table.
    isKey(Key, t) Checks if Key is in t table.
    isValue(value, t) Checks if value is in t table.
    checkType(sType, ...) Checks if parameters are from sType.
    getParam(sParamOrder, tDefault, ...) Sorts parameters by type.
    tableInTable(tSearch, t) Verifies if tSearch is in table t.
    sign(value) Returns: -1 if value < 0, 0 if value == 0, 1 if value > 0

## Attack:

    attackLeft([Side]) Rotate left and attack the entity in front.
    attackRight([Side]) Rotate right and attack the entity in front.
    attackBack([Side]) Rotate back and attack the entity in front.
    attackDir([sDir="forward"]) Turtle attack in sDir direction {"forward", "right", "back", "left", "up", "down"}
    
## Recipes

    getFirstItemCoords(sRecipe) Returns the column and line=0 of the first item in the recipe.
    getInvRecipe() Builds a table with items and their position (the recipe).
    getMaxCraft() Returns maximum limit to craft the recipe on inventory.
    setCraftSlot(nSlot) Sets the craft resulting slot, in tRecipes CSlot
    
## Rotations:
  
    turnBack() The turtle turns back.
    turnDir([Direction="back"]) Rotates turtle back, left or right.
    
## Moving:
  
    down([Blocks=1]) Moves the turtle down or up blocks.
    up([Blocks=1]) Moves the turtle up or down blocks.
    back([Blocks=1]) Moves the turtle backwards or forward blocks.
    forward([Blocks=1]) Moves the turtle forward or backwards blocks.
  
## Rotations and Moving:
  
    go([sDir="forward", [Blocks=1]) Turtle advances blocks, in sDir { "forward", "right", "back", "left", "up", "down" }.
    goBack([Blocks=1]) Rotates turtle back or not, and moves blocks forward.
    goRight([Blocks=1]) Rotates turtle to the right or left, and moves blocks forward.
    goLeft([Blocks=1]) Rotates turtle to the left or right, and moves blocks forward.

## Dig:
  
  	digDir(sDir, nBlocks) Turtle digs in sDir direction nBlocks.
    dig([Blocks=1]) Dig Blocks forward or backwards with equiped tool.
    digUp([Blocks=1]) Dig Blocks upwards or downwards with equiped tool.
    digDown([Blocks=1]) Dig Blocks downwards or upwards with equiped tool.
    digRight([Blocks=1]) Rotates turtle Right or left, and dig Blocks forward with equiped tool.
    digLeft([Blocks=1]) Rotates turtle left or right, and dig Blocks forward with equiped tool.
    digAbove([Blocks=1]) Dig Blocks forward or backwards, 1 block above the turtle, with equiped tool.
    digBelow([Blocks=1]) Dig Blocks forward or backwards, 1 block below the turtle, with equiped tool.
    digBack([Blocks=1]) Rotates turtle back or not, and dig Blocks forward.

## Drop:

    dropDir(sDir, [Blocks=stack]) Drops Blocks from selected slot and inventory in the world in front, up or down the turtle.
    drop([Blocks=stack]) Drops Blocks from selected slot and inventory in the world in front of the turtle.
    dropUp([Blocks=stack]) Drops Blocks from selected slot and inventory in the world upwards.
    dropDown([Blocks=stack]) Drops nBlocks from selected slot and inventory in the world downwards.
    dropLeft([nBlocks=stack]) Rotate left and drops or sucks nBlocks forward.
    dropRight([nBlocks=stack]) Rotate right and drops or sucks nBlocks forward.
    dropBack([nBlocks=stack]) Rotate back and drops or sucks nBlocks forward.

## Place:

    placeDir([sDir="forward"]) Places inventory selected Block in sDir { "forward", "right", "back", "left", "up", "down" }.
    place([Blocks=1]) Places inventory selected Blocks in a strait line forward or backwards, and returns to initial position.
    placeUp([Blocks=1]) Places inventory selected Blocks in a strait line upward or downwards, and returns to initial position.
    placeDown([Blocks=1]) Places inventory selected Blocks in a strait line downward or upwards, and returns to initial position.
    placeLeft([Blocks=1]) Rotates turtle left or right, places inventory selected Blocks forward, and returns to initial position.
    placeRight([Blocks=1]) Rotates turtle Right or left, places inventory selected Blocks forward, and returns to initial position.
    placeAbove([Blocks=1]) places Blocks forwards or backwards, 1 block above the turtle, and returns to initial position.
    placeBelow([Blocks=1]) Places selected Blocks forwards or backwards, 1 block below the turtle, and returns to initial position.

## Detect:

    detectDir(sDir) Detects if is a block in sDir direction {"forward", "right", "back", "left", "up", "down" }.
    detectAbove([Blocks=1]) Detects if exits Blocks above the turtle in a strait line forward or backwards.
    detectBelow([Blocks=1]) Detects if exits Blocks below the turtle in a strait line forward or backwards.

## Disk

		fsGetFreeSpace() Gets the total free space on disk.
		
## Inspect:

    inspectDir([sDir="forward]) Turtle inspect block in sDir direction {"forward", "right", "back", "left", "up", "down"}.

## Compare:

    compareDir([sDir="forward"][, nSlot=selected slot]) Compares item in slot with block in sDir direction.
    compareAbove([Blocks=1]) Compare blocks above the turtle in a strait line with selected slot.
    compareBelow([Blocks=1]) Compare blocks below the turtle in a strait line with selected slot.

## Inventory:
    
    incSlot(nSlot) Increases nSlot in range [1..16].
    decSlot(nSlot) Decreases nSlot in range [1..16].
    freeCount() Get number of free slots in turtle's inventory.
    getFreeSlot(nStartSlot, bWrap) Get the first free slot, wrapig the search or not.
    groupItems() Groups the same type of items in one slot in inventory.
    clearSlot(nSlot) Clears content of slot, moving items to another slot.
    itemSpace([slot/item Name=selected slot]) Get the how many items more you can store in inventory.
    itemCount([selected slot/slot/"inventory"/item name=Selected slot]) Counts items in slot, inventory.
    itemName([Slot=Selected slot]) Gets the item name from Slot.
    itemSelect([Slot/Item Name]) Selects slot [1..16] or first item with Item Name, or the turtle selected slot.
    search(sItemName, nStartSlot) Search inventory for ItemName, starting at startSlot.
    transferFrom(nSlot, nItems) Transfer nItems from nSlot to selected slot.
    
## Suck

		suckDir(sDir, nItems) Sucks or drops nItems into sDir direction {"forward", "right", "back", "left", "up", "down"}.
