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
    tRecipes = {} --["Name"] = {{ {"itemName", "itemName", ...}, {"itemName", itemName, ..., nCol = nColumn, nLin = nLine}}, ..., },
                                          count = resulting number of items}
                  -- ["CSlot] = number crafting slot.
                  -- ["lastRecipe"] = Last recipe name.

    -------------------------------------------------
    Table of items stack.
    tStacks = {} --["itemName"] = nStack
            
## Initialize

  <a href="#INIT">INIT() Loads tTurtle.txt, tRecipes.txt, tStacks.txt from files to tables.</a>
	
## Terminate

  <a href="#TERMINATE">TERMINATE() Saves tTurtle, tRecipes, tStacks to text files.</a>
  
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
   <a href="#setFacing">setFacing(sFacing) Sets tTurtle.facing. sFacing= "z-"|"x+"|"z+"|"x-"|"y+"|"y-"|[0..3]</a>
    
## Turtle coords

   <a href="#getCoords">getCoords() Gets coords from tTurtle.</a><br>
   <a href="#setCoords">setCoords(x, y, z) Set coords x, y, z for tTurtle.</a>

## Equip
  
   <a href="#equip">equip(Side) Equip tool from the selected slot.</a><br>
   <a href="#getFreeHand">getFreeHand() Gets turtle free hand: "left"|"right"|false.</a>
    
## Fuel

   <a href="#refuel">refuel([nItems=stack]) Refuels the turtle with nItems.</a>

## General

   <a href="#checkType">checkType(sType, ...) Checks if parameters are from sType.</a><br>
   <a href="#getParam">getParam(sParamOrder, tDefault, ...) Sorts parameters by type.</a><br>
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
  
   <a href="#turnBack">turnBack() The turtle turns back.</a><br>
   <a href="#turnDir">turnDir([Direction="back"]) Rotates turtle back, left or right.</a>
    
## Moving
  
   <a href="#back">back([Blocks=1]) Moves the turtle backwards or forward blocks.</a><br>
   <a href="#down">down([Blocks=1]) Moves the turtle down or up blocks.</a><br>
   <a href="#forward">forward([Blocks=1]) Moves the turtle forward or backwards blocks.</a><br>
   <a href="#up">up([Blocks=1]) Moves the turtle up or down blocks.</a>
  
## Rotations and Moving
  
   <a href="#goDir">goDir([sDir="forward", [Blocks=1]) Turtle advances blocks, in sDir { "forward", "right", "back", "left", "up", "down" }.</a><br>
   <a href="#goBack">goBack([Blocks=1]) Rotates turtle back or not, and moves blocks forward.</a><br>
   <a href="#goLeft">goLeft([Blocks=1]) Rotates turtle to the left or right, and moves blocks forward.</a><br>
   <a href="#goRight">goRight([Blocks=1]) Rotates turtle to the right or left, and moves blocks forward.</a>

## Dig
  
   <a href="#dig">dig([Blocks=1]) Dig Blocks forward or backwards with equiped tool.</a><br>
   <a href="#digAbove">digAbove([Blocks=1]) Dig Blocks forward or backwards, 1 block above the turtle, with equiped tool.</a><br>
   <a href="#digBack">digBack([Blocks=1]) Rotates turtle back or not, and dig Blocks forward.</a><br>
   <a href="#digBelow">digBelow([Blocks=1]) Dig Blocks forward or backwards, 1 block below the turtle, with equiped tool.</a><br>
   <a href="#digDir">digDir(sDir, nBlocks) Turtle digs in sDir direction nBlocks.</a><br>
   <a href="#digDown">digDown([Blocks=1]) Dig Blocks downwards or upwards with equiped tool.</a><br>
   <a href="#digLeft">digLeft([Blocks=1]) Rotates turtle left or right, and dig Blocks forward with equiped tool.</a><br>
   <a href="#digRight">digRight([Blocks=1]) Rotates turtle Right or left, and dig Blocks forward with equiped tool.</a><br>
   <a href="#digUp">digUp([Blocks=1]) Dig Blocks upwards or downwards with equiped tool.</a>

## Drop

   <a href="#drop">drop([Blocks=stack]) Drops Blocks from selected slot and inventory in the world in front of the turtle.</a><br>
   <a href="#dropBack">dropBack([nBlocks=stack]) Rotate back and drops or sucks nBlocks forward.</a><br>
   <a href="#dropDir">dropDir(sDir, [Blocks=stack]) Drops Blocks from selected slot and inventory in the world in front, up or down the turtle.</a><br>
   <a href="#dropDown">dropDown([Blocks=stack]) Drops nBlocks from selected slot and inventory in the world downwards.</a><br>
   <a href="#dropLeft">dropLeft([nBlocks=stack]) Rotate left and drops or sucks nBlocks forward.</a><br>
   <a href="#dropRight">dropRight([nBlocks=stack]) Rotate right and drops or sucks nBlocks forward.</a><br>
   <a href="#dropUp">dropUp([Blocks=stack]) Drops Blocks from selected slot and inventory in the world upwards.</a>

## Place

   <a href="#place">place([Blocks=1]) Places inventory selected Blocks in a strait line forward or backwards, and returns to initial position.</a><br>
   <a href="#placeAbove">placeAbove([Blocks=1]) places Blocks forwards or backwards, 1 block above the turtle, and returns to initial position.</a><br>
   <a href="#placeBelow">placeBelow([Blocks=1]) Places selected Blocks forwards or backwards, 1 block below the turtle, and returns to initial position.</a><br>
   <a href="#placeDir">placeDir([sDir="forward"]) Places inventory selected Block in sDir { "forward", "right", "back", "left", "up", "down" }.</a><br>
   <a href="#placeDown">placeDown([Blocks=1]) Places inventory selected Blocks in a strait line downward or upwards, and returns to initial position.</a><br>
   <a href="#placeLeft">placeLeft([Blocks=1]) Rotates turtle left or right, places inventory selected Blocks forward, and returns to initial position.</a><br>
   <a href="#placeRight">placeRight([Blocks=1]) Rotates turtle Right or left, places inventory selected Blocks forward, and returns to initial position.</a><br>
   <a href="#placeUp">placeUp([Blocks=1]) Places inventory selected Blocks in a strait line upward or downwards, and returns to initial position.</a>

## Detect

   <a href="#detectAbove">detectAbove([Blocks=1]) Detects if exits Blocks above the turtle in a strait line forward or backwards.</a><br>
   <a href="#detectBelow">detectBelow([Blocks=1]) Detects if exits Blocks below the turtle in a strait line forward or backwards.</a><br>
   <a href="#detectDir">detectDir(sDir) Detects if is a block in sDir direction {"forward", "right", "back", "left", "up", "down" }.</a>

## Disk

   <a href="#fsGetFreeSpace">fsGetFreeSpace() Gets the total free space on disk.</a>
		
## Inspect

   <a href="#inspectDir">inspectDir([sDir="forward]) Turtle inspect block in sDir direction {"forward", "right", "back", "left", "up", "down"}.</a>

## Compare

   <a href="#compareAbove">compareAbove([Blocks=1]) Compare blocks above the turtle in a strait line with selected slot.</a><br>
   <a href="#compareBelow">compareBelow([Blocks=1]) Compare blocks below the turtle in a strait line with selected slot.</a><br>
   <a href="#compareDir">compareDir([sDir="forward"][, nSlot=selected slot]) Compares item in slot with block in sDir direction.</a>

## Inventory
    
   <a href="#clearSlot">clearSlot(nSlot) Clears content of slot, moving items to another slot.</a><br>
   <a href="#decSlot">decSlot(nSlot) Decreases nSlot in range [1..16].</a><br>
   <a href="#freeCount">freeCount() Get number of free slots in turtle's inventory.</a><br>
   <a href="#getFreeSlot">getFreeSlot(nStartSlot, bWrap) Get the first free slot, wrapig the search or not.</a><br>
   <a href="#groupItems">groupItems() Groups the same type of items in one slot in inventory.</a><br>
   <a href="#incSlot">incSlot(nSlot) Increases nSlot in range [1..16].</a><br>
   <a href="#itemCount">itemCount([selected slot/slot/"inventory"/item name=Selected slot]) Counts items in slot, inventory.</a><br>
   <a href="#itemName">itemName([Slot=Selected slot]) Gets the item name from Slot.</a><br>
   <a href="#itemSelect">itemSelect([Slot/Item Name]) Selects slot [1..16] or first item with Item Name, or the turtle selected slot.</a><br>
   <a href="#itemSpace">itemSpace([slot/item Name=selected slot]) Get the how many items more you can store in inventory.</a><br>
   <a href="#search">search(sItemName, nStartSlot) Search inventory for ItemName, starting at startSlot.</a><br>
   <a href="#transferFrom">transferFrom(nSlot, nItems) Transfer nItems from nSlot to selected slot.</a>

## Suck

   <a href="#suckDir">suckDir(sDir, nItems) Sucks or drops nItems into sDir direction {"forward", "right", "back", "left", "up", "down"}.</a>
    
---------------------------------------------------------------------------------------------------------------------------

# Functions Explained


## Initialize

  <p id="INIT"></p>
  
- INIT() Loads tTurtle.txt, tRecipes.txt, tStacks.txt from files to tables.<br>
    <pre>Sintax: INIT() - Loads turtle coords, facing, equiped tool,
                   table of recipes,
                   table of items stacks.
  Returns:  true
  ex: INIT()</pre>
  
## Terminate

  <p id="TERMINATE"></p>
  
- TERMINATE() Saves tTurtle, tRecipes, tStacks to text files.<br>
    <pre>Sintax: TERMINATE() - Saves turtle coords, facing, equiped tool,
                        table of recipes,
                        table of items stacks.
  Returns:  true
  ex: TERMINATE()</pre>
  
## Measurements

   <p id="addSteps"></p>
   
- addSteps(nSteps) Adds nSteps to coords of turtle.<br>
    <pre>Sintax: addSteps([nSteps=1])
  Returns:  x, y, z adding nSteps in direction turtle is facing.
  ex: if tTurtle x=0, y=0, z=0, facing="x+"
  addSteps() - Returns 1,0,0.
  ex: addSteps(-1) - Returns -1,0,0.</pre>
  
   <p id="distTo"></p>

- distTo(x, y, z) Gets the three components of the distance from the turtle to point.<br>
    <pre>Sintax: distTo(x, y, z)
  Returns: distX, distY, distZ From turtle to point x, y, z.
  ex: if turtle x=0, y=0, z=0
  distTo(10,10,10) Returns 10, 10, 10</pre>

## Turtle

   <p id="loadTurtle">
     
- loadTurtle() Loads tTurtle from file tTurtle.txt.<br>
   <pre>Sintax: loadTurtle()
  Returns: true - if could load from file "tTurtle.txt" to tTurtle.
           false - if it couldn't.
  ex: loadTurtle()</pre>
  
   <p id="saveTurtle">
     
- saveTurtle() Saves tTurtle to file tTurtle.txt.<br>
   <pre>Sintax: saveTurtle()
  Returns: true - if could save tTurtle to file "tTurtle.txt".
           false - if it couldn't.
  ex: saveTurtle()</pre>
  
  
## Turtle facing

   <p id="decFacing"></p>
   
- decFacing(nTurns) Decrements tTurtle.facing by nTurns.<br>
    <pre>Sintax: decFacing([nTurns=1])
  Returns: true
  ex: if turtle is facing "x+"=1
  decFacing() Decrements 1 of value tTurtle.facing, turtle turns to "z-"=0,
  if tTurtle.facing<0 then tTurtle.facing and= 3 end</pre>
    
   <p id="getFacing"></p>
   
- getFacing() Returns tTurtle.facing.<br>
    <pre>Sintax: getFacing()
  Returns: tTurtle.facing [0..3]
  ex: getFacing()</pre>
    
   <p id="incFacing"></p>
   
- incFacing(nTurns) Increments tTurtle.facing by nTurns.<br>
    <pre>Sintax: incFacing([nTurns=1])
  Returns: true
  ex: if turtle is facing "x+"=1
  incFacing(1) - Increments tTurtle.facing, turtle turns to "z+"=2,
  if tTurtle.facing>3 then tTurtle.facing and= 3 end</pre>
    
   <p id="setFacing"></p>
   
- setFacing(sFacing) Sets tTurtle.facing.<br>
    <pre>Sintax: setFacing(sFacing) - sFacing = "z-"|"x+"|"z+"|"x-"|"y+"|"y-"|[0..3]
  Returns:  tTurtle.facing
            false - if no parameter was supplied.
                  - if sFacing is not in facingType.
  ex: setFacing("z+") - Sets tTurtle.facing = 2
      setFacing(1) - sets tTurtle.facing = 1</pre>


## Turtle coords

   <p id="getCoords"></p>
     
- getCoords() Gets coords from turtle.<br>
    <pre>Sintax: getCoords()
  Returns: tTurtle.x, tTurtle.y, tTurtle.z the turtle coords.
  ex: getCoords() </pre>
     
   <p id="setCoords"></p>
      
- setCoords(x, y, z) Set coords x, y, z for turtle.<br>
    <pre>Sintax: setCoords(x, y, z)
  Returns: true
  ex: setCoords(1, 10, 14) Sets tTurtle.x = 1, tTurtle.y = 10, tTurtle.z = 14</pre>


## Equip
  
   <p id="equip"></p>
     
- equip(Side) Equip tool from the selected slot.<br>
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
    <pre>Sintax: getFreeHand()
  Returns: "left" or "right" the first free hand found.
           false - if no free hand found.
  ex: getFreeHand()</pre>


## Fuel
  
   <p id="refuel"></p>

- refuel([nItems=stack]) Refuels the turtle with nItems.
    <pre>Sintax: refuel([nItems=all items in selected slot])
  Returns: number of items refueled.
           false - "Empty selected slot."
                 - "Item is not fuel."
                 - "Turtle doesn't need fuel."
                 - "Turtle is at maximum fuel."
  ex: refuel(10) - Refuels turtle with 10 items.</pre>

  
## General

  <p id="checkType"></p>
  
- checkType(sType, ...) Checks if parameters are from sType.</a><br>
    <pre>Sintax: checkType(sType, ...)
  Returns: true - if all parameters have the type of sType.
           false - if #sType ~= #... (number of parameters are diferent from length of sType).
  ex: checkType("snt", "hello", number1, tTable) - Outputs: true.</pre>
  
  <p id="getParam"></p>
  
- getParam(sParamOrder, tDefault, ...) Sorts parameters by type.</a><br>
    <pre>Sintax: getParam(sTypeParamOrder,{default parameter value,}, parameters ...}
  Returns: Parameters ordered by type.
           nil - if no parameters.
  Note: Only sorts three parameters type (string, number and boolean).
  ex: getParam("sns", {"default" }, number, string) - Outputs: string, number, default.</pre>
   
   <p id="isValue"></p>
   
- isValue(value, t) Checks if value is in t table.</a><br>
    <pre>Sintax: isValue(value, t)
  Returns: true - if value is in t.
           false - if value is not in t.
  ex: isValue(2, {["hello"] = 2, ["hi"] = 4}) - Outputs: true.</pre>
  
   <p id="loadTable"></p>
   
- loadTable(sFileName) Loads a text file into a table.</a><br>
    <pre>Sintax: loadTable(sFileName)
  Returns: true - if could read a text file into a table.
           false - if sFileName is not supplied,
                 - if the file couldn't be opened for reading,
                 - if the file is empty.
  ex: loadTable("oneFile.txt") - Loads file "oneFile.txt" returns it as a table.</pre>
  
   <p id="saveTable"></p>
   
- saveTable(t, sFileName) Saves a table into a text file.</a><br>
    <pre>Sintax: saveTable(t, sFileName)
  Returns: true - if saving file was a success.
           false - if t or sFileName not supplied,
                 - if no disk space,
                 - if it couldn't create file.
  Note: if not supplied extension it adds ".txt" to the file name.
  ex: saveTable(oneTable, "oneFile") - Saves table oneTable into "oneFile.txt" file.</pre>
  
   <p id="sign"></p>
   
- sign(value) Returns: -1 if value < 0, 0 if value == 0, 1 if value > 0</a><br>
    <pre>Sintax: sign(value)
  Returns: -1 if value < 0, 0 if value == 0, 1 if value > 0
  ex: sign(-1) - Returns -1</pre>
  
  <p id="tableInTable"></p>
  
- tableInTable(tSearch, t) Verifies if tSearch is in table t.</a>
    <pre>Sintax: tableInTable(tSearch, t)
  Returns: true - tSearch is in t.
           false - at the least one element of tSearch is not in table t.
  ex: tableInTable("forward", {"forward", "left", "right"}) - Returns true.</pre>
  

## Attack

   <p id="attackDir"></p>

- attackDir([sDir="forward"]) Turtle attack in sDir direction {"forward", "right", "back", "left", "up", "down"}
    <pre>Sintax: attackDir([sDir="forward"])
  Returns: true if turtle attack something.
           false - if there is nothing to attack, or no weapon.
           nil - if invalid parameter.
  ex: attackDir() - Attacks forward.</pre>

  
## Recipes

  <p id="getFirstItemCoords"></p>
  
- getFirstItemCoords(sRecipe) Returns the column and line=0 of the first item in the recipe.
    <pre>Sintax: getFirstItemCoords(sRecipe)
  Returns: false - if the recipe name was not supplied.
                 - if this recipe does not exist.
           col, lin - the column and line of first item.
  ex: getFirstItemCoords("minecraft:stick") - Retuens the column and line of the turtle inventory, where to place the ingredients of recipe.</pre>
  
  <p id="getInvRecipe"></p>
  
- getInvRecipe() Builds a table with items and their position (the recipe).
    <pre>Sintax: getInvRecipe()
  Returns: false - if it is not a recipe in the inventory.
           tRecipe - the recipe with items and positions.
  Note: Trecipe[Ingredient number][Ingredient name] = if not first item {{col = column position, lin = line position (relative to 1st ingredient) }
  ex: getInvRecipe() - Returns the recipe in inventory.</pre>
  
  <p id="getMaxCraft"></p>
  
- getMaxCraft() Returns maximum limit to craft the recipe on inventory.
    <pre>Sintax: getMaxCraft()
  Returns: false - if it is not a recipe in the inventory.
           tRecipe - the recipe with items and positions.
  ex: getMaxCraft() - Returns the recipe from inventory.</pre>
  
  <p id="loadRecipes"></p>
  
- loadRecipes() Loads tRecipes from file "tRecipes.txt"
    <pre>Sintax: loadRecipes()
  Returns: false - if it couldn't load file.
           true - if it could load file.
  ex: loadRecipes()</pre>
  
  <p id="saveRecipes"></p>
  
- saveRecipes() Saves tRecipes in a file as "tRecipes.txt"
    <pre>Sintax: saveRecipes()
  Returns: false - if it couldn't load file.
           true - if it could load file.
  ex: saveRecipes()</pre>
  
  <p id="setCraftSlot"></p>
  
- setCraftSlot(nSlot) Sets the craft resulting slot, in tRecipes CSlot
    <pre>Sintax: setCraftSlot([nSlot=Selected Slot])
  Returns: nil - if nSlot is not in range[1..16].
           true - if was set tRecipes["CSlot"].
  ex: setCraftSlot(16) - Sets the resulting craft slot to 16.</pre>


## Rotations
  
  <p id="turnBack"></p>
  
- turnBack() The turtle turns back.<br>
    <pre>Sintax: turnBack()
  Returns: true
  ex: turnBack()</pre>

  <p id="turnDir"></p>
  
- turnDir([Direction="back"]) Rotates turtle back, left or right.<br>
    <pre>Sintax: turnDir([Direction="back"])
  Returns: true if sDir is a valid direction.
           false if sDir is not a valid direction.
  ex: turnDir("left") - Turtle turns left.</pre>


## Moving
 
  <p id="back"></p>
  
- back([Blocks=1]) Moves the turtle backwards or forward blocks.<br>
    <pre>Sintax: back([Blocks=1])
  Returns:  true - if it goes all the way.
            false - if Blocks is not a number.
                  - if it couldn't complete all the moves.
  Note: if Blocks < 0 it moves forward.
  ex: back() - Moves 1 block backwards.</pre>
  
  <p id="down"></p>
  
- down([Blocks=1]) Moves the turtle down or up blocks.<br>
    <pre>Sintax: down([Blocks=1])
  Returns: true - if it goes all the way.
           false - if Blocks is not a number.
                 - if it couldn't complete all the moves.
  Note: if Blocks < 0 it moves upwards.
  ex: down(2) - moves 2 blocks down</pre>
  
  <p id="forward"></p>
  
- forward([Blocks=1]) Moves the turtle forward or backwards blocks.<br>
    <pre>Sintax: forward([Blocks=1])
  Returns: true - if it goes all the way.
           false - if Blocks is not a number.
                 - if it couldn't complete all the moves.
  Note: if Blocks < 0 it moves backwards.
  ex: forward(-2) - moves 2 blocks backwards.</pre>
  
  <p id="up"></p>
  
- up([Blocks=1]) Moves the turtle up or down blocks.<br>
    <pre>Sintax: up([Blocks=1])
  Returns: true - if it goes all the way.
           false - if Blocks is not a number.
                 - if it couldn't complete all the moves.
  Note: if Blocks < 0 it moves downwards.
  ex: up(1) - moves 1 block upwards.</pre>
  
  
## Rotations and Moving
  
  <p id="goDir"></p>
  
- goDir([sDir="forward"], [Blocks=1]) Turtle advances blocks, in sDir { "forward", "right", "back", "left", "up", "down" }.<br>
    <pre>Sintax: go([sDir="forward"][,Blocks=1])
  Returns: true - if turtle goes all way.
           false - if blocked.
                 - if invalid direction.
  ex: go("left", 3) or go(3, "left") - Rotates left and moves 3 Blocks forward.
  ex: go() - Moves 1 block forward.
  ex: go(-3, "up") - moves 3 blocks down.</pre>
  
  <p id="goBack"></p>
  
- goBack([Blocks=1]) Rotates turtle back or not, and moves blocks forward.<br>
    <pre>Sintax: goBack([Blocks=1])
  Returns: true - if turtle goes all way.
           false - if blocked, or invalid parameter.
  Note: nBlocks < 0 moves forward, nBlocks >= 0 turns back and advances nBlocks.
  ex: goBack(3) - Turns back and moves 3 blocks forward.</pre>
  
  <p id="goLeft"></p>
  
- goLeft([Blocks=1]) Rotates turtle to the left or right, and moves blocks forward.<br>
    <pre>Sintax: goLeft([Blocks=1])
  Returns: true - if turtle goes all way.
           false - if bllocked, or invalid parameter.
  Note: nBlocks < 0 goes right, nBlocks > 0 goes left, nBlocks = 0 turns left.
  ex: goLeft(3) - Moves 3 Blocks to the left.</pre>
  
  <p id="goRight"></p>
  
- goRight([Blocks=1]) Rotates turtle to the right or left, and moves blocks forward.<br>
    <pre>Sintax: goRight([Blocks=1])
  Returns: true - if turtle goes all way.
           false - if bllocked, or invalid parameter.
  Note: nBlocks < 0 goes left, nBlocks > 0 goes right, nBlocks = 0 turns right.
  ex: goRight(3) - Moves 3 Blocks to the right.</pre>
  

## Dig
  
  <p id="dig"></p>
  
- dig([Blocks=1]) Turtle digs nBlocks forward or turns back and digs nBlocks, must have a tool equiped.
    <pre>Sintax: dig([Blocks=1])
  Returns: true - if turtle digs all way.
           false - if blocked, empty space, or invalid parameter.
  Note: nBlocks < 0 turns back and digs forward, nBlocks > 0 digs forward.
  ex: dig() or dig(1) - Dig 1 block forward.</pre>
  
  <p id="digAbove"></p>
  
- digAbove([Blocks=1]) Dig Blocks forward or backwards, 1 block above the turtle, with equiped tool.<br>
    <pre>Sintax: digAbove([Blocks=1])
  Returns: true - if turtle digs all way.
           false - if bllocked, empty space, or invalid parameter.
  Note: nBlocks < 0 moves backwards and dig above, nBlocks > 0 moves forward and digs above.
  ex: digAbove() or digAbove(1) - Dig 1 block above the turtle and moves forward.</pre>
  
  <p id="digBack"></p>
  
- digBack([Blocks=1]) Turns back or not and digs Blocks forward, must have a tool equiped.<br>
    <pre>Sintax: digBack([Blocks=1])
  Returns: true - if turtle digs all way.
           false - if blocked, empty space, or invalid parameter.
  Note: nBlocks < 0 digs forward, nBlocks > 0 digs backwards.
  ex: digBack() or digBack(1) - Turns back and dig 1 block forward.</pre>
  
  <p id="digBelow"></p>
  
- digBelow([Blocks=1]) Dig Blocks forward or backwards, 1 block below the turtle, with equiped tool.<br>
    <pre>Sintax: digBelow([Blocks=1])
  Returns: true - if turtle digs all way.
           false - if bllocked, empty space, or invalid parameter.
  Note: nBlocks < 0 moves backwards and dig below, nBlocks > 0 moves forward and digs below.
  ex: digBelow() or digBelow(1) - Dig 1 block above the turtle and moves forward.</pre>
  
  <p id="digDir"></p>
  
- digDir(sDir, nBlocks) Turtle digs in sDir direction nBlocks.<br>
    <pre>Sintax: digDir([sDir="forward"], [nBlocks=1]) - sDir {"forward", "right", "back", "left", "up", "down"}
  Returns: true - if turtle digs all way.
           false - if blocked, empty space, can't turn that way.
           nil if invalid parameter
  ex: digDir("left", 3) or digDir(3, "left") - Rotates left and digs 3 Blocks forward.
  ex: digDir() - Digs 1 block forward.
  ex: digDir(-3, "up") - Digs 3 blocks down.</pre>
   
   <p id="digDown"></p>
   
- digDown([Blocks=1]) Dig Blocks downwards or upwards with equiped tool.<br>
    <pre>Sintax: digDown([Blocks=1])
  Returns: true - if turtle digs all way.
           false - if bllocked, empty space, or invalid parameter.
  Note: nBlocks < 0 digs upwards, nBlocks > 0 digs downwards.
  ex: digDown() or digDown(1) - Dig 1 block down.</pre>
   
   <p id="digLeft"></p>
   
- digLeft([Blocks=1]) Rotates turtle left or right, and dig Blocks forward with equiped tool.<br>
    <pre>Sintax: digLeft([Blocks=1])
  Returns: true - if turtle digs all way.
           false - if bllocked, empty space, or invalid parameter.
  Note: nBlocks < 0 digs right, nBlocks > 0 digs left.
  ex: digLeft() or digLeft(1) - Dig 1 block left.</pre>
   
   <p id="digRight"></p>
   
- digRight([Blocks=1]) Rotates turtle Right or left, and dig Blocks forward with equiped tool.<br>
    <pre>Sintax: digRight([Blocks=1])
  Returns: true - if turtle digs all way.
           false - if bllocked, empty space, or invalid parameter.
  Note: nBlocks < 0 digs left, nBlocks > 0 digs left.
  ex: digRight(-1) or digLeft(1) - Dig 1 block left.</pre>
   
   <p id="digUp"></p>
   
- digUp([Blocks=1]) Dig Blocks upwards or downwards with equiped tool.
    <pre>Sintax: digUp([Blocks=1])
  Returns: true - if turtle digs all way.
           false - if bllocked, empty space, or invalid parameter.
  Note: nBlocks < 0 digs down, nBlocks > 0 digs Up.
  ex: digUp(2) - Dig 2 blocks Up.</pre>
   

## Drop

   <p id="drop"></p>

- drop([Blocks=stack]) Drops Blocks from selected slot and inventory in the world in front of the turtle.<br>
    <pre>Sintax: drop([Blocks=stack])
  Returns: Number of blocks dropped.
  Note: Blocks < 0 sucks Blocks from the front.
  ex: drop(2) - Drops 2 blocks forward.</pre>
   
   <p id="dropBack"></p>
   
- dropBack([Blocks=stack]) Rotate back and drops or sucks Blocks forward.<br>
    <pre>Sintax: dropBack([Blocks=stack])
  Returns: Number of blocks dropped.
  Note: Blocks < 0 sucks Blocks from the back.
  ex: dropBack(-2) - Sucks 2 blocks from the back.</pre>
   
   <p id="dropDir"></p>
   
- dropDir([sDir="forward"][, Blocks=stack]) Drops Blocks from selected slot and inventory in the world in front, up or down the turtle.<br>
    <pre>Sintax: dropDir([sDir="forward"][, Blocks=stack])
  Returns: Number of blocks dropped.
  Note: Blocks < 0 sucks Blocks from sDir direction.
  ex: dropDir(-2) - Sucks 2 blocks from the front.</pre>
   
   <p id="dropDown"></p>
   
- dropDown([Blocks=stack]) Drops nBlocks from selected slot and inventory in the world downwards.<br>
    <pre>Sintax: dropDown([Blocks=stack])
  Returns: Number of blocks dropped.
  Note: Blocks < 0 sucks Blocks from down.
  ex: dropDown() - Drops 1 block down.</pre>
   
   <p id="dropLeft"></p>
   
- dropLeft([nBlocks=stack]) Rotate left and drops or sucks nBlocks forward.<br>
    <pre>Sintax: dropLeft([Blocks=stack])
  Returns: Number of blocks dropped.
  Note: Blocks < 0 sucks Blocks from the left.
  ex: dropLeft() - Drops 1 block to the left.</pre>
   
   <p id="dropRight"></p>
   
- dropRight([nBlocks=stack]) Rotate right and drops or sucks nBlocks forward.<br>
    <pre>Sintax: dropRight([Blocks=stack])
  Returns: Number of blocks dropped.
  Note: Blocks < 0 sucks Blocks from the right.
  ex: dropRight() - Drops 1 block to the right.</pre>
   
   <p id="dropUp"></p>
   
- dropUp([Blocks=stack]) Drops Blocks from selected slot and inventory in the world upwards.<br>
    <pre>Sintax: dropUp([Blocks=stack])
  Returns: Number of blocks dropped.
  Note: Blocks < 0 sucks Blocks from up.
  ex: dropUp() - Drops 1 block upwards.</pre>
   

## Place

   <p id="place">
   
- place([Blocks=1]) Places inventory selected Blocks in a strait line forward or backwards, and returns to initial position.<br>
    <pre>Sintax: place([Blocks=1])
  Returns: number of blocks placed.
           false - invalid parameter.
  Note: nBlocks < 0 places blocks backwards, nBlocks > 0 places blocks forwards
  ex: place(1) or place() - Places 1 Block in front of turtle.</pre>
   
   <p id="placeAbove">
   
- placeAbove([Blocks=1]) Places nBlocks forwards or backwards in a strait line, 1 block above the turtle, and returns to starting point.<br>
    <pre>Sintax: placeAbove([nBlocks=1])
  Returns: number of placed blocks.
           false - if turtle was blocked on the way back.
                 - couldn't place block.
                 - invalid parameter.
  ex: placeAbove(1) or placeAbove() - Places one Block above turtle.</pre>
            
   <p id="placeBelow">
   
- placeBelow([Blocks=1]) Places nBlocks forwards or backwards in a strait line, 1 block below the turtle, and returns to starting point.<br>
    <pre>Sintax: placeAbove([nBlocks=1])
  Returns:  number of blocks placed
            false - if turtle was blocked on the way back.
                  - couldn't place block.
                  - invalid parameter.
  ex: placeBelow(2) - Places two Blocks below turtle in a strait line forward.</pre>
   
   <p id="placeDir">
   
- placeDir([sDir="forward"]) Places inventory selected Block in sDir { "forward", "right", "back", "left", "up", "down" }.<br>
    <pre>Sintax: placeDir([sDir="forward"])
  Returns: true if turtle places the selected block.
           false if turtle doesn't place the selected block, or invalid parameter.
  ex: placeDir("forward") or placeDir() - Places 1 block in front of the turtle.</pre>
   
   <p id="placeDown">
   
- placeDown([Blocks=1]) Places inventory selected Blocks in a strait line downward or upwards, and returns to initial position.<br>
    <pre>Sintax: placeDown([Blocks=1])
  Returns: number of blocks placed.
           false - if turtle was blocked on the way back.
                 - invalid parameter.
  Note: nBlocks < 0 places blocks upwards, nBlocks > 0 places blocks downwards.
  ex: placeDown(1) or placeDown() - Places 1 Block Down.</pre>
   
   <p id="placeLeft">
   
- placeLeft([Blocks=1]) Rotates turtle left or right, places inventory selected Blocks forward, and returns to initial position.<br>
    <pre>Sintax: placeLeft([Blocks=1])
  Returns: number of placed blocks.
           false - if turtle was blocked on the way back.
                 - invalid parameter.
                 - couldn't place block.
  Note: nBlocks < 0 places blocks to the right, nBlocks > 0 places blocks to the left.
  ex: placeLeft(1) or placeLeft() - Places one Block to the left of the turtle.</pre>
   
   <p id="placeRight">
   
- placeRight([Blocks=1]) Rotates turtle Right or left, places inventory selected Blocks forward, and returns to initial position.<br>
    <pre>Sintax: placeRight([Blocks=1])
  Returns: true if turtle places all blocks all the way.
           false - if turtle was blocked on the way back.
                 - invalid parameter.
                 - couldn't place block
  Note: nBlocks < 0 places blocks to the left, nBlocks > 0 places blocks to the right.
  ex: placeRight(1) or placeLeft() - Places 1 Block on the right of the turtle.</pre>
   
   <p id="placeUp">
   
- placeUp([Blocks=1]) Places inventory selected Blocks in a strait line upward or downwards, and returns to initial position.<br>
    <pre>Sintax: placeUp([Blocks=1])
  Returns: number os blocks placed.
           false - if turtle was blocked on the way back.
                 - invalid parameter.
  Note: nBlocks < 0 places blocks downwards, nBlocks > 0 places blocks upwards.
  ex: placeUp(1) or placeUp() - Places 1 Block up.</pre>
   
   
## Detect

   <p id="detectAbove">
   
- detectAbove([Blocks=1]) Detects if exits Blocks above the turtle in a strait line forward or backwards.<br>
    <pre>Sintax: detectAbose([Blocks=1])
  Returns: true - if turtle detects a line of nBlocks above it.
           false - if blocked, empty space.
					nil - if invalid parameter.
  Note: nBlocks < 0 detects backwards, nBlocks > 0 detects forwards.
  ex: detectAbove() or detectAbove(1) - Detects 1 block up.</pre>
   
   <p id="detectBelow">
   
- detectBelow([Blocks=1]) Detects if exits Blocks below the turtle in a strait line forward or backwards.<br>
    <pre>Sintax: detectBelow([Blocks=1])
  Returns: true - if turtle detects a line of nBlocks below.
           false - if blocked, empty space.
					nil - if invalid parameter
  Note: nBlocks < 0 detects backwards, nBlocks > 0 detects forwards.
  ex: detectBelow() or detectBelow(1) - Detect 1 block down.</pre>
   
   <p id="detectDir">
   
- detectDir(sDir) Detects if is a block in sDir direction {"forward", "right", "back", "left", "up", "down" }.<br>
    <pre>Sintax: detectDir([sDir="forward"])
  Returns: true - If turtle detects a block.
           false - if turtle didn't detect a block.
           nil - invalid parameter.
  ex: detectDir([sDir="forward"]) - Detect blocks forward.</pre>


## Disk

   <p id="fsGetFreeSpace">
   
- fsGetFreeSpace() Gets the total free space on disk.<br>
		<pre>Sintax: fsGetFreeSpace()
  Returns: Number - Free space on disk.
  ex: fsGetFreeSpace() - Gets the free space on disk.</pre>
   
   
## Inspect
    
   <p id="inspectDir">

- inspectDir([sDir="forward"]) Turtle inspect block in sDir direction {"forward", "right", "back", "left", "up", "down"}.<br>
    <pre>Sintax: inspectDir([sDir="forward"])
  Returns: true, table with data - If turtle detects a block.
           false, message - if turtle didn't detect a block.
  ex: detectDir([sDir="forward"]) - Inspects a block forward.</pre>
   

## Compare

   <p id="compareAbove">
   
- compareAbove([Blocks=1]) Compares nBlocks above the turtle in a strait line with selected slot block.<br>
    <pre>Sintax: compareAbove([Blocks=1])
  Returns: true - if all the blocks are the same.
           false - if blocked, empty space, or found a diferent block.
           nil - if invalid parameter.
  Note: nBlocks < 0 turn back and compares forward, nBlocks > 0 compares forwards.
  ex: compareAbove() or compareAbove(1) - Compares 1 block up.</pre>
   
   <p id="compareBelow">
   
- compareBelow([Blocks=1]) Compare blocks below the turtle in a strait line with selected slot.<br>
    <pre>Sintax: compareBelow([Blocks=1])
  Returns: true - if all the blocks are the same.
           false - if blocked, empty space, or found a diferent block.
					nil if invalid parameter.
  Note: nBlocks < 0 turn back and compares forward, nBlocks > 0 compares forwards.
  ex: compareBelow() or compareBelow(1) - Compares 1 block down.</pre>
   
    <p id="compareDir">
   
- compareDir([sDir="forward"][, nSlot=selected slot]) Compares item in slot with block in sDir direction.<br>
    <pre>Sintax: compareDir([sDir="forward"][, nSlot=selected slot])
  Returns: true - if the item in slot and in the world is the same.
           false - if block in slot and in the world are not the same,
                 - if invalid direction,
                 - if nSlot is not a number,
                 - if empty slot.
  sintax: compareDir([sDir="forward"][, nSlot=selected slot])
  ex: compareDir() compares selected slot with block in front of turtle.
      compareDir("left", 2) - compares item in slot 2 with block on the left.</pre>


## Inventory
    
   <p id="clearSlot">
    
- clearSlot(nSlot) Clears content of slot, moving items to another slot.<br>
    <pre>Sintax: compareBelow([Blocks=1])
  Returns: false - if there is no space to tranfer items.
           true - if the slot is empty.
  ex: clearSlot() - Clears the selected slot.</pre>
   
   <p id="decSlot">
   
- decSlot(nSlot) Decreases nSlot in range [1..16].<br>
    <pre>Sintax: decSlot(nSlot)
  Returns: the number of slot increased by 1.
  ex: decSlot(1) - Returns 16.</pre>
   
   <p id="freeCount">
   
- freeCount() Get number of free slots in turtle's inventory.<br>
    <pre>Sintax: freeCount()
  Returns: Number of free slots.
  ex: freeCount() - Returns 1 if there is only 1 slot empty.</pre>
   
   <p id="getFreeSlot">
   
- getFreeSlot(nStartSlot, bWrap) Get the first free slot, wrapig the search or not.<br>
    <pre>Sintax: getFreeSlot([nStartSlot=1][, bWrap=true])
  Returns: first free slot number.
  ex: getFreeSlot() - Returns the first empty slot startint at slot 1.
      getFreeSlot(5) - Returns the first empty slot starting at slot 5, and searching from slot 1 through 4 if needed.
      getFreeSlot(16, false) - Returns if slot 16 is empty.</pre>
   
   <p id="groupItems">
   
- groupItems() Groups the same type of items in one slot in inventoy.<br>
    <pre>Sintax: groupItems()
  Returns: true.
  ex: groupItems() - Stacks the same items.</pre>
   
   <p id="indSlot">
   
- incSlot(nSlot) Increases nSlot in range [1..16].<br>
    <pre>Sintax: incSlot(nSlot)
  Returns: The number of slot increased by 1.
  ex: incSlot(16) - Returns 1</pre>
   
   <p id="itemCount">
   
- itemCount([slot/"inventory"/item name=Selected slot]) Counts items in slot, inventory<br>
    <pre>Sintax: itemCount([slot/"inventory"/item name=Selected slot])
  Returns: number of items counted.
           false - if nSlot <0 or > 16.
                 - if nSlot is neither a string nor a number.
  ex: itemCount() counts items in selected slot.
      itemCount("inventory") - counts items in inventory.
      itemCount("minecraft:cobblestone") - counts cobblestone in inventory.</pre>
   
   <p id="itemName">
   
- itemName([Slot=Selected slot]) Gets the item name from Slot.<br>
    <pre>Sintax: itemName([Slot=Selected slot])
  Returns: item name - if selected slot/slot is not empty.
           false - if selected slot/slot is empty.
  ex: itemName(1) - Returns the name of item in slot 1.</pre>
  
   <p id="itemSelect">
   
- itemSelect([Slot/Item Name]) Selects slot [1..16] or first item with Item Name, or the turtle selected slot.<br>
    <pre>Sintax: itemSelect([Slot/itemName=Selected slot])
  Returns: The selected slot, and items in that slot.
           False - if the item was not found
                 - if nStartSlot is not a number or a string.
                 - if value is a number and ( < 1 or > 16 )
  Note: if executed select() is the same as turtle.getSelectedSlot()
  ex: select("minecraft:cobblestone") - Selects first slot with "minecraft:cobblestone"</pre>
   
   <p id="itemSpace">
   
- itemSpace([slot/item Name=selected slot]) Get the how many items more you can store in inventory.<br>
    <pre>Sintax: itemSpace([Slot/itemName=Selected slot])
  Returns: number of items you can store more in inventory.
           false - if item is not in inventory.
                 - if slot is empty.
  ex: itemSpace() gets how many items you can store, like the item in selected slot.
      itemSpace("minecraft:cobblestone") - gets how more cobblestone you can store.
      itemSpace(12) - gets how more items, like item in slot 12, you can store.</pre>
   
   <p id="search">
   
- search(sItemName, nStartSlot) Search inventory for ItemName, starting at startSlot.<br>
    <pre>Sintax: Search(sItemName [, nStartSlot=turtle.getSelectedSlot()][, bWrap=true])
  Returns: The first slot where the item was found, and the quantity
           False - if the item was not found
                 - if sItemName not supplied.
                 - if nStartSlot is not a number.
  Note: nStartSlot < 0 search backwards, nStartSlot > 0 searchs forward.
  ex: search("minecraft:cobblestone") - Returns first slot with "minecraft:cobblestone" and the quantity.</pre>
   
- transferFrom(nSlot, nItems) Transfer nItems from nSlot to selected slot.<br>
    <pre>Sintax: transferFrom(nSlot, nItems)
  Returns: number of items in selected slot.
           nil - if nSlot is not supplied.
           false - if nSlot is empty.
                 - if nSlot is out of range [1..16].
                 - if selected slot is full.
  ex: transferFrom(1, 3) - Tranfers from slot 1, 3 items to selected slot.</pre>
   
   
## Suck

   <p id="suckDir">
   
- suckDir(sDir, nItems) Sucks or drops nItems into sDir direction {"forward", "right", "back", "left", "up", "down"}.<br>
    <pre>Sintax: suckDir([sDir="forward][,nItems=all the items])
  Returns: true - if turtle collects some items.
           false - if there are no items to take.
  ex: suckDir() - Turtle sucks all the items forward.</pre>

   <a href="#top">Top of page</a>
