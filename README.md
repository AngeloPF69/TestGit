# computercraft turtle lua improved commands.
<p id="top"></p>

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
    
    -------------------------------------------------
    Table of recipes properties.
    tRecipes = {} --["Name"] = {recipe = {{sItemName = "itemName"}, {sItemName = "itemName", { nCol = nColumn, nLin = nLine}}, ..., },
                                          count = resulting number of items, CSlot = number crafting slot}
            
## Initialize

  INIT() Loads tTurtle.txt, tRecipes.txt from files to tables.
	
## Terminate

  TERMINATE() Saves tTurtle, tRecipes to text files.
  
## Measurements

   <a href="#addSteps">addSteps(nSteps) Adds nSteps to coords of turtle.</a><br>
   <a href="#distTo">distTo(x, y, z) Gets the three components of the distance from the turtle to point.</a>
    
## Turtle

   <a href="#loadTurtle">loadTurtle() Loads tTurtle from file tTurtle.txt.</a><br>
   <a href="#saveTurtle">saveTurtle() Saves tTurtle to file tTurtle.txt.</a>
    
## Turtle facing

   <a href="#decFacing">decFacing(nTurns) Decrements tTurtle.facing by nTurns.</a><br>
   <a href="#getFacing">getFacing() Returns tTurtle.facing.</a><br>
   <a href="#incFacing">incFacing(nTurns) Increments tTurtle.facing by nTurns.</a><br>
   <a href="#setFacing">setFacing(sFacing) Sets tTurtle.facing.</a>
    
## Turtle coords

   <a href="#getCoords">getCoords() Gets coords from turtle.</a><br>
   <a href="#setCoords">setCoords(x, y, z) Set coords x, y, z for turtle.</a>

## Equip
  
   <a href="#equip">equip(Side) Equip tool from the selected slot.</a><br>
   <a href="#getFreeHand">getFreeHand() Gets turtle free hand: "left"|"right"|false.</a>
    
## Fuel

   <a href="#refuel">refuel([nItems=stack]) Refuels the turtle with nItems.</a>

## General

   <a href="#checkType">checkType(sType, ...) Checks if parameters are from sType.</a><br>
   <a href="#getParam">getParam(sParamOrder, tDefault, ...) Sorts parameters by type.</a><br>
   <a href="#isKey">isKey(Key, t) Checks if Key is in t table.</a><br>
   <a href="#isValue">isValue(value, t) Checks if value is in t table.</a><br>
   <a href="#loadTable">loadTable(sFileName) Loads a text file into a table.</a><br>
   <a href="#saveTable">saveTable(t, sFileName) Saves a table into a text file.</a><br>
   <a href="#sign">sign(value) Returns: -1 if value < 0, 0 if value == 0, 1 if value > 0</a><br>
   <a href="#tableInTable">tableInTable(tSearch, t) Verifies if tSearch is in table t.</a>

## Attack

   <a href="#attackDir">attackDir([sDir="forward"]) Turtle attack in sDir direction {"forward", "right", "back", "left", "up", "down"}</a>

## Recipes

   <a href="#getFirstItemCoords">getFirstItemCoords(sRecipe) Returns the column and line=0 of the first item in the recipe.</a><br>
   <a href="#getInvRecipe">getInvRecipe() Builds a table with items and their position (the recipe).</a><br>
   <a href="#getMaxCraft">getMaxCraft() Returns maximum limit to craft the recipe on inventory.</a><br>
   <a href="#loadRecipes">loadRecipes() Loads tRecipes from file "tRecipes.txt".</a><br>
   <a href="#saveRecipes">saveRecipes() Saves tRecipes in a file as "tRecipes.txt".</a><br>
   <a href="#setCraftSlot">setCraftSlot(nSlot) Sets the craft resulting slot, in tRecipes CSlot.</a>
    
## Rotations
  
    turnBack() The turtle turns back.
    turnDir([Direction="back"]) Rotates turtle back, left or right.
    
## Moving
  
    back([Blocks=1]) Moves the turtle backwards or forward blocks.
    down([Blocks=1]) Moves the turtle down or up blocks.
    forward([Blocks=1]) Moves the turtle forward or backwards blocks.
    up([Blocks=1]) Moves the turtle up or down blocks.
  
## Rotations and Moving
  
    go([sDir="forward", [Blocks=1]) Turtle advances blocks, in sDir { "forward", "right", "back", "left", "up", "down" }.
    goBack([Blocks=1]) Rotates turtle back or not, and moves blocks forward.
    goLeft([Blocks=1]) Rotates turtle to the left or right, and moves blocks forward.
    goRight([Blocks=1]) Rotates turtle to the right or left, and moves blocks forward.

## Dig
  
    dig([Blocks=1]) Dig Blocks forward or backwards with equiped tool.
    digAbove([Blocks=1]) Dig Blocks forward or backwards, 1 block above the turtle, with equiped tool.
    digBack([Blocks=1]) Rotates turtle back or not, and dig Blocks forward.
    digBelow([Blocks=1]) Dig Blocks forward or backwards, 1 block below the turtle, with equiped tool.
    digDir(sDir, nBlocks) Turtle digs in sDir direction nBlocks.
    digDown([Blocks=1]) Dig Blocks downwards or upwards with equiped tool.
    digLeft([Blocks=1]) Rotates turtle left or right, and dig Blocks forward with equiped tool.
    digRight([Blocks=1]) Rotates turtle Right or left, and dig Blocks forward with equiped tool.
    digUp([Blocks=1]) Dig Blocks upwards or downwards with equiped tool.

## Drop

    drop([Blocks=stack]) Drops Blocks from selected slot and inventory in the world in front of the turtle.
    dropBack([nBlocks=stack]) Rotate back and drops or sucks nBlocks forward.
    dropDir(sDir, [Blocks=stack]) Drops Blocks from selected slot and inventory in the world in front, up or down the turtle.
    dropDown([Blocks=stack]) Drops nBlocks from selected slot and inventory in the world downwards.
    dropLeft([nBlocks=stack]) Rotate left and drops or sucks nBlocks forward.
    dropRight([nBlocks=stack]) Rotate right and drops or sucks nBlocks forward.
    dropUp([Blocks=stack]) Drops Blocks from selected slot and inventory in the world upwards.

## Place

    place([Blocks=1]) Places inventory selected Blocks in a strait line forward or backwards, and returns to initial position.
    placeAbove([Blocks=1]) places Blocks forwards or backwards, 1 block above the turtle, and returns to initial position.
    placeBelow([Blocks=1]) Places selected Blocks forwards or backwards, 1 block below the turtle, and returns to initial position.
    placeDir([sDir="forward"]) Places inventory selected Block in sDir { "forward", "right", "back", "left", "up", "down" }.
    placeDown([Blocks=1]) Places inventory selected Blocks in a strait line downward or upwards, and returns to initial position.
    placeLeft([Blocks=1]) Rotates turtle left or right, places inventory selected Blocks forward, and returns to initial position.
    placeRight([Blocks=1]) Rotates turtle Right or left, places inventory selected Blocks forward, and returns to initial position.
    placeUp([Blocks=1]) Places inventory selected Blocks in a strait line upward or downwards, and returns to initial position.

## Detect

    detectAbove([Blocks=1]) Detects if exits Blocks above the turtle in a strait line forward or backwards.
    detectBelow([Blocks=1]) Detects if exits Blocks below the turtle in a strait line forward or backwards.
    detectDir(sDir) Detects if is a block in sDir direction {"forward", "right", "back", "left", "up", "down" }.

## Disk

    fsGetFreeSpace() Gets the total free space on disk.
		
## Inspect

    inspectDir([sDir="forward]) Turtle inspect block in sDir direction {"forward", "right", "back", "left", "up", "down"}.

## Compare

    compareAbove([Blocks=1]) Compare blocks above the turtle in a strait line with selected slot.
    compareBelow([Blocks=1]) Compare blocks below the turtle in a strait line with selected slot.
    compareDir([sDir="forward"][, nSlot=selected slot]) Compares item in slot with block in sDir direction.

## Inventory
    
    clearSlot(nSlot) Clears content of slot, moving items to another slot.
    decSlot(nSlot) Decreases nSlot in range [1..16].
    freeCount() Get number of free slots in turtle's inventory.
    getFreeSlot(nStartSlot, bWrap) Get the first free slot, wrapig the search or not.
    groupItems() Groups the same type of items in one slot in inventory.
    incSlot(nSlot) Increases nSlot in range [1..16].
    itemCount([selected slot/slot/"inventory"/item name=Selected slot]) Counts items in slot, inventory.
    itemName([Slot=Selected slot]) Gets the item name from Slot.
    itemSelect([Slot/Item Name]) Selects slot [1..16] or first item with Item Name, or the turtle selected slot.
    itemSpace([slot/item Name=selected slot]) Get the how many items more you can store in inventory.
    search(sItemName, nStartSlot) Search inventory for ItemName, starting at startSlot.
    transferFrom(nSlot, nItems) Transfer nItems from nSlot to selected slot.
    
## Suck

    suckDir(sDir, nItems) Sucks or drops nItems into sDir direction {"forward", "right", "back", "left", "up", "down"}.
    
---------------------------------------------------------------------------------------------------------------------------

## Measurements

   <p id="addSteps"></p>
   
- addSteps(nSteps) Adds nSteps to coords of turtle.
    --------------------------------
    <pre>Sintax: addSteps([nSteps=1])
  Returns:  x, y, z adding nSteps in direction turtle is facing.
  ex: if tTurtle x=0, y=0, z=0, facing="x+"
  addSteps() - Returns 1,0,0.
  ex: addSteps(-1) - Returns -1,0,0.</pre>
  
   <p id="distTo"></p>

- distTo(x, y, z) Gets the three components of the distance from the turtle to point.<br>
    --------------------------------
    <pre>Sintax: distTo(x, y, z)
  Returns: distX, distY, distZ From turtle to point x, y, z.
  ex: if turtle x=0, y=0, z=0
  distTo(10,10,10) Returns 10, 10, 10</pre>

## Turtle

   <p id="loadTurtle">
     
- loadTurtle() Loads tTurtle from file tTurtle.txt.<br>
    -------------------------------- 
   <pre>Sintax: loadTurtle()
  Returns: true - if could load from file "tTurtle.txt" to tTurtle.
           false - if it couldn't.
  ex: loadTurtle()</pre>
  
   <p id="saveTurtle">
     
- saveTurtle() Saves tTurtle to file tTurtle.txt.<br>
    -------------------------------- 
   <pre>Sintax: saveTurtle()
  Returns: true - if could save tTurtle to file "tTurtle.txt".
           false - if it couldn't.
  ex: saveTurtle()</pre>
  
  
## Turtle facing

   <p id="decFacing"></p>
   
- decFacing(nTurns) Decrements tTurtle.facing by nTurns.<br>
    --------------------------------
    <pre>Sintax: decFacing([nTurns=1])
  Returns: true
  ex: if turtle is facing "x+"=1
  decFacing() Decrements 1 of value tTurtle.facing, turtle turns to "z-"=0</pre>
    
   <p id="getFacing"></p>
   
- getFacing() Returns tTurtle.facing.<br>
    --------------------------------
    <pre>Sintax: getFacing([nTurns=1])
  Returns: tTurtle.facing
  ex: getFacing()</pre>
    
   <p id="incFacing"></p>
   
- incFacing(nTurns) Increments tTurtle.facing by nTurns.<br>
    --------------------------------
    <pre>Sintax: incFacing([nTurns=1])
  Returns: true
  ex: if turtle is facing "x+"=1
  incFacing(1) - Increments tTurtle.facing </pre>
    
   <p id="setFacing"></p>
   
- setFacing(sFacing) Sets tTurtle.facing.<br>
    --------------------------------
    <pre>Sintax: setFacing(sFacing) - sFacing = {"z-"|"x+"|"z+"|"x-"|"y+"|"y-"}|[0..3]
  Returns:  tTurtle.facing
            false - if no parameter was supplied.
                  - if sFacing is not in facingType.
  ex: setFacing("z+") - Sets tTurtle.facing = 2
      setFacing(1) - sets tTurtle.facing = 1</pre>


## Turtle coords

   <p id="getCoords"></p>
     
- getCoords() Gets coords from turtle.<br>
    --------------------------------
    <pre>Sintax: getCoords()
  Returns: x,y,z the turtle coords.
  ex: getCoords() </pre>
     
   <p id="setCoords"></p>
      
- setCoords(x, y, z) Set coords x, y, z for turtle.<br>
    --------------------------------
    <pre>Sintax: setCoords(x, y, z)
  Returns: true
  ex: setCoords(1, 10, 14) Sets tTurtle.x = 1, tTurtle.y = 10, tTurtle.z = 14</pre>


## Equip
  
   <p id="equip"></p>
     
- equip(Side) Equip tool from the selected slot.<br>
    --------------------------------
    <pre>Sintax:equip([Side=free hand = {"left"|"right"}])
  Returns: true - if it was equiped.
           false - if no empty hand.
                 - if invalid parameter.
                 - if empty selected slot.
                 - if it can't equip tool.
  ex: equip("left") - Equips in the left hand, the tool in the selected slot.
      equip() - Equips in the first free hand the tool in the selected slot.</pre>
     
   <p id="getFreeHand"></p>

- getFreeHand() Gets turtle free hand: "left"|"right"|false.<br>
    --------------------------------
    <pre>Sintax: getFreeHand()
  Returns: "left" or "right" the first free hand found.
           false - if no free hand found.
  ex: getFreeHand()</pre>


## Fuel
  
   <p id="refuel"></p>

- refuel([nItems=stack]) Refuels the turtle with nItems.
    --------------------------------
    <pre>Sintax: refuel([nItems=all items in selected slot])
  Returns: number of items refueled.
           false - if empty selected slot
                 - if item is not fuel
                 - if turtle doesn't need fuel.
                 - if turtle is at maximum fuel.
  ex: refuel(10) - Refuels turtle with 10 items.</pre>

  
## General

  <p id="checkType"></p>
  
- checkType(sType, ...) Checks if parameters are from sType.</a><br>
    --------------------------------
    <pre>Sintax: checkType(sType, ...)
  Returns: true - if all parameters have the type of sType.
           false - if #sType ~= #... (number of parameters are diferent from length of sType).
  ex: checkType("snt", "hello", number1, tTable) - Outputs: true.</pre>
  
  <p id="getParam"></p>
  
- getParam(sParamOrder, tDefault, ...) Sorts parameters by type.</a><br>
    --------------------------------
    <pre>Sintax: getParam(sTypeParamOrder,{default parameter value,}, parameters ...}
  Returns: Parameters ordered by type.
           nil - if no parameters.
  Note: Only sorts three parameters type (string, number and boolean).
  ex: getParam("sns", {"default" }, number, string) - Outputs: string, number, default.</pre>
   
   <p id="isKey"></p>
   
- isKey(Key, t) Checks if Key is in t table.</a><br>
    --------------------------------
    <pre>Sintax: isKey(key, t)
  Returns: true - if Key is in t.
           false - if Key is not in t.
  ex: isKey("hello", {["hello"] = 2, ["hi"] = 4}) - Outputs: true.</pre>
  
   <p id="isValue"></p>
   
- isValue(value, t) Checks if value is in t table.</a><br>
    --------------------------------
    <pre>Sintax: isValue(value, t)
  Returns: true - if value is in t.
           false - if value is not in t.
  ex: isValue(2, {["hello"] = 2, ["hi"] = 4}) - Outputs: true.</pre>
  
   <p id="loadTable"></p>
   
- loadTable(sFileName) Loads a text file into a table.</a><br>
    --------------------------------
    <pre>Sintax: loadTable(sFileName)
  Returns: true - if could read a text file into a table.
           false - if sFileName is not supplied,
                 - if the file couldn't be opened for reading,
                 - if the file is empty.
  ex: loadTable("oneFile.txt") - Loads file "oneFile.txt" returns it as a table.</pre>
  
   <p id="saveTable"></p>
   
- saveTable(t, sFileName) Saves a table into a text file.</a><br>
    --------------------------------
    <pre>Sintax: saveTable(t, sFileName)
  Returns: true - if saving file was a success.
           false - if t or sFileName not supplied,
                 - if no disk space,
                 - if it couldn't create file.
  Note: if not supplied extension it adds ".txt" to the file name.
  ex: saveTable(oneTable, "oneFile") - Saves table oneTable into "oneFile.txt" file.</pre>
  
   <p id="sign"></p>
   
- sign(value) Returns: -1 if value < 0, 0 if value == 0, 1 if value > 0</a><br>
    --------------------------------
    <pre>Sintax: sign(value)
  Returns: -1 if value < 0, 0 if value == 0, 1 if value > 0
  ex: sign(-1) - Returns -1</pre>
  
  <p id="tableInTable"></p>
  
- tableInTable(tSearch, t) Verifies if tSearch is in table t.</a>
  --------------------------------
    <pre>Sintax: tableInTable(tSearch, t)
  Returns: true - tSearch is in t.
           false - at the least one element of tSearch is not in table t.
  ex: tableInTable("forward", {"forward", "left", "right"}) - Returns true.</pre>
  

## Attack

   <p id="attackDir"></p>

- attackDir([sDir="forward"]) Turtle attack in sDir direction {"forward", "right", "back", "left", "up", "down"}
    --------------------------------
    <pre>Sintax: attackDir([sDir="forward"])
  Returns: true if turtle attack something.
           false - if there is nothing to attack, or no weapon.
           nil - if invalid parameter.
  ex: attackDir() - Attacks forward.</pre>

  
## Recipes

  <p id="getFirstItemCoords"></p>
  
- getFirstItemCoords(sRecipe) Returns the column and line=0 of the first item in the recipe.
    --------------------------------
    <pre>Sintax: getFirstItemCoords(sRecipe)
  Returns: false - if the recipe name was not supplied.
                 - if this recipe does not exist.
           col, lin - the column and line of first item.
  ex: getFirstItemCoords("minecraft:stick") - Retuens the column and line of the turtle inventory, where to place the ingredients of recipe.</pre>
  
  <p id="getInvRecipe"></p>
  
- getInvRecipe() Builds a table with items and their position (the recipe).
    --------------------------------
    <pre>Sintax: getInvRecipe()
  Returns: false - if it is not a recipe in the inventory.
           tRecipe - the recipe with items and positions.
  Note: Trecipe[Ingredient number][Ingredient name] = if not first item {{col = column position, lin = line position (relative to 1st ingredient) }
  ex: getInvRecipe() - Returns the recipe in inventory.</pre>
  
  <p id="getMaxCraft"></p>
  
- getMaxCraft() Returns maximum limit to craft the recipe on inventory.
    --------------------------------
    <pre>Sintax: getMaxCraft()
  Returns: false - if it is not a recipe in the inventory.
           tRecipe - the recipe with items and positions.
  ex: getMaxCraft() - Returns the recipe from inventory.</pre>
  
  <p id="loadRecipes"></p>
  
- loadRecipes() Loads tRecipes from file "tRecipes.txt"
    --------------------------------
    <pre>Sintax: loadRecipes()
  Returns: false - if it couldn't load file.
           true - if it could load file.
  ex: loadRecipes()</pre>
  
  <p id="saveRecipes"></p>
  
- saveRecipes() Saves tRecipes in a file as "tRecipes.txt"
    --------------------------------
    <pre>Sintax: saveRecipes()
  Returns: false - if it couldn't load file.
           true - if it could load file.
  ex: saveRecipes()</pre>
  
  <p id="setCraftSlot"></p>
  
- setCraftSlot(nSlot) Sets the craft resulting slot, in tRecipes CSlot
    --------------------------------
    <pre>Sintax: setCraftSlot([nSlot=Selected Slot])
  Returns: nil - if nSlot is not in range[1..16].
           true - if was set tRecipes["CSlot"].
  ex: setCraftSlot(16) - Sets the resulting craft slot to 16.</pre>
  
   <a href="#top">Top of page</a>
