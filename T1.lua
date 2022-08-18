--
---- Version 0.4.0
--

local PREFEREDHAND = "right" --default equip hand
local DEFSTACK = 64 --default stack size
local CSLOT = 13 --default crafting slot

digF = {["up"] = turtle.digUp, ["forward"] = turtle.dig, ["down"] = turtle.digDown} --original dig functions
movF = {["up"] = turtle.up, ["forward"] = turtle.forward, ["down"] = turtle.down} --original move functions
insF = {["up"] = turtle.inspectUp, ["down"] = turtle.inspectDown, ["forward"] = turtle.inspect} --original inspect functions
dropF = { ["up"] = turtle.dropUp, ["forward"] = turtle.drop, ["down"] = turtle.dropDown } --original drop functions
suckF = {["forward"] = turtle.suck, ["up"] = turtle.suckUp, ["down"] = turtle.suckDown} --original suck functions.
equipF = {["left"] = turtle.equipLeft, ["right"] = turtle.equipRight} --original equip functions

dirType = { ["forward"]=0, ["right"]=1, ["back"]=2, ["left"]=3, ["up"]=4, ["down"]=8 } --moving direction options
lookingType = { ["forward"] = 0, ["up"] = 4, ["down"] = 8} --where is the turtle looking, it can't look to the sides or back.
facingType = {["z-"]=0, ["x+"]=1, ["z+"]=2, ["x-"]=3, ["y+"]=4, ["y-"]=8} --axis type values
carDirType = {["north"] = 0, ["east"] = 1, ["south"] = 2, ["west"] = 3} --cardinal directions
tTurtle = { ["x"] = 0, ["y"] = 0, ["z"] = 0, --coords for turtle
          facing = facingType["z-"], --the axis where the turtle is facing at
          leftHand = "empty",
          rightHand = "empty",
} 

tRecipes = {} --[[ ["Name"][index]["recipe"] = {{"itemName"}, {"itemName", nCol = nColumn, nLin = nLine}, ...}
                   ["Name"][index]["count"] = resulting number of items}
                   ["lastRecipe"] = sLastRecipe
                   ["CSlot"] = Crafting slot.
                   ["lastIndex"] = last recipe index]]
tStacks = {} --["itemName"] = nStack
tEnts={["unknown"]=nil, ["unreachable"]=-1, ["empty"]=0, ["next"]=1} --table entity 20-07-2022
tRevEnts={[-1]="unreachable", [0]="empty"} --table for reverse lookup table entity 20-07-2022
tWorld = {} --[x][y][z] = nEnt
tSpots = {} --[sSpotName]={x, y, z, nFacing}


------ Spots ------
function saveSpots() --[[ Saves table tSpots in text file tSpots.txt
  05-08-2022 v0.4.0]]
  return saveTable(tSpots,"tSpots.txt")
end

function loadSpots() --[[ Loads from file tSpots.txt to table tSpots
  05-08-2022 v0.4.0]]
  tSpots = loadTable("tSpots.txt")
	if not tSpots then
		tSpots = {}
		return false,"can't load tworld.txt"
	end
  return true
end

function setSpot(sSpotName, x, y, z, nFacing) --[[ Sets a spot in tSpots table.
  05-08-2022 v0.4.0 Param: sSpotName - string the name of the spot.
                           x, y, z - coords of spot.
                           nFacing - the direction in that spot.
  Returns: true - if spot was set with success.
  Sintax: setSpot(sSpotName[, x, y, z, nFacing]=tTurtle)
  ex: setSpot("minecraft:cobblestone", 10,3,5, 0) - cobblestone at coords (10,3,5) facing z- ]]
  if not x then
    x = tTurtle.x
    y = tTurtle.y
    z = tTurtle.z
    nFacing = tTurtle.facing
  end
  tSpots[sSpotName] = {["x"] = x, ["y"] = y, ["z"] = z, ["facing"] = nFacing}
  return true
end

function getSpot(sSpotName) --[[ Gets the spot.
  06-082022 v0.4.0 Param: sSpotName - string the name of the spot to get the data from.
  Returns: table with spot - {x,y,z,facing}
  Sintax: getSpot(sSpotName)]]
  return tSpots[sSpotName]
end

function goToSpot(sSpotName)
  local tSpot = getSpot(sSpotName)
  if not tSpot then return false, "Spot name not found." end
  if not goTo(tSpot.x, tSpot.y, tSpot.z) then return false, "Couldn't get there." end
  turnTo(tSpot.facing)
  return true
end

------ World ------
function setWorldEnt(x, y, z, nEnt) --[[ Set world coords containing nEnt.
  24-07-2022 v0.4.0 Param: x, y, z - numbers world coords.
                           nEnt - id of the entity from getEntId(sBlockName).
  Returns: true
  Sintax: setWorldEnt(x, y, z, nEnt)]]
  if not tWorld[x] then tWorld[x] = {} end
  if not tWorld[x][y] then tWorld[x][y] = {} end
  tWorld[x][y][z] = nEnt
  return true
end

function getWorldEnt(x, y, z) --[[ Gets the entity at coords x,y,z.
  24-07-2022 v0.4.0 Param: x, y, z - numbers world coords.
  Returns: number the id of the block in that coords.]]
  if not tWorld[x] then return nil end
  if not tWorld[x][y] then return nil end
  return tWorld[x][y][z]
end

function saveWorld() --[[ Saves tWorldinto tWorld.txt
  24-07-2022 v0.4.0 Returns: the same as the saveTable function.]]
  return saveTable(tWorld,"tworld.txt")
end

function loadWorld() --[[ Loads tWorld.txt into tWorld table.
  24-07-2022 v0.4.0 Returns: true - if success.
                             false - if it couldn't load file "tworld.txt".]]
  tWorld = loadTable("tworld.txt")
	if not tWorld then
		tWorld={}
		return false,"can't load tworld.txt"
	end
  return true
end

------ Entity ------
function addEnt(sEntName) --[[ Adds a entity name to table ent.
  21-07-2022 v0.4.0 Param: sEntName - string name of entity.
  Returns: number - entity id
           nil - if not sEntName not supplied.
               - if sEntName is not a number.
  Sintax: addEnt(sEntName)
  Note: if entity already exists, it returns the existing one.
  ex: addEnt("minecraft:cobblestone") - it returns tEnts.next or the existing tEnt["minecraft:cobblestone"] ]]

  if not sEntName then return nil, "addEnt(EntName) - Must supply entity name." end
	if type(sEntName) ~= "string" then return nil, "addEnt(EntName) - Entity name must be a string." end
	if tEnts[sEntName] then return tEnts[sEntName] end
	tEnts[sEntName] = tEnts.next
	tRevEnts[tEnts.next] = sEntName
	tEnts.next = tEnts.next + 1
	return tEnts.next-1
end

function addInvEnts() --[[ Adds all the inventory items to tEnts.
  24-07-2022 v0.4.0 Returns: true, number quantity of entities added.
                             false, if no entities added.]]

  local nAdded = 0
  for nSlot = 1, 16 do
    local tData = turtle.getItemDetail(nSlot)
    if tData then
      if not getEntId(tData.name) then
        addEnt(tData.name)
        nAdded = nAdded + 1
      end
    end
  end
  if nAdded == 0 then  return false
  else return true, nAdded
  end
end

function addSlotEnt(nSlot) --[[ Adds item in nSlot to tEnts.
  24-07-2022 v0.4.0]]

  nSlot = nSlot or turtle.selectedSlot()
  if type(nSlot) ~= "number" then return nil, "addSlotEnt(Slot) - Slot must be a number." end
  if nSlot < 1 or nSlot > 16 then return nil, "addSlotEnt(Slot) - Slot must be between 1 and 16" end
  local tData = turtle.getItemDetail(nSlot)
  if not tData then return false, "Empty Slot." end
  return addEnt(tData.name)
end

function getSlotEnt(nSlot) --[[ Gets or adds the nSlot item tEnts.
  24-07-2022 v0.4.0 Alias for addSlotEnt()]]
  return addSlotEnt(nSlot)
end

function getEntId(sEntName) --[[ Gets the entity id.
  21-07-2022 v0.4.0 Param: sEntName - string the entity name.
  Returns: number - the entity id.
           false - the entity name was not found.
           nil - the entity name was not supplied.
               - the entity name was not a string.
  Sintax: getEntId(sEntName)
  ex: getEntId("minecraft:stick") - it returns a number the id.]]

  if not sEntName then return nil, "getEntId(EntName) - Entity name must be supplied." end
	if type(sEntName) ~= "string" then return nil, "getEntId(EntName) - Ent name must be a string." end
	if tEnts[sEntName] then return tEnts[sEntName] end
	return false
end

function getEntName(nId) --[[ Gets the entity name.
  21-07-2022 v0.4.0 Param: nId - number the id of the entity to get the name.
  Returns: string - the name of the entity.
           false - if nId was not found.
           nil - if nId was not supplied.
               - if nId is not a number
  Sintax: getEntName(nId)
  ex: getEntName(1) - gets the intity name witch has 1 for id.]]

  if not nId then return nil, "getEntName(Id) - The id of the entity must be supplied." end
	if type(nId) ~= "number" then return nil, "getEntName(Id) - The id of the entity must be a number." end
	if tRevEnts[nId] then return tRevEnts[nId] end
	return false
end

function saveEnt() --[[ Saves table tEnts into tEnts.txt file.
  21-07-2022 v0.4.0 Returns: the same as saveTable
  Sintax: saveEnt()
  ex: saveEnt()]]

  return saveTable(tEnts, "tEnts.txt")
end

function loadEnt() --[[ Loads tEnts.txt into table tEnts.
  21-07-2022 v0.4.0 Returns: true - if it loaded the file.
                             false - if it couldn't load the file.
  Sintax: loadEnt()
  ex: loadEnt()]]

  local t = loadTable("tEnts.txt")
	if not t then return false,"Can't load tEnts.txt" end
	tEnts = t
  return true
end

function saveRevEnt() --[[ Saves tRevEnts into tRevEnts.txt file.
  21-07-2022 v0.4.0 Returns: same as saveTable
  Sintax: saveRevEnt()
  ex: saveRevEnt()]]

  return saveTable(tRevEnts, "tRevEnts.txt")
end

function loadRevEnt() --[[ Loads tRevEnts.txt into tRevEnts table.
  21-07-2022 v0.4.0 Returns: true - if could load tRevEnts.txt
                             false - if couldn't load file tRevEnts.txt
  Sintax: loadRevEnt()
  ex: loadRevEnt()]]

  local t = loadTable("tRevEnts.txt")
	if not t then return false,"Can't load tRevEnts.txt" end
	tRevEnts = t
  return true
end

------ FUEL ------
function checkFuel(...) --[[ Checks if the fuel is enough.
  29/06/2022 v0.4.1 Param: ... - number of turtle moves.
                               - coords where to go (x, y, z).
  Returns:	true, number remaining fuel - if the fuel is enough.
					 false, negative number missing fuel - if the fuel is not enough.
           nil - if parameters are not numbers.
               - if quantity of parameters are not 1 or 3.
  Note: returns turtle.getFuelLevel() - if no parameters.
	sintax: checkFuel([nActions/x,y,z])
  ex: checkFuel(123) - checks if turtle has enough fuel to move 132 steps.
      checkFuel() - returns turtle.getFuelLevel()
      checkFuel(10, 20, 45) - checks if fuel is enough to go to coords (10, 20, 45).]]
  
  if type(turtle.getFuelLimit()) == "string" then return true end
  if #arg == 0 then return turtle.getFuelLevel() end

  local nActions = 0
  local tIndex = {"x", "y", "z"}
  if #arg == 1 then 
    if type(arg[1]) ~= "number" then
      return nil, "checkFuel([Actions|x, y, z]) - Actions or coords must be numbers."
    else
      nActions = nActions + arg[1]
    end
  elseif #arg == 3 then
    for iArg = 1, 3 do
      if type(arg[iArg]) ~= "number" then
        return nil, "checkFuel([Actions|x, y, z]) - Actions or coords must be numbers."
      else
        nActions = nActions + math.abs(tTurtle[tIndex[iArg]] - arg[iArg])
      end
    end
  else return nil, "checkFuel([Actions|x, y, z]) - Invalid number of parameters."
  end
  local nDif = turtle.getFuelLevel() - nActions
  if nDif > 0 then return true, nDif
  else return false, nDif
  end
end

function isFuelEnoughTo(x, y, z) --[[ Checks if the fuel is enough to go to x,y,z
  21-07-2022 v0.4.0 Param: x, y, z (numbers) - coords of the point where to go.
  Returns: checkFuel(...)
  Sintax: isFuelEnoughTo(x, y, z)
  ex: isFuelEnoughTo(10, 20, 50) - checks if there is enough fuel to go to (10, 20, 50)]]

  return checkFuel(x, y, z)
end

function refuel(nCount) --[[ Refuels the turtle with nCount items in the selected slot.
  23/09/2021 v0.1.0 Param: nCount - number of items to refuel.
  Returns:	number of items refueled.
						false - "Empty selected slot."
                  -	"Item is not fuel."
									- "Turtle doesn't need fuel."
									- "Turtle is at maximum fuel."
                  - "refuel(nItems) - nItems must be a number."
	sintax: refuel([nCount=stack of items])
  ex: refuel(123) - Fuels the turtle with 123 items.]] 
  
	local fuelLimit = turtle.getFuelLimit()
	if type(fuelLimit) == "string" then return false, "Turtle doesn't need fuel." end
	
	local fuelLevel = turtle.getFuelLevel()
	if fuelLevel == fuelLimit then return false, "Turtle is at maximum fuel." end
	
	local tData = turtle.getItemDetail()
	
	if not tData then return false, "Empty selected slot." end
	if not nCount then nCount = tData.count end
  if type(nCount) ~="number" then return false, "refuel(nItems) - nItems must be a number." end
	if not turtle.refuel(0) then return false, "Item is not fuel." end
	
	totRefuel = 0
	while totRefuel < nCount do
		if tData.count >= nCount then
			turtle.refuel(nCount)
			totRefuel = totRefuel + nCount
		else	turtle.refuel()
				totRefuel = totRefuel + tData.count
				if not itemSelect(tData.name) then break end
		end
	end
	return totRefuel
end


------ EQUIP ------
--not tested
function getFreeHand(sHand) --[[ Gets turtle free hand: "right"|"left"|false.
  23/09/2021 v0.4.0 Returns:	"right" or "left" the first free hand found.
										          false - if no free hand found.
                              nil - if invalid hand.
  Sintax: getFreeHand([sHand]=PREFEREDHAND)
  ex: getFreeHand() - Return the first free hand referenced from PREFEREDHAND and then the other hand, or false.]] 

  sHand = sHand or PREFEREDHAND
  sHand = string.lower(sHand)

  local tHands = {["right"] = 0, ["left"] = 1}
  if tHands[sHand] then
    if tTurtle[sHand.."Hand"] == "empty" then return sHand end
    sHand = getKey(bit32.bxor(tHands[sHand], 1), tHands)
    if tTurtle[sHand.."Hand"] == "empty" then return sHand end
  else return nil, "getFreeHand(Hand) - Hand must be left or right" end
  end
	return false
end

function equip(sSide) --[[ Equip tool from the selected slot.
  23/09/2021 v0.1.0 Param: sSide - String: "left"|"right"
  Returns:	true - if it was equiped.
	  				false - "Invalid side."
									- "Empty selected slot."
									- if it can't equip tool.
	sintax: equip([Side=first free hand(left|right)])
  ex: equip() - Try to equip tool in the selected slot to one free hand.]] 
  
	sSide = sSide or getFreeHand()
	if not sSide then sSide = "right" end
  sSide = string.lower(sSide)
  if not isValue(sSide, {"left", "right"}) then return false, 'equip([Side=free hand]) - Invalid side("left"|"right").' end
	local tData
	
	tData = turtle.getItemDetail()
	if not tData then return false, "Empty selected slot." end
	
	local success, reason = equipF[sSide]()
	if not success then return success, reason end
	tTurtle[sSide.."Hand"] = tData.name
	return true
end


------ TURTLE ------
function saveTurtle() --[[ Saves tTurtle to file tTurtle.txt.
  23/09/2021 v0.2.0 Returns:	true - if it could save the file.
											        false - if it couldn't save file.
  ex: saveTurtle() ]] 
  
  local success, reason = saveTable(tTurtle, "tTurtle.txt")
  if success then return success end
  return false, reason
end

function loadTurtle() --[[ Loads tTurtle from file tTurtle.txt.
  23/09/2021 v0.2.0 Returns:	true - if it could load the file to tTurtle.
										      		false - if it couldn't load file.
  ex: turtleLoad() ]] 
  
  local t = loadTable("tTurtle.txt")
	if not t then return false,"Can't load tTurtle.txt" end
	tTurtle = t
  return true
end


------ INIT ------
function INIT() --[[ Loads tTurtle.txt, tRecipes.txt from files to tables.
  02/11/2021 v0.4.0 Returns:	true]] 
  loadEnt()
  loadRevEnt()
  loadWorld()
	loadTurtle()
	loadRecipes()
  loadStacks()
  loadSpots()
	return true
end


------ TERMINATE ------
function TERMINATE() --[[ Saves tTurtle, tRecipes to text files.
  02/11/2021 v0.4.0 Returns:	true]] 
  saveEnt()
  saveRevEnt()
  saveWorld()
	saveTurtle()
	saveRecipes()
  saveStacks()
  saveSpots()
	return true
end


------ TURTLE STATUS FUNCTIONS ----
function setFacing(sFacing) --[[ Sets tTurtle.facing.
  02/10/2021 v0.2.0 Param: sFacing - "north"|"east"|"south"|"west"|"z+"|"z-"|"x+"|"x-"|"y+"|"y-"|"z+"|"z-"|0..3
  Sintax: setFacing(sFacing)
  Returns:  number - tTurtle.facing
             false - if no parameter was supplied.
                   - if sFacing is not in facingType.
                   - if sFacing is not a string.
  ex: setFacing("z+") - Sets the tTurtle.facing to "z+"=2]]
  
  if not sFacing then return false, 'setFacing(Facing) - Must supply facing ("north"|"east"|"south"|"west"|"z+"|"z-"|"x+"|"x-"|"y+"|"y-"|"z+"|"z-"|0..3).' end
  if type(sFacing) == "number" then
    sFacing = bit32.band(sFacing, 3)
  elseif type(sFacing) == "string" then
    sFacing = string.lower(sFacing)
    if facingType[sFacing] then sFacing = facingType[sFacing]
    elseif carDirType[sFacing] then sFacing = carDirType[sFacing]
    else return false, 'setFacing(Facing) - Invalid facing ("z+"|"z-"|"x+"|"x-"|"y+"|"y-"|"z+"|"z-"|0..3).'
    end
  else return false, 'setFacing(Facing) - Invalid facing type, must be a string ("z+"|"z-"|"x+"|"x-"|"y+"|"y-"|"z+"|"z-"|0..3).'
  end
  tTurtle.facing = sFacing
  return tTurtle.facing
end

function getFacing() --[[ Returns tTurtle.facing.
  02/10/2021 v0.2.0 Sintax: getFacing()
  Returns:  tTurtle.facing.
  ex: getFacing() - Outputs whatever is in tTurtle.facing [0..3].]]
  
  return tTurtle.facing
end

function setCoords(x, y, z) --[[ Set coords x, y, z for turtle.
  03/09/2021 v0.2.0 Param: z,y,z - numbers: new coords for tTurtle.x, tTurtle.y, tTurtle.z
  Sintax: setCoords(x, y, z)
  Returns:  true.
  ex: setCoords(10, 23, 45) - Sets coords x to 10, y to 23 and z to 45.]] 
  
  if not isNumber(x,y,z) then return false, "setCoords(x, y, z) - Coords must be numbers." end
	tTurtle.x, tTurtle.y, tTurtle.z = x, y, z
  return true
end

function getCoords() --[[ Gets coords from turtle.
  03/09/2021 v0.2.0 Returns: the turtle coords x, y, z.
  Sintax: getCoords()
  ex: getCoords() - Returns coords of turtle, 3 values, x, y, z.]] 
  
	return tTurtle.x, tTurtle.y, tTurtle.z
end


------ ATTACK FUCTIONS ------
function attackDir(sDir) --[[ Turtle attack in sDir direction.
  05/09/2021 v0.1.0 Param: sDir -  "forward"|"right"|"back"|"left"|"up"|"down".
  Returns:  true if turtle attack something.
            false - if there is nothing to attack, or no weapon.
                  - if invalid parameter.
  sintax: attackDir([sDir="forward"])
  ex: attackDir("left") - Rotates left and attacks. ]]
  
  sDir = sDir or "forward"
  if not (type(sDir) == "string") then return nil,'attackDir([Direction="forward"]) - Diretion must be a string: "forward"|"right"|"back"|"left"|"up"|"down"' end
  sDir = string.lower(sDir)
  
  if sDir == "forward" then return turtle.attack()
  elseif sDir == "right" then
    turnDir("right")
    return turtle.attack()
  elseif sDir == "back" then
    turnBack()
    return turtle.attack()
  elseif sDir == "left" then
    turnDir("left")
    return turtle.attack()
  elseif sDir == "up" then return turtle.attackUp()
  elseif sDir == "down" then return turtle.attackDown()
  end
  return nil, 'attackDir([Direction="forward"]) - Diretion must be "forward"|"right"|"back"|"left"|"up"|"down"'
end


------ MEASUREMENTS FUNCTIONS ------
function addSteps(nSteps) --[[ Returns nSteps added to turtle coords.
  24/09/2021 v0.2.0 Param: nSteps - number of waking steps for turtle.
  Sintax: addSteps([nSteps=1])
  Returns:  x,y,z adding nSteps in direction turtle is facing.
            false - if nSteps is not a number.
  Note: accepts positive and negative numbers.
  ex: addSteps() - Adds 1 to the coord of the turtle is facing.]] 
  
  nSteps = nSteps or 1

  if type(nSteps) ~= "number" then return false, "addSteps([Steps=1]) - Steps must be a number." end

	local x, y, z, facing = tTurtle.x, tTurtle.y, tTurtle.z, tTurtle.facing
		x = x+(facing == 1 and nSteps or 0)+(facing == 3 and -nSteps or 0)
		y = y+(facing == 4 and nSteps or 0)+(facing == 8 and -nSteps or 0)
		z = z+(facing == 2 and nSteps or 0)+(facing == 0 and -nSteps or 0)
  return x, y, z
end

function distTo(x, y, z) --[[ Gets the three components of the distance from the turtle to point.
  03/09/2021 v0.2.0 Param: x, y, z - coords of point to calculate distance to turtle.
  Sintax: distTo(x, y, z)
  Returns:  the x,y,z distance from turtle to coords x, y, z.
  Note: returns a negative value if turtle is further away than the point x, y, z.
  ex: distTo(1, 10, 34) - Returns 3 values.]] 
  
  if not isNumber(x,y,z) then return false, "distTo(x, y, z) - Coords must be numbers." end
	return x-tTurtle.x, y-tTurtle.y, z-tTurtle.z
end

function ABSDistTo(x, y, z) --[[ Computes the distance from turtle to x, y, z.
  15-08-2022 v0.4.0 Param: x, y, z - numbers the destination coords.
  Sintax: ABSDistTo(x, y, z)
  Returns: number - the distance from turtle to point x, y, z.]]

  return math.abs(tTurtle.x-x)+math.abs(tTurtle.y-y)+math.abs(tTurtle.z-z)
end

------ COMPARE FUNCTIONS ------
function compareDir(sDir, nSlot) --[[ Compares item in slot with block in sDir direction.
  21/09/2021 v0.1.0 Param: sDir - "forward"|"right"|"back"|"left"|"up"|"down".
                           nSlot - number 1..16
  Returns: true - if the item in slot and in the world is the same.
           false, "empty" - if there is no block in sDir.
           false, "diferent" - if the block in the world is diferent.
           false, "empty slot" - if nSlot is empty.
           nil - invalid direction,
               - if nSlot is not a number,
               - if nSlot is not in [1..16].
  sintax: compareDir([sDir="forward"][, nSlot=selected slot])
  ex: compareDir() compares selected slot with block in front of turtle.
  compareDir("left", 2) - compares item in slot 2 with block on the left.]]
  
	sDir, nSlot = getParam("sn", {"forward", turtle.getSelectedSlot()}, sDir, nSlot)
	sDir  = string.lower(sDir)
	if not dirType[sDir] then return nil, 'compareDir([Dir="forward"][, Slot=selected slot]) - Invalid direction "forward"|"right"|"back"|"left"|"up"|"down".' end
	if type(nSlot) ~= "number" then return nil, 'compareDir([Dir="forward"][, Slot=selected slot]) - Slot is not a number.' end
  if (nSlot < 0) or (nSlot > 16) then return nil, 'compareDir([Dir="forward"][, Slot=selected slot]) - Slot must be between 1 and 16.' end
  
	local invData = turtle.getItemDetail(nSlot)
	if not invData then return nil, 'empty slot' end
	
	if (sDir == "left") or (sDir == "right") or (sDir == "back") then
		turnDir(sDir)
		sDir = "forward"
	end
	
	local success, worlData = insF[sDir]()
  if success then
	  if worlData.name == invData.name then return true
    else return false, "diferent"
    end
  else
	  return false, "empty"
  end
end

function compareAbove(nBlocks) --[[ Compares nBlocks above the turtle in a strait line with selected slot block.
  04/09/2021 v0.1.0 Param: nBlocks - number of blocks to compare.
  Returns:  true - if all the blocks are the same.
            false, "blocked" - if it can't advance.
            false, "empty" - if it found a empty space.
            false, "diferent" - if it found a diferent block.
            false, "empty slot" - if selected slot is empty.
						nil, string - if invalid parameter.
  sintax: compareAbove([nBlocks=1])
  Note: nBlocks < 0 compares backwards, nBlocks > 0 compares forwards.
  ex: compareAbove() or compareAbove(1) - Compares 1 block up.]]
  
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return nil, "compareAbove([Blocks=1]) - Blocks must be a number." end  --nBlocks must be a number.
  local dir = sign(nBlocks)
  nBlocks = math.abs(nBlocks)

  local invData = turtle.getItemDetail()
	if not invData then return false, 'empty slot' end

  for i = 1, nBlocks do
    if not turtle.compareUp() then
      if not turtle.detectUp() then return false, "empty"
      else return false, "diferent"
      end
    end
    if nBlocks ~= i then
			if not forward(dir) then return false, "blocked" end
		end
  end
  return true
end

function compareBelow(nBlocks) --[[ Compares nBlocks below the turtle in a strait line with selected slot block.
  04/09/2021 v0.1.0 Param: nBlocks - number of blocks to compare.
  Returns:  true - if all the blocks are the same.
            false, "blocked" - if blocked.
            false, "empty" - if it found a empty space.
            false, "diferent" - it found a diferent block.
            false, "empty slot" - if selected slot is empty.
						nil, string - if invalid parameter.
  sintax: compareBelow([nBlocks=1])
  Note: nBlocks < 0 compares backwards, nBlocks > 0 compares forwards.
  ex: compareBelow() or compareBelow(1) - Compares 1 block down.]]
  
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return nil, "compareBelow([Blocks=1]) - Blocks must be a number." end
  local dir = sign(nBlocks)
  nBlocks = math.abs(nBlocks)
  
  local invData = turtle.getItemDetail()
	if not invData then return false, 'empty slot' end

  for i = 1, nBlocks do
    if not turtle.compareDown() then
      if not turtle.detectDown() then return false, "empty"
      else return false, "diferent"
      end
    end
    if nBlocks ~= i then
			if not forward(dir) then return false, "blocked" end
		end
  end
  return true
end


------ DETECT FUNCTIONS ------
function detectDir(sDir) --[[ Detects if is a block in sDir direction.
  03/09/2021 v0.1.0 Param: sDir - "forward"|"right"|"back"|"left"|"up"|"down".
  Returns:  true - If turtle detects a block.
           false - if turtle didn't detect a block.
             nil - invalid parameter.
  ex: detectDir([sDir="forward"]) - Detect blocks forward.]]
  
	sDir = sDir or "forward"
  sDir = string.lower(sDir)

	if sDir == "up" then return turtle.detectUp()
	elseif sDir == "down" then return turtle.detectDown()
	elseif sDir == "right" then
      turnDir("right")
      sDir = "forward"
	elseif sDir == "back" then
    turnBack()
    sDir = "forward"
	elseif sDir == "left" then
    turnDir("left")
    sDir = "forward"
	end
	if sDir == "forward" then return turtle.detect() end
  return nil, 'detectDir([Dir="forward"]) - Invalid Direction'
end

function detectAbove(nBlocks) --[[ Detects nBlocks forwards or backwards, 1 block above the turtle.
  03/09/2021 v0.1.0 Param: nBlocks - number of blocks to detect.
  Returns:  true - if turtle detects a line of nBlocks above it.
           false - if blocked, empty space.
	  				nil - if invalid parameter.
  sintax: detectAbove([nBlocks=1])
  Note: nBlocks < 0 detects backwards, nBlocks > 0 detects forwards.
  ex: detectAbove() or detectAbove(1) - Detects 1 block up.]]
  
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return nil, "detectAbove([Blocks=1]) - Blocks must be a number." end
  local dir = sign(nBlocks)

  for i = 1, nBlocks, dir do
    if not turtle.detectUp() then return false, "Didn't detect a block." end
    if nBlocks ~= i then
			if not forward(dir) then return false, "Can't advance forward."  end
		end
  end
  return true
end

function detectBelow(nBlocks) --[[ Detects nBlocks forwards or backwards, 1 block below the turtle.
  03/09/2021 v0.1.0 Param: nBlocks - number of blocks to detect.
  Returns:  true - if turtle detects a line of nBlocks below.
           false - if blocked, empty space.
             nil - if invalid parameter
  sintax: detectBelow([nBlocks=1])
  Note: nBlocks < 0 detects backwards, nBlocks > 0 detects forwards.
  ex: detectBelow() or detectBelow(1) - Detect 1 block down.]]
  
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return nil, "detectBelow([Blocks=1]) - Blocks must be a number." end
  local dir = sign(nBlocks)

  for i = 1, nBlocks, dir do
    if not turtle.detectDown() then return false, "Didn't detect a block." end
    if i ~= nBlocks then
			if not forward(dir) then return false, "Can't advance forward." end
		end
  end
  return true
end


------ INSPECT FUNCTIONS ------
function inspectDir(sDir) --[[ Inspect a block in sDir "forward"|"right"|"back"|"left"|"up"|"down"|"north"|"east"|"south"|"west".
  05/09/2021 v0.4.0 Param: sDir - "forward"|"right"|"back"|"left"|"up"|"down"|"north"|"east"|"south"|"west".
  Returns:  true, table with data - If turtle detects a block.
            false, message - if turtle didn't detect a block.
            nil - if invalid parameter sDir.
	Note: tData = { name = "minecraft:oak_log",
									state = { axis = "x" },
									tags = { ["minecraft:logs"] = true, ... },
									ent = number id in the table tEnt
  ex: inspectDir([sDir="forward"]) - Inspects a block forward.]]
  
	sDir = sDir or "forward"
  sDir = string.lower(sDir)

	if carDirType[sDir] then
		turnTo(sDir)
		sDir = "forward"
	elseif dirType[sDir] then
		turnDir(sDir)
		if (sDir ~= "up") and (sDir ~= "down") then sDir = "forward" end
	else return nil, 'inspectDir(Dir) - Dir must be "forward"|"right"|"back"|"left"|"up"|"down"|"north"|"east"|"south"|"west"'
	end
	
	local success, tData = insF[sDir]()
	if not success then return false, tData end
  tData.ent = addEnt(tData.name)
	return tData
end

------ MOVING FUNCTIONS ------
function forward(nBlocks) --[[ Moves nBlocks forward or backwards, until blocked.
  27/08/2021 v0.2.0 Param: nBlocks - number of blocks to walk.
  Returns:  true - if turtle goes all way.
           false - "Can't advance forward."
             nil - invalid nBlocks type.
  Sintax: forward([nBlocks=1])
  Note: nBlocks < 0 moves backwards, nBlocks > 0 moves forward.
  ex: forward(3) - Moves 3 blocks forward.]] 
  
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return nil, "forward([Blocks=1]) - Blocks must be a number." end
  if nBlocks < 0 then return back(math.abs(nBlocks)) end
  for i = 1, nBlocks do
    if not turtle.forward() then return false, "Can't advance forward."
    else tTurtle.x, tTurtle.y, tTurtle.z = addSteps()
    end
  end
  return true
end

function back(nBlocks) --[[ Moves nBlocks back or forward, until blocked.
  27/08/2021 v0.2.0 Param: nBlocks - number of blocks to walk backwards. 
  Returns:  true - if turtle goes all way.
           false - if turtle was blocked.
             nil - if nBlocks is not a number.
  Note: nBlocks < 0 moves forward, nBlocks > 0 moves backwards.
  ex: back(-3) - Moves 3 blocks forward.]]
  
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return nil, "back([Blocks=1]) - Blocks must be a number." end
  if nBlocks < 0 then return forward(math.abs(nBlocks)) end
  for i = 1, nBlocks do
    if not turtle.back() then return false, "Can't go backward."
    else tTurtle.x, tTurtle.y, tTurtle.z = addSteps(-1)
    end
  end
  return true
end

function up(nBlocks) --[[ Moves nBlocks up or down, until blocked.
  27/08/2021 v0.2.0 Param: nBlocks - number of blocks to walk up.
  Returns:  true - if turtle goes all way.
           false - if turtle was blocked.
             nil - if nBlocks is not a number.
  Note: nBlocks < 0 moves downwards, nBlocks > 0 moves upwards.
  ex: up(3) - Moves 3 blocks up.]]
  
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return nil, "up([Blocks=1]) - Blocks must be a number." end
  if nBlocks < 0 then return down(math.abs(nBlocks)) end
  for i = 1, nBlocks do
    if not turtle.up() then return false, "Can't move up."
    else  tTurtle.y = tTurtle.y + 1
    end
  end
  return true
end

function down(nBlocks) --[[ Moves nBlocks down or up, until blocked.
  27/08/2021 v0.2.0 Param: nBlocks - number of blocks to walk down.
  Returns:  true - if turtle goes all way.
           false - if turtle was blocked.
             nil - if nBlocks is not a number.
  Note: nBlocks < 0 moves up, nBlocks > 0 moves down.
  ex: down(3) - Moves 3 blocks down.]]
  
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return nil, "down([Blocks=1]) - Blocks must be a number." end
  if nBlocks < 0 then return up(math.abs(nBlocks)) end
  for i = 1, nBlocks do
      if not turtle.down() then return false, "I can't go down anymore."
      else  tTurtle.y = tTurtle.y -1
      end
  end
  return true
end


------ GENERAL FUNCTIONS ------
function checkNil(nArg, ...) --[[ Checks for nil parameters.
	21-07-2022 v0.4.0 Param: nArg - number of parameters
                           ... - parameters to test
  Returns: true, number of parameters that are nil.
           false - there is no nil parameters
           nil - if nArg not supplied.
               - if nArg not a number.
  sintax:checkNil(nArg, ...)
	ex: checkNil(2, 2) - returns true, 1]]

  if not nArg then return nil, "checkNil(nArg, ...) - Must supply nArg as the number of arguments." end
  if type(nArg) ~= "number" then return nil, "checkNil(nArg, ...) - narg must be a number." end

  local dif = #arg - nArg
	if dif < 0 then return true, math.abs(dif)
  else return false
  end
end

function loadTable(sFileName) --[[ Loads a text file into a table.
  27/09/2021 v0.2.0 Param: sFileName - string the file name.
  Sintax: loadTable(sFileName)
  Returns: table - if could read a text file into a table.
           false - if sFileName is not supplied,
                 - if the file couldn't be opened for reading,
                 - if the file is empty.
  ex: loadTable("oneFile.txt") - Loads file "oneFile.txt" returns it as a table.]]
  
	if not sFileName then return false, "loadTable(FileName) - Must supply file name." end
	
  local fh,t
  if not fs.exists(sFileName) then return false, "loadTable - file not found" end
  fh=fs.open(sFileName, "r")
	if not fh then return false, "loadTable - can't open file "..sFileName end
  t=textutils.unserialize(fh.readAll())
	if not t then return false, "loadTable - empty file "..sFileName end
  fh.close()
  return t
end

function saveTable(t, sFileName) --[[ Saves a table into a text file.
  27/09/2021 v0.2.0 Param: t - table to save.
                   sFileName - string filename.
  Sintax: saveTable(t, sFileName)
  Returns:  true - if saving file was a success.
           false - if t or sFileName not supplied,
                 - if no disk space,
                 - if it couldn't create file.
  Note: if not supplied extension it adds ".txt" to the file name.
  ex: saveTable(oneTable, "oneFile") - Saves table oneTable into "oneFile.txt" file.]]
  
	if not t or not sFileName then return false, "Table or filename not supplied." end --no arguments
	
  if not string.find(sFileName, "[.]") then sFileName=sFileName..".txt" end --if no extension add 1
	local str2Save = textutils.serialize(t)
	if string.len(str2Save) > fsGetFreeSpace("/") then return false,"no disk space" end
	
	local fh = fs.open(sFileName, "w") --open file for write
	if not fh then return false, "couldn't open file for write." end
	
	fh.write(str2Save) --transform table values and keys in strings
	fh.close() --close file handle(file)
	return true --return success
end

function checkType(sType, ...) --[[ Checks if parameters are from sType.
  03/09/2021 v0.1.0 Param: sType - string where "s" stands for string, "t" for table, "n" for number, "b" for boolean.
                           ... - the paremeters to check.
  Returns: true - if all parameters match the sType.
  ex: checkType("snt", "hello", number1, tTable) - Outputs: true.]]
  
	Args = { ... }
  
  if #Args ~= #sType then return false end
	for i = 1, #sType do
		if sType:sub(i,i) ~= type(Args[i]):sub(1,1) then return false end
	end
	return true
end

function getKey(value, t) --[[ Gets the first key from table t where the key is the index of value.
  09-08-2022 v0.4.0 Param: value - the value in table t.
                           t - the table that has the value.
  Sintax: getKey(value, t)
  Return: the key corresponding to value in table t.
          false - if value is not found
  ex: getKey(2, {"first"=1, "second"=2}) - returns second]]

  if checkNil(2, value, t) then return nil, "getKey(value, t) - you must supply value and t table." end
	for k, v in pairs(t) do
		if v == value then return k end
	end
	return false
end

function getParam(sParamOrder, tDefault, ...) --[[ Sorts parameters by type.
  27/08/2021 v0.1.0 Param: sParamOrder - string where "s" stands for string, "t" for table, "n" for number, "b" for boolean.
                           tDefault - table with default values.
                           ... - parameters to order.
  Returns:  Parameters sorted by type,
            nil - if no parameters.
  sintax: getParam(sParamOrder, tDefault[, ...])
  ex: getParam("sns", {"default" }, number, string) - Outputs: string, number, default.
  Note: Only sorts parameters type (string, table, number and boolean).]]
  
  if not sParamOrder then return nil, "getParam(sParamOrder, tDefault, ...) - Must supply string with parameters order." end
  if not tDefault then return nil, "getParam(sParamOrder, tDefault, ...) - Must supply table with default values." end
  local Args={...}
  --if #Args == 0 then return nil, "getParam(sParamOrder, tDefault, ...) - Must supply parameters to order." end
  
  local retTable = {}
  local checked={}

  function addParam(sType) --add parameter do returning table
    for i = 1, #Args do
      if type(Args[i]) == sType then
        if not checked[i] then
          checked[i]=true
          table.insert(retTable, Args[i])
          return
        end
      end
    end

    for k, v in pairs(tDefault) do
      if type(v) == sType then table.insert(retTable, v) end
    end
  end

  for i = 1, #sParamOrder do
    if sParamOrder:sub(i,i) == "s" then addParam("string")
    elseif sParamOrder:sub(i,i) == "t" then addParam("table")
    elseif sParamOrder:sub(i,i) == "n" then addParam("number")
    elseif sParamOrder:sub(i,i) == "b" then addParam("boolean")
    end
  end
  
  if #retTable == 0 then return nil
  else return table.unpack(retTable);
  end
end

function isValue(value, t) --[[ Checks if value is in t table.
  21/09/2021 v0.2.0 Param:  value - any type of value.
                            t - table with values to compare.
  Sintax: isValue(value, t)
  Returns:  true, key - if value is in t, key corresponding to value.
            false - if value is not in t.
  ex: isValue(2, {["hello"] = 2, ["hi"] = 4}) - Outputs: true, "hello".]]
  
  for k,v in pairs(t) do
    if v == value then return true, k end
  end
  return false
end

function isNumber(...) --[[ Checks if all parameters are numbers.
  20/04/2022 v0.3.0 Param:  ... - parameters to check
  Returns:  true - if all parameters are numbers.
           false - if at least one parameter is not a number.
  sintax: isNumber(...)
  ex: isNumber(2, "hello", 4}) - Outputs: false.]]
  
  Args = {...}
  if #Args == 0 then return false end
  for i = 1, #Args do
    if type(Args[i]) ~= "number" then return false end
  end
  return true
end

function tableInTable(tSearch, t) --[[ Verifies if al elements of tSearch is in table t.
  27/08/2021 v0.1.0 Param: tSearch - table contains values to search in table t.
                           t - table to search.
  Returns:  true - tSearch is in t.
           false - at the least one element of tSearch is not in table t.
  Sintax: tableInTable(tSearch, t)
  ex: tableInTable("forward", lookingType) - outputs true.]]
  
  if type(tSearch) ~= "table" then return nil, "tableInTable(tSearch, t) - tSearch (items to search in t) must be a table." end

  totMatch = 0

  for k1, v1 in pairs(tSearch) do
    for k2, v2 in pairs (t) do
      if v2 == v1 then
        totMatch = totMatch + 1
        break
      end
    end
  end

  if #tSearch ~= totMatch then return false, "There are at least 1 item not present in t." end
  return true
end

function sign(value) --[[ Returns: -1 if value < 0, 0 if value == 0, 1 if value > 0
  28/08/2021 v0.1.0 Param: value - number to evaluate.
  Sintax: sign(value)
  Returns false if value is not a number, or not supplied.]]
  
  if type(value) ~= "number" then return false, "sign(value) - Is not a number or not supplied." end
  if value < 0 then return -1 end
  if value == 0  then return 0 end
  return 1
end

------ STACK FUNCTIONS ------
function saveStacks() --[[ Saves tStacks in a file as "tStacks.txt"
  10/11/2021 v0.2.0 Returns false - if it couldn't save file.
                            true - if it could save file.
  sintax: saveStacks()]]
  
  return saveTable(tStacks, "tStacks.txt")
end

function loadStacks() --[[ Loads tStacks from file "tStacks.txt"
  10/11/2021 v0.2.0 Returns false - if it couldn't load file.
                            true - if it could load file.
  sintax: loadStacks()]]
  
  local t = loadTable("tStacks.txt")
	if not t then return false, "loadStacks() - Couldn't load tStacks.txt" end
	tStacks = t
  return true
end

function getStack(nSlot) --[[ Returns how many items can stack.
  10/11/2021 v0.2.0 Param: nSlot - slot number 1..16, or the item name.
  Sintax: loadStacks()
  Return: number - quantity a item can stack.
             nil - if slot is out of range[1..16].
           false - if slot is empty.
                 - if item was not found in inventory.
  sintax: getStack([nSlot/sItemName = selected slot]).
  ex: getStack() - gets the stack of item in selected slot.
      getStack("minecraft:oak_planks") - gets the stack for oak_planks, in inventory or in tStacks.]]
  
  nSlot = nSlot or turtle.getSelectedSlot()

  local tData, nStack
  if type(nSlot) == "number" then
    if nSlot < 1 or nSlot > 16 then return nil, "getStack(Slot/ItemName) - Slot out of range[1..16]." end
    tData = turtle.getItemDetail(nSlot)
    if not tData then return false, "getStack(Slot/ItemName) - Empty slot." end
    nStack = turtle.getItemSpace(nSlot) + tData.count
    if not tStacks[tData.name] then tStacks[tData.name] = nStack  end
  elseif type(nSlot) == "string" then
      if tStacks[nSlot] then nStack = tStacks[nSlot]
      else
        print(nSlot)
        nSlot = search(nSlot)
        if not nSlot then return false, "Item not found" end
        tData = turtle.getItemDetail(nSlot)
        nStack = tData.count + turtle.getItemSpace(nSlot)
        tStacks[tData.name] = nStack
      end
  else
    return false, "getStack(Slot/ItemName) - Slot/ItemName must be a string/number"
  end
  return nStack
end

function invLowerStack(sItem) --[[ Returns the lower stack of items in inventory, the slot and the name of item.
  17/12/2021 v0.2.0 Param: sItem - string - item name.
  Return: number, number, string - the lowerstack of items in inventory, the Slot, the name of item.
          false - if item not found.
  sintax: invLowerStack([sItem]).
  ex: invLowerStack() - gets the lowest stack of items in inventory, the slot, and the item name.
  invLowerStack("minecraft:oak_planks") - gets the lowest stack for oak_planks in inventory, the slot and the item name.]]
  
  local nLower, nRSlot = false
  local sName = ""
  for nSlot = 1, 16 do
    local tData = turtle.getItemDetail(nSlot)
    if tData then
      if not nLower then nLower = 9999 end
      if sItem then
        if sItem == tData.name then
          if nLower > tData.count then
            nLower = tData.count
            sName = tData.name
            nRSlot = nSlot
          end
        end
      else
        if nLower > tData.count then
          nLower = tData.count
          sName = tData.name
          nRSlot = nSlot
        end
      end
    end
  end
  if nLower == 9999 then return false, "Item not found."
  else return nLower, nRSlot, sName
  end
end

function setStackSlot(nSlot) --[[ Sets table tStacks with item in nSlot.
  24-07-2022 v0.4.0 Param: nSlot - number 1..16, where to get how many the item can stack.
  Returns: number - how many the item can stack.
           false - if slot is empty
           nil - if nSlot is not a number.
               - if nSlot is out of bounds 1..16
  Sintax: setStackSlot([nSlot=selected slot])]]

  nSlot = nSlot or turtle.getSelectedSlot()
	
	local tData, nStack
	if type(nSlot) ~= "number" then return nil, "setSlotStack(Slot) - Must be a number [1..16]." end --nSlot is not a number
	if nSlot < 1 or nSlot > 16 then return nil, "setSlotStack(Slot) - Must be between 1 and 16."end --is valid
  tData = turtle.getItemDetail(nSlot)
	if not tData then return false, "Slot is empty." end --is empty nSlot
	nStack = turtle.getItemSpace(nSlot) + tData.count --calculate stack for this item
	setStack(tData.name, nStack) --store nStack in tStacks[id]=nStack
  return nStack
end

function setStack(sItemName, nStack) --[[ Sets the item stack value in tStacks.
  10/11/2021 v0.2.0 Param: sItemName - string item name.
                           nStack - number how much item can stack.
  Return: true - if it could set the stack for item.
           nil - if no item name supplied.
               - if no stack number is supplied.
  sintax: setStack(sItemName = selected slot) ]]
  
  sItemName, nStacks = getParam("sn", {"", -1}, sItemName, nStack)
  if sItemName == "" then return nil, "Must supply item name." end
  if nStack == -1 then return nil, "Must supply stack." end
  if nStack < 1 then return nil, "Stack out of range [1..]." end
  tStacks[sItemName] = nStack
  return true
end

------ RECIPES FUNCTIONS ------
function getInvItems() --[[ Builds a table with the items and quantities in inventory.
  20/11/2021 v0.3.0 Return: table - with ingredient name and quantity.]]
  
  local tQuant = {}
  for nSlot = 1, 16 do
    local tData = turtle.getItemDetail(nSlot)
    if tData then
      if tQuant[tData.name] then tQuant[tData.name] = tQuant[tData.name] + tData.count
      else tQuant[tData.name] = tData.count
      end
    end
  end
  return tQuant
end

function getRecipeItems(sRecipe, nIndex) --[[ Builds a table with items and quantities in a recipe.
  20/11/2021 v0.3.0 Param:  sRecipe - recipe name.
                            nIndex - recipe index
  Return: table - with recipe ingredient name and quantity.
          false - if no recipe name was supplied and there isn't tRecipes.lastRecipe
                - if tRecipes[sRecipe] dosn't exist, (never was made).
                - if the tRecipes[sRecipe[nIndex] doesn't exist.
  Sintax: getRecipeItems([sRecipeName = tRecipes.lastRecipe][, nIndex=1])
  ex: getRecipeItems("minecraft:stick", 1) - returns: {["minecraft_oak_planks"] = 2} ]]
  
  sRecipe, nIndex = getParam("sn", {"", 1}, sRecipe, nIndex)

  if sRecipe == "" then sRecipe = tRecipes.lastRecipe end
  if not sRecipe then return false, "Must supply recipe name." end
  if not tRecipes[sRecipe] then return false, "Recipe name not found" end
  if not tRecipes[sRecipe][nIndex] then return false, "Recipe index not found" end

  local tRecipe = {}
  local tRecs = tRecipes[sRecipe][nIndex].recipe
  for i = 1, #tRecs do
    if tRecipe[tRecs[i][1]] then tRecipe[tRecs[i][1]] = tRecipe[tRecs[i][1]] + 1
    else tRecipe[tRecs[i][1]] = 1
    end
  end
  return tRecipe
end

function canCraftRecipe(sRecipe) --[[ Checks if you can craft sRecipe with inventory items.
  09/07/2022 v0.3.0 Param: sRecipe - string the recipe name.
  returns: true, number index of recipe.
           false
  sintax: canCraftRecipe(sRecipe)
  Note: if you didn't craft this recipe earlier this functions returns true, even with all items in inventory.
  ex: canCraft("minecraft:stick") - if you have created this recipe and all items are in inventory it returns true.]]

  local bSuccess, tRecs = canCraft()
  if not bSuccess then return false end
  for iRec = 1, #tRecs do
    for k, v in pairs(tRecs[iRec]) do
      if sRecipe == k then return true, v end
    end
  end
  return false
end

function canCraft() --[[ Retuns a table with recipe name and index that you can craft from inventory.
  20/11/2021 v0.3.0 Return: true, table - with recipe name and index.
                            false - if no recipe can be crafted.
  Sintax: canCraft()
  Note: table={[name]=recipe index}
  ex: canCraft()]]
  
	local tCRecipes = {} --recipes it can craft with items in inventory
	local tInvItems = getInvItems() --items in inventory
	for k, v in pairs(tRecipes) do
    if type(v)=="table" then
      for iRecipe = 1, #v do
        bFound = true
        local tRecipeItems = getRecipeItems(k, iRecipe)
        for k1, v1 in pairs(tRecipeItems) do
          if not tInvItems[k1] then
            bFound = false
            break
          else
            if tInvItems[k1]<v1 then
              bFound = false
              break
            end
          end
        end
        if bFound then tCRecipes[#tCRecipes+1] = {[k] = iRecipe} end
      end  
    end
  end
  if #tCRecipes~=0 then return true, tCRecipes
  else return false
  end
end

function haveItems(sRecipe, nIndex) --[[ Builds a table with the diference between the recipe and the inventory.
  23/11/2021 v0.3.0 Param: sRecipe - string recipe name.
                           nIndex - number index of the recipe
  Return: false/true, table - with ingredients name and the diference between the recipe and inventory.
          nil - if no recipe name was supplied and there isn't tRecipes.lastRecipe and there is not a recipe in inventory.
              - if sRecipe dosn't exist, (never was made).
  Note: on the table, negative values indicate missing items.
        if not it returns true and the table.
  Sintax: haveItems([sRecipeName = tRecipes.lastRecipe][, nIndex =1])
  ex: haveItems() = haveItems(tRecipes.lastRecipe, 1) - Retuens the table with the diference between the inventory and the recipe.]]
  
  sRecipe, nIndex = getParam("sn", {"", 1}, sRecipe, nIndex)
  if sRecipe == "" then sRecipe = tRecipes.lastRecipe end
  if not sRecipe then return false, "haveItems(RecipeName, Index) - Recipe name not supplied." end

  local tNeededIng
  tNeededIng, message = getRecipeItems(sRecipe, nIndex)
  if not tNeededIng then return nil, "haveItems(sRecipe, nIndex) - "..message end

  local tInvIng = getInvItems()
  local tIngredients = {}
  local bHave = true
  
  for k,v in pairs(tNeededIng) do
    tIngredients[k] =  -v
    for k1,v1 in pairs(tInvIng) do
      if k == k1 then
        tIngredients[k] = tIngredients[k] + v1
      end
    end
    if tIngredients[k] < 0 then bHave = false end
  end
  return bHave, tIngredients
end

function saveRecipes() --[[ Saves tRecipes in a file as "tRecipes.txt"
  19/10/2021 v0.2.0 Returns false - if it couldn't save file.
                            true - if it could save file.
  sintax: saveRecipes()]]
  
	return saveTable(tRecipes, "tRecipes.txt")
end

function loadRecipes() --[[ Loads tRecipes from file "tRecipes.txt"
  19/10/2021 v0.2.0 Returns false - if it couldn't load file.
                            true - if it could load file.
  sintax: loadRecipes()]]
  
	local t = loadTable("tRecipes.txt")
	if not t then return false,"loadRecipes() - Couldn't load tRecipes.txt" end
	tRecipes = t
  return true
end

function getRecipe(sRecipe, nIndex) --[[ Gets the recipe from tRecipes.
  14/4/2022 v0.3.0 Param:  sRecipe - recipe name.
                           nIndex - recipe index.
  Returns: table - the recipe.
           false - if recipe name is not supplied and doesn't exist last recipe.
                 - if recipe name doesn't exist.
                 - if recipe index doesn't existy.
  Sintax: getRecipe([sRecipe = tRecipes.lastRecipe][, nIndex=1]) ]]
  
  sRecipe, nIndex = getParam("sn", {"", 1}, sRecipe, nIndex)
  if sRecipe == "" then sRecipe = tRecipes.lastRecipe end
  if not sRecipe then return false, "Must supply recipe name." end
  if not tRecipes[sRecipe] then return false, "Recipe name not found." end
  if not tRecipes[sRecipe][nIndex] then return false, "Recipe index not found." end
  return tRecipes[sRecipe][nIndex]
end

function getInvRecipe() --[[ Builds a table with items and their position from inventory (the recipe).
  19/10/2021 v0.3.0 Returns false - if it is not a recipe in the inventory.
                            tRecipe - the recipe with items and positions.
  Sintax: getInvRecipe()
  Note: Trecipe[item number].name = item name
        (the first item in table only have the item name)
        Trecipe[item number > 1].name = item name
        Trecipe[item number > 1].col = distance to first item col
        Trecipe[item number > 1].lin = distance to first item lin
        (the 2nd and posterior items have name, col and lin indexes in table)]]
  
  if not turtle.craft(0) then return false, "This is not a recipe." end
  
	local index, tFirstItem, tData, tRecipe = 1
	
	for lin = 0, 3 do
		for col = 0, 3 do
			tData = turtle.getItemDetail(lin*4+col+1)
			if tData then
				if not tFirstItem then
					tRecipe = {}
          tRecipe[index] = {}
          tRecipe[index][1] ={}
          tRecipe[index][1] = tData.name
          tFirstItem = {}
          tFirstItem.col = col
          tFirstItem.lin = lin
				else
          tRecipe[index] = {}
					tRecipe[index][1] = {}
          tRecipe[index][1] = tData.name
					tRecipe[index].col = col - tFirstItem.col
					tRecipe[index].lin = lin - tFirstItem.lin
				end
        index = index + 1
			end
		end
	end
  return tRecipe
end

function getMaxCraft() --[[ Returns maximum limit to craft the recipe on inventory.
  19/10/2021 v0.2.0 Returns false - if it is not a recipe in the inventory.
                            tRecipe - the recipe with items and positions.
  sintax: getMaxCraft()]]
  
  --if not turtle.craft(0) then return false, "This is not a recipe." end
  local tIng = getInvItems() --[ingredient name] = quantity
  local tIngSlots = countItemSlots() --[ingredient name] = quantity of slots ocupied

  local minCount = 512
	for k,v in pairs(tIng) do
    for k1, v1 in pairs(tIngSlots) do
      if k == k1 then
        if minCount > (v/v1) then
          minCount = v/v1
          break
        end
      end
    end
  end
	return math.floor(minCount)
end

function getFirstItemCoords(sRecipe, nIndex) --[[ Returns the column and line=0 of the first item in the recipe.
  19/10/2021 v0.2.0 Param: sRecipe - stringh recipe name.
                           nIndex - number index of the recipe tRecipes[sRecipe][nIndex].
  Returns:  col, lin - the column and line of first item.
               false - if the recipe name was not supplied and doesn't exist in tRecipes.lastRecipe.
                     - if this recipe does not exist.
  sintax: getFirstItemCoords([sRecipe=tRecipes.lastRecipe][, nIndex=1]) ]]
  
  sRecipe, nIndex = getParam("sn", {tRecipes.lastRecipe, 1}, sRecipe, nIndex)                       
  if type(sRecipe) == "number" then return false, "Must supply recipe name." end
  if not tRecipes[sRecipe] then return false, "Recipe not found." end

  local col = 9
  local tRec = tRecipes[sRecipe][nIndex].recipe
  for iRec = 1, #tRec do
    if tRec[iRec].col then
      if tRec[iRec].col < col then col = tRec[iRec].col end
    end
  end
  if col > 0 then return 0, 0 end
  return math.abs(col), 0
end

function searchSpace(sItemName, nStartSlot, bWrap) --[[ Search for space in a slot that has sItemName.
  19/10/2021 v0.2.0 Param: sItemName - string item name.
                           nStartSlot - number starting slot.
                           bWrap - boolean if search wraps around the inventory.
  Returns:  nSlot, nSpace - Slot where is this item, and number of space.
                    false - if it didn't find a slot with sItemName and some space.
  sintax: searchSpace(sItemName [, nStartSlot = Selected slot][, bWrap = true]).
  ex: searchSpace("minecraft:oak_planks") - Search for a not complete stack of oak boards.
      searchSpace("minecraft:cobblestone", 16, false) - Checks if slot 16 has cobblestone and space for more.
      searchSpace("minecraft:cobblestone", 5) - Searchs for cobblestone a incomplete stack, starting at slot 5 in all inventory.]]
  
  local nSlot, nSpace = nStartSlot
  repeat
    nSlot = search(sItemName, nSlot, bWrap)
    if nSlot then
      nSpace = turtle.getItemSpace(nSlot)
      if nSpace > 0 then return nSlot, nSpace end
    end
    nSlot = incSlot(nSlot, bWrap)
  until nSlot == nStartSlot
  return false
end

function leaveItems(sItemName, nQuant, bWrap) --[[ Leaves nQuant of item in Selected Slot, moving item from or to another slot.
  19/10/2021 v0.2.0 Param: sItemName - string name of the item.
                              nQuant - number quantity of items to leave in selected slot.
                               bWrap - boolean if it cam put excess items in lower slots (wrap around inventory).
  Returns:  true - if there is nQuant of items in selected slot.
           false - if sItemName not supplied.
           false - if there is no items to tranfer to selected slot or no space to tranfer items to.
  Sintax: leaveItems([sItemName = Selected Slot Item Name][, nQuant=0][, bWrap=true])
  ex: leaveItems() - Removes items from selected slot.
      leaveItems("minecraft:cobblestone") - Removes items from selected slot.
      leaveItems("minecraft:cobblestone", 6) - Leaves 6 items of cobllestone in selected slot]]
  
  sItemName, nQuant, bWrap = getParam("snb", {"", 0, true}, sItemName, nQuant, bWrap)
  local tData = turtle.getItemDetail()

  local nOrgSlot, nStored = turtle.getSelectedSlot()
  local nLastSlot = nOrgSlot

  if sItemName == "" then
    if not tData then return false, "Slot empty and item name not supplied."
    else sItemName = tData.name
    end
  else
    if tData then
      if tData.name ~= sItemName then
        clearSlot(nOrgSlot, bWrap)
        tData = turtle.getItemDetail()
      end
    end
  end

  if tData then nStored = tData.count
  else nStored = 0
  end

  if nQuant < 0 then nQuant = nStored + nQuant end

  while (nStored ~= nQuant) do
    local nDestSlot, nDestSpace, nOrgSpace
    nLastSlot = incSlot(nLastSlot, bWrap)
    if not nLastSlot then break end

    if nStored > nQuant then
      nDestSlot, nDestSpace = searchSpace(sItemName, nLastSlot, bWrap)

      if not nDestSlot or (nDestSlot == nOrgSlot) then
        nDestSlot = getFreeSlot(nLastSlot, bWrap)
        if not nDestSlot then break end
        nDestSpace=64
      end

      if nDestSpace > (nStored - nQuant) then
        turtle.transferTo(nDestSlot, nStored - nQuant)
      else 
        turtle.transferTo(nDestSlot, nDestSpace)
      end
    else
      nDestSlot = search(sItemName, nLastSlot, bWrap)
      if not nDestSlot then break end
      transferFrom(nDestSlot, nQuant - nStored)
    end
    nLastSlot = nDestSlot
    nStored = turtle.getItemCount()
  end
  if nStored == nQuant then return true end
  return false
end

function clearSlot(nSlot, bWrap) --[[ Clears content of slot, moving items to another slot.
  19/10/2021 v0.2.0 Param: nSlot - number slot to clear.
                           bWrap - slot where to put excess items can be lower than nSlot(wrap around inventory).
  Returns:  false - if there is no space to tranfer items.
             true - if the slot is empty.
              nil - if nSlot is out of range [1..16].
  Sintax: clearSlot([nSlot=selected slot][], bWrap)]]
  
  nSlot, bWrap = getParam("nb", {turtle.getSelectedSlot(), true}, nSlot, bWrap)
  if nSlot > 16 or nSlot < 1 then return nil, "clearSlot(Slot, Wrap) - Slot out of range." end
  if isEmptySlot(nSlot) then return true end
  if turtle.getSelectedSlot() ~= nSlot then turtle.select(nSlot) end 
  return leaveItems(0, bWrap)
end  
    
function transferFrom(nSlot, nItems) --[[ Transfer nItems from nSlot to selected slot.
  02/11/2021 v0.2.1 Param: nSlot - number slot where to transfer from.
                          nItems - number items to transfer from.
  Returns:  number of items in selected slot.
            nil - if nSlot not supplied.
                - if nItems is not a number
          false - if nSlot is empty.
                - if nSlot is out of range [1..16].
                - if selected slot is full.
  sintax: transferFrom(nSlot [, nItems=64]) ]]
  
  if not nSlot then return nil, "transferFrom(nSlot, nItems) - Must supply origin slot." end
  nItems = nItems or DEFSTACK --default stack
  
  local tData = turtle.getItemDetail(nSlot)
  if not tData then return false, "Empty origin slot." end
  local destSlot = turtle.getSelectedSlot()

  if nSlot < 1 or nSlot > 16 then return false, "transferFrom(nSlot, nItems) - Slot out of range [1..16]." end
  turtle.select(nSlot)

  if type(nItems) ~= "number" then return nil, "transferFrom(nSlot, nItems) - nItems must be a number." end
  if nItems < 0 then return nil, "transferFrom(nSlot, nItems) - nItems must be positive." end
  if not turtle.transferTo(destSlot, nItems) then
    turtle.select(destSlot)
     return false, "Couldn't tranfer items."
  end
  turtle.select(destSlot)
  tData = turtle.getItemDetail(destSlot)
  if not tData then return 0 end
  return tData.count
end

function recipeSlots(sRecipe, nIndex) --[[ Builds a table with item and quantity of slots ocupied by the item.
  21/01/2022 v0.2.0 Param:  SRecipe - string recipe name.
                            nIndex - number recipe index.
  Returns:  table with item name and quantity of slots ocupied by it.
            false - if sRecipe is not supplied and tRecipes.lastRecipe doesn't exist.
                  - if tRecipes[sRecipe] doesn't exist.
                  - if tRecipes[sRecipe][nIndex] doesn't exist.
	sintax: recipeSlots([sRecipe=tRecipes.lastRecipe][, nIndex=1])
	ex: recipeSlots("minecraft:wooden_shovel") - Returns: {["minecraft:oak_planks"]=1, ["minecraft:stick"]=2}]]

  sRecipe, nIndex = getParam("sn", {tRecipes.lastRecipe, 1}, sRecipe, nIndex)                       
  if type(sRecipe) == "number" then return false, "recipeSlots(sRecipe, nIndex) - Must supply recipe name." end
  if not tRecipes[sRecipe] then return false, "Recipe not found." end
  if not tRecipes[sRecipe][nIndex] then return false, "Recipe index doesn't exist." end

  local tRecipe = tRecipes[sRecipe][nIndex].recipe
    local tSlots = {}
  for i=1, #tRecipe do
    if not tSlots[tRecipe[i][1] ] then tSlots[tRecipe[i][1] ] = 1
    else tSlots[tRecipe[i][1] ] = tSlots[tRecipe[i][1] ] + 1
    end
  end
  return tSlots
end

function calcAverage(tSlots, tIng) --[[ Builds a table with item and average between items and slots.
  21/01/2022 v0.2.0 Param:  tSlots - table with item name and quantity of slots ocupied in the recipe.
                            tIng - table with item name and quantity in the inventory.
  Returns:  table with item and average between items and slots.
	sintax: calcAverage(tSlots, tIng)
	ex: calcAverage(tSlots, tIng)]]

  if not tSlots then return false, "calcAverage(tSlots, tIng) - Table of quantity of slots ocupied by recipe not supplied." end
  if not tIng then return false, "calcAverage(tSlots, tIng) - Table of items in the inventory not supplied." end

  local tMean = {}
  for k,v in pairs(tSlots) do
    for k1,v1 in pairs(tIng) do
      if k == k1 then
        if not tMean[k] then tMean[k] = v1/v end
      end
    end
  end
  return tMean
end

function arrangeRecipe(sRecipe, nIndex) --[[ Arranges items in inventory to craft a recipe.
  21/01/2022 v0.2.0 Param: sRecipe - recipe name.
                           nIndex - recipe index (tRecipes[recipeName][index])
  Returns:  true - if items from the recipe was arranged.
            false - if no recipe name was supplied and there isn't tRecipes.lastRecipe.
                  - if the recipe is not registered.
                  - if the recipe index doesn't exist.
                  - if some slot couldn't be cleared.
                  - if it couldn't leave the exact number of items in a slot.
                  - if it doesn't have enough items to craft recipe.
  sintax: arrangeRecipe([sRecipe=tRecipes.lastRecipe][, nIndex=1])
	ex: arrangeRecipe("minecraft:wooden_shovel") - Arranges items in inventory to craft a wooden shovel.]]

  sRecipe, nIndex = getParam("sn", {"", 1}, sRecipe, nIndex)              
  if sRecipe == "" then sRecipe = tRecipes.lastRecipe end
  if not sRecipe then return false, "arrangeRecipe(sRecipe, nIndex) - Must supply recipe name." end
  if not tRecipes[sRecipe] then return false, "Recipe name does not exist." end
  if not tRecipes[sRecipe][nIndex] then return false, "Recipe index doesn't exist." end

  if not haveItems(sRecipe, nIndex) then return false, "Don't have anough ingredients." end

  local tAverage = calcAverage(recipeSlots(sRecipe), getInvItems())
  local nRCol, nRLin = getFirstItemCoords(sRecipe, nIndex)
  local nSlot, nRSlot = 1, nRLin * 4 + nRCol + 1
  local tRecipe = tRecipes[sRecipe][nIndex].recipe
  local tTmpLeave = {}
  for iItems=1, #tRecipe do
    local sItem = tRecipe[iItems][1]
    if tRecipe[iItems].col then nRSlot = tRecipe[iItems].lin * 4 + tRecipe[iItems].col + 1 end
    while nSlot < nRSlot do
      if not clearSlot(nSlot, false) then
        return false, "Couldn't clear slot, "..tostring(nSlot)
      end
      nSlot = incSlot(nSlot, false)
    end
    nSlot = incSlot(nSlot, false)
    if not tTmpLeave[sItem] then tTmpLeave[sItem] = tAverage[sItem]
    else tTmpLeave[sItem] = tTmpLeave[sItem] + tAverage[sItem]
    end
    turtle.select(nRSlot)
    local nLeaveItem = math.floor(tTmpLeave[sItem])
    if not leaveItems(sItem, nLeaveItem, false) then
      return false, "Couldn't leave only "..tostring(nLeaveItem).." "..sItem.." items."
    end
    tTmpLeave[sItem] = tTmpLeave[sItem] - nLeaveItem
  end
  return true
end

function setCraftSlot(nSlot) --[[ Sets the craft resulting slot, in tRecipes CSlot
  03/11/2021 v0.2.0 Param: nSlot - number slot where the product of the recipe is put.
  Returns:  nil - if nSlot is not in range[1..16].
           true - if was set tRecipes["CSlot"].]]

  nSlot = nSlot or turtle.selectedSlot()
  if nSlot < 0 or nSlot > 16 then return nil, "setCraftSlot(nSlot) - nSlot out of range." end
  tRecipes["CSlot"] = nSlot
  return true
end

function flattenInventory() --[[ Averages all the item stacks in inventory.
  26/01/2022 v0.2.0 Returns:  true
  Sintax: flattenInventory()]]

  local tTotIng = getInvItems()
  local tTotSlots = countItemSlots()
  local tInv = getInventory() --get [slot][itemName]=Quantity
  local nMean

  function slotBelowMean(sItem, nMean)
    for i = 1, 16 do
      if tInv[i] and tInv[i][sItem] then
        if tInv[i][sItem] < nMean then return i, tInv[i][sItem] end
      end
    end
    return false
  end

  function slotAboveMean(sItem, nMean) 
    for i = 1, 16 do
      if tInv[i] and tInv[i][sItem] then
        if tInv[i][sItem] > nMean then return i, tInv[i][sItem] end
      end
    end
    return false
  end

  for k,v in pairs(tTotIng) do
    for k1,v1 in pairs(tTotSlots) do
      if k == k1 then
        nMean = math.floor(v / v1)
        local nDestSlot, nDestQuant = slotBelowMean(k, nMean )
        while nDestSlot do
          local nDestQuantNeeded = nMean - nDestQuant
          local nOrgSlot, nOrgQuant = slotAboveMean(k, nMean)
          while nOrgSlot do
            local nOrgTrans = nOrgQuant - nMean
            if nOrgTrans > nDestQuantNeeded then nOrgTrans = nDestQuantNeeded end
            turtle.select(nOrgSlot)
            turtle.transferTo(nDestSlot, nOrgTrans)
            tInv[nDestSlot][k] = nDestQuant + nOrgTrans
            tInv[nOrgSlot][k] = nOrgQuant - nOrgTrans
            if tInv[nDestSlot][k] >= nMean then break end
            nOrgSlot, nOrgQuant = slotAboveMean(k, nMean)
          end
          nDestSlot, nDestQuant = slotBelowMean(k, nMean )
        end
      end
    end
  end
  return true
end

function itemsBelong(sRecipe, nIndex) --[[ Checks if all the items in inventory belong to a recipe.
  26/01/2022 v0.2.0 Param:  sRecipe - string recipe name.
                            nIndex - index of tReecipes[sRecipe][nIndex].
  Returns:  false, table of items that dont belong to recipe {itemname=quantity,...}.
            nil - if sRecipe name is not supplied and tRecipes.lastRecipe is empty.
          false - if sRecipe is not in tRecipes or recipe index not found.
  Sintax: itemsBelong([sRecipe=tRecipes.lastRecipe])
  ex: itemsBelong("minecraft:wooden_shovel") - Returns false if there is items that don't belong to the recipe, otherwise returns true.]]

  sRecipe, nIndex = getParam("sn", {tRecipes.lastRecipe, -1}, sRecipe, nIndex)
  if not sRecipe then return nil, "itemsBelong([sRecipe=tRecipes.lastRecipe]) - Recipe name not supplied." end
  if not tRecipes[sRecipe] then return false, "Recipe not found." end
  if nIndex ~= -1 then
    if not tRecipes[sRecipe][nIndex] then return false, "Recipe index not found." end
  end

  local bOnly1, tmpIndex, tRecipe = true, nIndex
  local tItems, bExcess = {}, true
  for nSlot = 1, 16 do
    local tData = turtle.getItemDetail(nSlot)
    if tData then
      local bFound = false
      if nIndex == -1 then
        bOnly1 = false
        tmpIndex = 1
      end

      repeat
        tRecipe = tRecipes[sRecipe][tmpIndex].recipe
        for iRec = 1, #tRecipe do
          if tRecipe[iRec][1] == tData.name then
            bFound = true
            break
          end
        end
        tmpIndex = tmpIndex + 1
      until bOnly1 or tmpIndex > #tRecipes[sRecipe] or bFound

      if not bFound then
        if tItems[tData.name] then tItems[tData.name] = tItems[tData.name]+ tData.count
        else
          tItems[tData.name] = tData.count
          bExcess = false
        end
      end
    end
  end
  return bExcess, tItems
end

function getRecipeIndex(sRecipe, tRecipe) --[[ Returns a number (index) of the recipe in tRecipes.
  01/02/2022 v0.3.0 Param: sRecipe - string recipe name.
                           tRecipe - table with a recipe from inventory.
  Returns: number - index of the recipe in tRecipes.
  Sintax: getRecipeIndex([sRecipe=tRecipes.lastRecipe][, tRecipe=recipe in inventory])
  ex:getRecipeIndex()]]

  sRecipe, tRecipe = getParam("st", {tRecipes.lastRecipe,{}}, sRecipe, tRecipe)
  if not sRecipe then return false, "getRecipeIndex(sRecipe, tRecipe) - Recipe name not supplied."
  else
    if not tRecipes[sRecipe] then return false, "Recipe name not found."
    elseif #tRecipe == 0 then
      if not turtle.craft(0) then return 1
      else
        tRecipe = getInvRecipe()
        if not tRecipe then return false, "Couldn't create recipe from inventory" end
      end
    end
  end

  for iRecipes = 1, #tRecipes[sRecipe] do
    local tRecs = tRecipes[sRecipe][iRecipes].recipe
    local bFound = false
    if #tRecs == #tRecipe then
      for iItems = 1, #tRecipe do
        local bFoundItem = false
        for iRepItems = 1, #tRecs[iItems] do
          if tRecs[iItems][iRepItems] == tRecipe[iItems][1] then
            bFoundItem = true
            break
          end
        end
        if not bFoundItem then break end

        if tRecipe[iItems].col then
          if (tRecipe[iItems].col == tRecs[iItems].col) and
             (tRecipe[iItems].lin == tRecs[iItems].lin) then bFound = true
          else
              bFound = false
              break
          end
        else bFound = true
        end
      end
      if bFound then return iRecipes end
    end
  end
  return false
end

function colLinMatch(tRecs, tRec) --[[ Compares recipes items position, returns true if is the same.
  21/04/2022 v0.3.0 Param: tRecs - recipe from tRecipes.
                            tRec - recipe to compare.
  Returns: true - if items in recipes have the same position.
          false - if items in recipes have the diferent position or diferent number of items.
            nil - if invalid parameter type.
  Sintax: colLinMatch(tRecs, tRec)
  Note: get tRecs from getRecipe(), and tRec from getInvRecipe().
  ex:getRecipeIndex()]]

  if (type(tRecs) ~= "table") or (type(tRec) ~= "table") then
    return nil, "colLinMatch(tRecs, tRec) - tRecs and tRec must be tables."
  end
  if #tRecs.recipe ~= #tRec then return false end
  local bFound = true
  for iRecs = 1, #tRecs do
    if tRec[iRecs].col then
      if (tRec[iRecs].col ~= tRecs[iRecs].col) or (tRec[iRecs].lin ~= tRecs[iRecs].lin) then
        bFound = false
        break
      end
    end
  end
  return bFound
end

function getSecSumItems(nSlot, bWrap) --[[ Gets the sum of items in sequencial not empty slots.
  25/06/2022 v0.3.0 Param: nSlot - number first slot to sum.
                           bWrap - boolean if the sum wraps around the inventory.
  Returns: number the sum of items in sequencial slots.
  Sintax: getSecSumItems([nSlot=selected slot])
  Note: it stops if empty slot or end of inventory.
  ex: getSecSumItems(14) - sums the items in slot 14, 15 and 16 if not empty.) ]]
  
  nSlot, bWrap = getParam("nb", {turtle.getSelectedSlot(), true}, nSlot, bWrap)
  if type(nSlot) ~= "number" then return nil, "getSecSumItems(Slot) - Slot must be a number." end
  if nSlot < 1 or nSlot > 16 then return nil, "getSecSumItems(Slot) - Slot must be between 1 and 16." end

  local nSum, nStartSlot = 0, nSlot
  repeat
    local nCount = turtle.getItemCount(nSlot)
    if nCount == 0 then return nSum end
    nSum = nSum + nCount
    nSlot = incSlot(nSlot, bWrap)
  until (not nSlot) or (nSlot == nStartSlot)
  return nSum
end

function getProdQuant() --[[Gets quantity of products made with 1 recipe in inventory.
  31/03/2022 v0.3.0 Returns: number - quantity of products made with 1 inventory recipe.
              sintax: getProdQuant()
              Note: this function crafts the recipe in inventory.
              ex: getProdQuant()]]
  local nCount
  if not turtle.craft(0) then return false, "Inventory doesn't contain a recipe." end

  nCount = getMaxCraft()
  if nCount > invLowerStack() then flattenInventory() end

  if not tRecipes["CSlot"] then tRecipes["CSlot"] = CSLOT end
  turtle.select(tRecipes["CSlot"])

  turtle.craft(nCount)
  return getSecSumItems(tRecipes["CSlot"])/nCount
end

function addRecipe(sRecipe, tRecipe, nCount) --[[Returns index of recipe.
  31/03/2022 v0.3.0 Param:  sRecipe - name of recipe
                      tRecipe - recipe table, get if from getInvRecipe.
                      nCount - quantity of products made with this recipe.
              Returns:  number - index of recipe (tRecipes[sRecipe][index])
                        nil - if sRecipe not supplied and doesn't exits tRecipes.lastRecipe.
                            - if tRecipe is not supplied and there is no recipe in inventory.
              Syntax: addRecipe(sRecipe[, tRecipe=recipe in inventory][, nCount])
              Note: if no nCount is supplied this function crafts the recipe to obtain it.
              ex: addRecipe("minecraft:stick", getInvRecipe(), 4) - returns the index of the recipe stored in tRecipes["minecraft:stick"] ]]
  
  sRecipe, tRecipe, nCount = getParam("stn",{"", {}, -1}, sRecipe, tRecipe, nCount )

  if next(tRecipe) == nil then
    tRecipe = getInvRecipe()
    if not tRecipe then return nil, "addRecipe(sRecipe, tRecipe, nCount) - Recipe table not supplied." end
  end

  if (nCount == -1) or (not sRecipe) then
    nCount = getProdQuant()
    if not nCount then return nil, "addRecipe(sRecipe, tRecipe, nCount) - Recipe name not supplied." end
    sRecipe = getItemName()
  end

  if tRecipes[sRecipe] then --recipe exists
    nIndex = getRecipeIndex(sRecipe, tRecipe)
    if nIndex then
      tRecipes.lastRecipe = sRecipe
      tRecipes.lastIndex = nIndex
      return nIndex
    end
  else
    tRecipes[sRecipe] = {}
    tRecipes[sRecipe][1] = {}
    tRecipes[sRecipe][1].recipe = tRecipe
    tRecipes[sRecipe][1].count = nCount
    tRecipes.lastRecipe = sRecipe
    tRecipes.lastIndex = 1
    return 1
  end

  --recipe exists but items are not the same
  nIndex = #tRecipes[sRecipe]+1
  tRecipes[sRecipe][nIndex] = {}
  tRecipes[sRecipe][nIndex].recipe = tRecipe
  tRecipes[sRecipe][nIndex].count = nCount
  tRecipes.lastRecipe = sRecipe
  tRecipes.lastIndex = nIndex
  return nIndex
end

function craftRecipe(sRecipe, nLimit) --[[ Craft a recipe.
  26/01/2022 v0.3.0 Param: sRecipe - string recipe name.
                     nLimit - number recipes to craft.
  Returns: true, string product name, number index of recipe, number quantity crafted.
           true - if nLimit == 0 and could craft a recipe.
           nil - if nLimit out of range [0..64]
               - if no recipe name was supplied in the first recipe to craft.
           false - if inventory is empty.
                 - if there is no recipe in inventory and the recipe name wasn't found
                 - if there are missing items or this recipe was never craft.
                 - if it couldn't arrange items as a recipe in inventory.
                 - if there isn't a empty slot to craft the recipe to.
                 - if inventory has items that don't belong to the recipe.
                 - if when crafting the recipe the resulting items vanishes
  Sintax: craftRecipe(sRecipe=inventory recipe/tRecipes.lastRecipe[, nLimit=64])
  ex: craftRecipe() - craft the recipe in invenrtory.
      craftRecipe("minecraft:wooden_shovel", 1) - Craft one wooden shovel.]]
              
  if isInventoryEmpty() then return false, "Inventory is empty." end
  sRecipe, nLimit = getParam("sn", {"", DEFSTACK}, sRecipe, nLimit)
  if nLimit == 0 then return turtle.craft(nLimit) end
  if nLimit < 0 or nLimit > DEFSTACK then return nil, "craftRecipe(sRecipe, nLimit) - nLimit must be a number[1.."..tostring(DEFSTACK).."]." end

  local nIndex
  local isRecipeInv = turtle.craft(0)
  if sRecipe == "" then
    if isRecipeInv then return craftInv(nLimit)
    else
      sRecipe = tRecipes.lastRecipe
      nIndex = tRecipes.lastIndex
      if not sRecipe then return nil, "craftRecipe(sRecipe, nLimit) - Must supply recipe name." end
    end
  end
  
  if not tRecipes[sRecipe] then
    if isRecipeInv then return craftInv(nLimit)
    else return false, "There is no recipe in inventory and recipe name not found."
    end
  end

  local tRecipe = getInvRecipe()
  if not nIndex then
    if isRecipeInv then nIndex = getRecipeIndex(sRecipe, tRecipe) end
  end

  if not nIndex then
    local bSuccess
    bSuccess, nIndex = canCraftRecipe(sRecipe)
    if not bSuccess then return false, "There are missing items or this recipe was never crafted" end
    if not arrangeRecipe(sRecipe, nIndex) then return false, "Can't arrange items in inventory." end
    tRecipe = getInvRecipe()
  end

  if invLowerStack() < nLimit then flattenInventory() end

  if not tRecipes["CSlot"] then setCraftSlot(13) end
  if not isEmptySlot(tRecipes["CSlot"]) then
    local nSlot = getFreeSlot()
    if not nSlot then return false, "No empty slot to craft recipe to." end
    tRecipes["CSlot"] = nSlot
  end
  turtle.select(tRecipes["CSlot"])

  local tInv1 = getInventory()
  if not turtle.craft(nLimit) then
    local success, tItems = itemsBelong(sRecipe)
    if not success then return false, "Remove items that do not belong to the recipe." end
  end

	local tInv2 = getInventory()

  local bInc, tInc = cmpInvIncreased(tInv1, tInv2)
  if not bInc then return false, "i don't know where the product went." end

  local nSlot, _ = next(tInc, nil)
  local sRecipe = next(tInc[nSlot]) --get the product name.
  local nCount = getSecSumItems(tRecipes["CSlot"])
  nIndex = addRecipe(sRecipe, tRecipe, nCount )

  return true, sRecipe, nIndex, nCount
end

function cmpInvIncreased(tInv1, tInv2) --[[ Verifies if inventory quantities have increased.
  03/07/2022 v0.3.0 Param: tInv1, tInv2 - snapshot of inventory from getInventory()
  Returns: true, t - if items have increased, table with slot, name, quantity.
           false - if items haven't increased.
  Sintax: cmpInvIncreased(tInv1, tInv2)
  ex: cmpInvIncreased(inv1, inv2) - verifies if inventory snapshot inv2 has more items than inv1.]]
	local bDif, tInvCmpRes = cmpInventory(tInv1, tInv2)
	if bDif then return false end
	
	local tInc
	for kSlot, v in pairs(tInvCmpRes) do
    if tInvCmpRes[kSlot].count > 0 then
      if not tInc then tInc = {} end
      tInc[kSlot] = {["name"] = tInvCmpRes[kSlot].name, ["count"] = tInvCmpRes[kSlot].count}
    end
	end
	if tInc then return true, tInc
	else return false
	end
end

function cmpInventory(tInv1, tInv2) --[[ Compares 2 snapshots of inventory.
  11/05/2022 v0.3.0 Param: tInv1, tInv2 - snapshots from inventory (getInventory).
  Returns: nil - if tInv1 or tInv2 not supplied.
           true - if snapshots are equals.
           table - if snapshots are diferent.
  Sintax: cmpInventory(tInv1, tInv2)
  ex: cmpInventory(tInv1, tInv2) - compares tInv1 with tInv2.]]
	if (not tInv1) or (not tInv2) then return nil, "cmpInventory(tInv1, tInv2) - You must supply inventory1 and inventory2 to compare" end
	local tDif
	for iSlot = 1, 16 do
		if tInv1[iSlot] then
			for k, v in pairs(tInv1[iSlot]) do
				if tInv2[iSlot] and tInv2[iSlot][k] then
					if tInv2[iSlot][k] ~= tInv1[iSlot][k] then
						if not tDif then tDif = {} end	
						tDif[iSlot] = {["name"] = k, ["count"] = tInv2[iSlot][k] - tInv1[iSlot][k]}
					end
				else
					if not tDif then tDif = {} end	
					tDif[iSlot] = {["name"] = k, ["count"] = -tInv1[iSlot][k]}
				end
			end
		else
			if tInv2[iSlot] then
				for k, v in pairs(tInv2[iSlot]) do
					if not tDif then tDif = {} end	
					tDif[iSlot] = {["name"] = k, ["count"] = tInv2[iSlot][k]}
				end
      end
		end
	end
	if tDif then return false, tDif
	else return true
	end
end

function getLowestKey(t) --[[ Gets the lowest key of the table t.
  04/07/2022 v0.3.0 Param: t - table to look for the lowest key.
  Return: key type - the lowest key.
  Sintax: getLowestKey(t)
  Note: All the keys must have the same type.
  ex: getLowestKey({[1]="minecraft:cobblestone", [-1]="minecraft:stick"}) - returns -1.]]
  local Lower
  for k, v in pairs(t) do
    if not Lower then Lower = k
    else if k < Lower then Lower = k end
    end
  end
  return Lower
end

function craftInv(nLimit) --[[ Crafts the recipe in inventory.
  20/05/2022 v0.3.0 Param: nLimit - number products to craft.
  Returns: true, string product name, number index of recipe, number quantity crafted.
           nil - if nLimit is not a number.
               - if nLimit is out of range [1..64].
           false - if there is no recipe in inventory.
                 - if the turtle cant craft.
                 - if it craft something, but it didnt show up in inventory.
                 - if it couldn't add the recipe.
  Sintax: craftInv([nLimit=64])
  ex: craftInv(12) - craft 12 products of the recipe in inventory.]]
	nLimit = nLimit or DEFSTACK
	if type(nLimit) ~= "number" then return nil, "craft([Limit="..tostring(DEFSTACK).."]) - Limit must be a number." end
	if nLimit < 1 or nLimit > DEFSTACK then return nil, "craft([Limit="..tostring(DEFSTACK).."]) - Limit must be between 1 and "..tostring(DEFSTACK).."." end

	if not turtle.craft(0) then return false, "There is no recipe in inventory." end
  local nMaxCraft = getMaxCraft() 

	if not tRecipes["CSlot"] then tRecipes["CSlot"] = CSLOT end --set the default crafting slot.
	turtle.select(tRecipes["CSlot"])

	local tRecipe = getInvRecipe()
	local tInv1 = getInventory()
	if not turtle.craft(nLimit) then return false, "Could't craft "..nLimit.." products." end --craft

	local tInv2 = getInventory() --get second snapshot of inventory
	local bInc, tInc = cmpInvIncreased(tInv1, tInv2) --compares the 2 snapshots if there was a increase of items.
	if not bInc then return false, "I don't know where the products went." end --no

	local sRecipe = tInc[next(tInc)].name --get the product name.
  print(sRecipe)

  local nSumCount = 0
  for k, v in pairs(tInc) do
    nSumCount = nSumCount + tInc[k].count
  end
  local nCount = nSumCount/nMaxCraft --adjust count for 1 recipe

  local nIndex = addRecipe(sRecipe, tRecipe, nCount) --add the recipe to tRecipes.
  if not nIndex then return false, "Couldn't add recipe." end
  return true, sRecipe, nIndex, nCount
end

------ ROTATING FUNCTIONS ------  
function incFacing(nTurns) --[[ Increments tTurtle.facing by nTurns
  02/10/2021 v0.2.0 Param: nTurns - number of 90 degrees turns to the right.
  Returns: true
  ex: if turtle is facing "x+"=1
      incFacing(1) - Increments tTurtle.facing, turtle turns to "z+"=2
  Sintax: incFacing([nTurns=1])]]
  nTurns = nTurns or 1
  tTurtle.facing = tTurtle.facing + nTurns
  tTurtle.facing = bit32.band(tTurtle.facing, 3)
  return true
end

function decFacing(nTurns) --[[ Decrements tTurtle.facing by nTurns
  02/10/2021 v0.2.0 Param: nTurns - number of 90 degrees turns to the left.
  Returns: true
  Sintax: decFacing([nTurns=1])]]
  nTurns = nTurns or 1
  tTurtle.facing = tTurtle.facing - nTurns
  tTurtle.facing = bit32.band(tTurtle.facing, 3)
  return true
end

function turnBack() --[[ Turtle turns back.
  11/09/2021 v0.1.0 Returns:  true.
  Sintax: turnBack()
  ex: turnBack() - Turns the turtle back.]]
  turtle.turnRight()
  turtle.turnRight()
  incFacing(2)
  return true
end

function turnDir(sDir) --[[ Turtle turns to sDir direction.
  27/08/2021 v0.2.0 Param: sDir - string diretion "back"|"right"|"left".
  Returns:  true - if sDir is a valid direction.
            false - if sDir is not a valid direction.
  Sintax: turnDir([sDir="back"])
  ex: turnDir("back") or turnDir() - Turns the turtle back.]]
  sDir = sDir or "back"
  sDir = string.lower(sDir)
  
  if not dirType[sDir] then return nil, 'turn([sDir="back"]) - Invalid direction.' end
  if sDir == "back" then return turnBack()
  elseif sDir == "left" then
    decFacing()
    return turtle.turnLeft()
  elseif sDir == "right" then
    incFacing()
    return turtle.turnRight()
  end
  return true
end

function turnLeft(nTurns) --[[ Turns the turtle left nTurns * 90 degrees.
  22-07-2022 v0.4.0 Param: nTurns - number of 90 degrees turns to the left.
  Returns: true
           nil - if nTurns is not a number.
  Note: if nTurns < 0 it turns to the right.
  Sintax: turnLeft([nTurns=1])
  ex: turnLeft() - turns once to the left.
      turnLeft(-1) - turns once to the right.]]
  
  local i
  nTurns = nTurns or 1 --default 1 turn
  if type(nTurns) ~= "number" then return nil, "turnLeft(Turns) - Turns must be a number." end
  if nTurns < 0 then return turnRight(math.abs(nTurns)) end
  nTurns=bit32.band(nTurns, 3) --nTurns muest be 0..3 (4=0...)
  for i=1,nTurns do
    turtle.turnLeft()
    decFacing()
  end
  return true
end

function turnRight(nTurns) --[[ Turns the turtle right nTurns * 90 degrees.
  22-07-2022 v0.4.0 Param: nTurns - number of 90 degrees turns to the right.
  Returns: true
           nil - if nTurns is not a number.
  Note: if nTurns < 0 it turns to the left.
  Sintax: turnRight([nTurns=1])
  ex: turnRight() - turns once to the right.
      turnRight(-1) - turns once to the left.]]
  
  local i
  nTurns = nTurns or 1
  if type(nTurns) ~= "number" then return nil, "turnRight(Turns) - Turns must be a number." end
  if nTurns < 0 then return turnLeft(math.abs(nTurns)) end
  nTurns=bit32.band(nTurns, 3)
  for i=1,nTurns do
    turtle.turnRight()
    incFacing()
  end
  return true
end

function turnTo(nsFacing) --[[ Turtle turns to nsFacing.
  21-07-2022 v0.4.0 Param: nsFacing - "z-"|"x+"|"z+"|"x-"|"north"|"east"|"south"|"west"|0..3
  Returns: true - if it turn to specified direction
           nil - if nsFacing is not a string or number or invalid direction.
  sintax: turnTo(nsFacing)]]

  local nDir, nRotate;
	if not nsFacing then return true end --no parameters
  if type(nsFacing) == "number" then
    nsFacing = bit32.band(nsFacing, 3)
    nRotate = nsFacing - tTurtle.facing
  elseif type(nsFacing) == "string" then
    nsFacing = string.lower(nsFacing)
    if carDirType[nsFacing] then --is "north", "south", "west", "east"
      nRotate = carDirType[nsFacing] - tTurtle.facing
    elseif facingType[nsFacing] then --is "z+","z-","x+","x-"
      nRotate = facingType[nsFacing] - tTurtle.facing --{-3..3}
    else return nil, 'turnTo(Facing) - Invalid direction "z+"|"x+"|"z-"|"x-"|"north"|"south"|"west"|"east"|0..3';
    end
  else return nil, 'turnTo(Facing) - Invalid Facing type "z+"|"x+"|"z-"|"x-"|"north"|"south"|"west"|"east"|0..3';
  end

	if nRotate == 0 then return true end; --no need to rotate
	
  if nRotate < -2 then nRotate = 1 --3 lefts = 1 right
  else if nRotate > 2 then nRotate = -1 end --3 rights = 1 left
	end

	if nRotate < 0 then turnLeft(math.abs(nRotate))
	else turnRight(nRotate)
	end
	return true
end

------ MOVING AND ROTATING FUNCTIONS ------
function goBack(nBlocks) --[[ Turns back or not and advances nBlocks until blocked.
  27/08/2021 v0.1.0 Param: nBlocks - number of blocks to walk back.
  Returns:  true if turtle goes all way.
            false if blocked, or invalid parameter.
            nil - if nBlocks type is not a number.
  Note: nBlocks < 0 moves forward, nBlocks >= 0 turns back and advances nBlocks.
  ex: goBack(3) - Turns back and moves 3 blocks forward.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return nil, "goBack(Blocks) - Blocks must be anumber." end
  if nBlocks >= 0  then turnBack() end
  for i = 1, math.abs(nBlocks) do
    if not turtle.forward() then return false, "I can't go back."
    else tTurtle.x, tTurtle.y, tTurtle.z = addSteps()
    end
  end
  return true
end

function goDir(sDir, nBlocks) --[[ Turtle goes in sDir nBlocks until blocked.
  27/08/2021 v04.0 Param: sDir - string "forward"|"right"|"back"|"left"|"up"|"down"|"z+"|"x+"|"z-"|"x-"|"y+"|"y-"|"north"|"south"|"west"|"east"
                       nBlocks - number of blocks to walk.
  Returns:  true if turtle goes all way.
            false if blocked.
  Sintax: go([sDir="forward"], [nBlocks=1])
  ex: go("left", 3) or go(3, "left") - Rotates left and moves 3 Blocks forward.
      go() - Moves 1 block forward.
      go(-3, "up") - moves 3 blocks down.]]
  sDir, nBlocks = getParam("sn", {"forward", 1}, sDir, nBlocks)
  sDir = string.lower(sDir)
  
  if turnTo(sDir) then sDir = "forward" end
  if sDir == "forward" then return forward(nBlocks)
  elseif sDir == "right" then return goRight(nBlocks)
  elseif sDir == "back" then return goBack(nBlocks)
  elseif sDir == "left" then return goLeft(nBlocks)
  elseif sDir == "up" then return up(nBlocks)
  elseif sDir == "down" then return down(nBlocks)
  end
  return false
end

function goLeft(nBlocks) --[[ Turns left or  right and advances nBlocks until blocked.
  27/08/2021 v0.1.0 Param: nBlocks - number of blocks to walk left.
  Returns:  true if turtle goes all way.
            false if bllocked, or invalid parameter.
            nil - if nBlocks is not a number.
  Note: nBlocks < 0 goes right, nBlocks > 0 goes left, nBlocks = 0 turns left.
  ex: goLeft(3) - Moves 3 Blocks to the left.]]
  nBlocks = nBlocks or 1

  if type(nBlocks) ~= "number" then return nil, "goLeft(Blocks) - Blocks must be a number." end
  if nBlocks < 0 then turtle.turnRight()
  else  turtle.turnLeft()
  end
  decFacing(sign(nBlocks))

  for i = 1, math.abs(nBlocks) do
    if not turtle.forward() then return false, "Can't go any further."
    else tTurtle.x, tTurtle.y, tTurtle.z = addSteps()
    end
  end
  return true
end


function goRight(nBlocks) --[[ Turns right or left and advances nBlocks until blocked.
  27/08/2021 v0.1.0 Param: nBlocks - number of blocks to walk right.
  Returns:  true if turtle goes all way.
            false if bllocked, or invalid parameter.
            nil - if nBlocks is not a number.
  Note: nBlocks < 0 goes left, nBlocks > 0 goes right, nBlocks = 0 turns right.
  ex: goRight(3) - Moves 3 Blocks to the right.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return nil, "goRight(Blocks) - Blocks must be a number." end
  if nBlocks < 0 then turtle.turnLeft()
  else  turtle.turnRight()
  end
  incFacing(sign(nBlocks))

  for i= 1, math.abs(nBlocks) do
    if not turtle.forward() then return false, "There is a obstacle in my way."
    else tTurtle.x, tTurtle.y, tTurtle.z = addSteps()
    end
  end
  return true
end

function goTo(x, y, z) --[[ Goes to position x,y,z (no path finding).
  21-07-2022 v0.4.0 Param: x, y, z - numbers coords to go to.
  Returns: true - if it goes all the way.
           false - if it didn't go all the way.
  ex: goTo(10, 4, 5) - goes to coords 10, 4, 5.]]

  if checkNil(3, x, y, z) then return false, "goTo(x, y, z) - Must supply x, y, z" end
  if not isFuelEnoughTo(z,x,y) then return false,"goTo(x, y, z) - Not enough fuel." end --have fuel
  local dX, dY, dZ = distTo(x, y, z)
  if dX == 0 and dY == 0 and dZ == 0 then return true end
  
  repeat
    local bHasMoved=false
    if dZ>0 then
      if goDir("z+",dZ) then bHasMoved=true end
    end
    if dZ<0 then
      if goDir("z-",math.abs(dZ)) then bHasMoved=true end
    end

    if dX>0 then
      if goDir("x+",dX) then bHasMoved=true end
    end
    if dX<0 then
      if goDir("x-",math.abs(dX)) then  bHasMoved=true end
    end

    if dY>0 then
      if goDir("up", dY) then bHasMoved=true end
    end
    if dY<0 then
      if goDir("down", math.abs(dY)) then bHasMoved=true end
    end

    dX, dY, dZ = distTo(x,y, z)
  until (bHasMoved == false) or (dX == 0 and dY == 0 and dZ == 0)
  if (dX == 0) and (dY == 0) and (dZ == 0) then return true end
  return false
end

------ DIG FUNCTIONS ------  
--not tested
function digDir(sDir, nBlocks) --[[ Turtle digs in sDir direction nBlocks.
  08/09/2021 v0.4.0 Param: sDir - string direction to walk "forward"|"right"|"back"|"left"|"up"|"down"|"north"|"east"|"south"|"west".
                        nBlocks - number of blocks to walk in sDir direction. 
  Returns:  true if turtle digs all the way.
            false if blocked, empty space, can't turn that way.
            nil if invalid parameter
  Sintax: digDir([sDir="forward"][, nBlocks=1])
  ex: digDir("left", 3) or digDir(3, "left") - Rotates left and digs 3 Blocks forward.
      digDir() - Digs 1 block forward.
      digDir(-3, "up") - Digs 3 blocks down.]]

  sDir, nBlocks =getParam("sn", {"forward", 1}, sDir, nBlocks)
  negOrient = {["forward"] = "back", ["right"] = "left", ["back"] = "forward", ["left"] = "right", ["up"] = "down", ["down"] = "up"}
  sDir = string.lower(sDir)
  
  --if type(nBlocks) ~= "number" then return nil, 'digDir([Dir="foreward"][, Blocks=1]) - Blocks must be a number.' end
  if nBlocks < 0 then
    nBlocks = math.abs(nBlocks)
    sDir = negOrient[sDir]
  end

  local success, message = turnDir(sDir)

  if not success  then return false, message end
  if (sDir == "left") or (sDir == "right") or (sDir == "back") then sDir = "forward" end
  
  local facing = tTurtle.facing
  if (sDir == "up") or (sDir == "down") then tTurtle.facing = dirType[sDir] end

  for i = 1, nBlocks do
    if not digF[sDir]() then return false, "No block to dig." end
    if i ~= nBlocks then
			if not movF[sDir]() then
        tTurtle.facing = facing
        return false, "Can't move that way."
      else tTurtle.x, tTurtle.y, tTurtle.z = addSteps()
      end
		end
  end

  tTurtle.facing = facing
  return true
end

function dig(nBlocks) --[[ Turtle digs nBlocks forward or turns back and digs nBlocks, must have a tool equiped.
  27/08/2021 v0.1.0 Param: nBlocks - number of blocks to dig.
  Returns:  true if turtle digs all way.
            false if blocked, empty space, or invalid parameter.
  Sintax: dig([nBlocks=1])
  Note: nBlocks < 0 turns back and digs forward, nBlocks > 0 digs forward.
  ex: dig() or dig(1) - Dig 1 block forward.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false, "dig(Blocks) - Blocks must be a number." end
  if nBlocks < 0 then turnBack() end
  nBlocks = math.abs(nBlocks)

  for i = 1, nBlocks do
    if not turtle.dig() then return false, "No block to dig." end
    if i~= nBlocks then
			if not turtle.forward() then return false, "Can't advance more."
      else tTurtle.x, tTurtle.y, tTurtle.z = addSteps()
      end
		end
  end
  return true
end

function digLeft(nBlocks) --[[ Turtle digs nBlocks to the left or right, must have a tool equiped.
  27/08/2021 v0.1.0 Param: nBlocks - number of blocks to dig left.
  Returns:  true if turtle digs all way.
            false if blocked, empty space, or invalid parameter.
  Sintax: digLeft([nBlocks=1])
  Note: nBlocks < 0 digs to the right, nBlocks > 0 digs to the left
  ex: digLeft() or digLeft(1) - Dig 1 block left.]]
  nBlocks = nBlocks or 1
  
	if type(nBlocks) ~= "number" then return false, "digLeft(Blocks) - Blocks must be a number." end
  if nBlocks > -1 then turnDir("left")
  else turnDir("right")
  end
  return dig(math.abs(nBlocks))
end

function digRight(nBlocks) --[[ Turtle digs nBlocks to the right or left, must have a tool equiped.
  27/08/2021 v0.1.0 Param: nBlocks - number of blocks to dig right.
  Returns:  true if turtle digs all way.
            false if blocked, empty space, or invalid parameter.
  Sintax: digRight([nBlocks=1])
  Note: nBlocks < 0 digs to the left, nBlocks > 0 digs to the Right.
  ex: digRight() or digRight(1) - Dig 1 block right.]]
  nBlocks = nBlocks or 1
  
	if type(nBlocks) ~= "number" then return false, "digRight(Blocks) - Blocks must be a number." end
  if nBlocks > -1 then turnDir("right")
  else turnDir("left")
  end
  return dig(math.abs(nBlocks))
end

function digUp(nBlocks) --[[ Turtle digs nBlocks upwards or downwards, must have a tool equiped.
  27/08/2021 v0.1.0 Param: nBlocks - number of blocks to dig up.
  Returns:  true if turtle digs all way.
            false if blocked, empty space, or invalid parameter.
  Sintax: digUp([nBlocks=1])
  Note: nBlocks < 0 digs downwards, nBlocks > 0 digs upwards.
  ex: digUp() or digUp(1) - Dig 1 block up.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false, "digUp(Blocks) - Blocks must be anumber." end
  if nBlocks < 0 then return digDown(math.abs(nBlocks)) end

  for i = 1, nBlocks do
    if not turtle.digUp() then return false, "No block to dig." end
    if i ~= nBlocks then
			if not turtle.up() then return false, "Can't go up."
      else tTurtle.y = tTurtle.y + 1
      end
		end
  end
  return true
end

function digDown(nBlocks) --[[ Turtle digs nBlocks downwards or upwards, must have a tool equiped.
  27/08/2021 v0.1.0 Param: nBlocks - number of blocks to dig down.
  Returns:  true if turtle digs all way.
            false if bllocked, empty space, or invalid parameter.
  Sintax: digDown([nBlocks=1])
  Note: nBlocks < 0 digs upwards, nBlocks > 0 digs downwards.
  ex: digDown() or digDown(1) - Dig 1 block down.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false, "digDown(Blocks) - Blocks must be a number." end
  if nBlocks < 0 then return digUp(math.abs(nBlocks)) end

  for i = 1, nBlocks do
    if not turtle.digDown() then return false, "No block to dig." end
    if i ~= nBlocks then
			if not turtle.down() then return false, "Can't go down."
      else tTurtle.y = tTurtle.y - 1
      end
		end
  end
  return true
end

function digAbove(nBlocks) --[[ Digs nBlocks forwards or backwards, 1 block above the turtle, must have a tool equiped.
  27/08/2021 v0.1.0 Param: nBlocks - number of blocks to dig forward 1 block above turtle.
  Returns:  true if turtle digs all way.
            false if blocked, empty space, or invalid parameter.
  Sintax: digAbove([nBlocks=1])
  Note: nBlocks < 0 digs backwards, nBlocks > 0 digs forwards.
  ex: digAbove() or digAbove(1) - Dig 1 block up.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false, "digAbove(Blocks) - Blocks must be a number." end
  local dir = sign(nBlocks)

  for i = 1, math.abs(nBlocks) do
    if not turtle.digUp() then return false, "Can't dig up." end
    if i~= nBlocks then
			if not forward(dir) then return false end
		end
  end
  return true
end

function digBelow(nBlocks) --[[ Digs nBlocks forwards or backwards, 1 block below the turtle, must have a tool equiped.
  27/08/2021 v0.1.0 Param: nBlocks - number of blocks to dig forward and below turtle.
  Returns:  true if turtle digs all way.
            false if blocked, empty space, or invalid parameter.
  Sintax: digBelow([nBlocks=1])
  Note: nBlocks < 0 digs backwards, nBlocks > 0 digs forwards.
  ex: digBelow() or digBelow(1) - Dig 1 block down.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false, "digBelow(Blocks) - Blocks must be a number." end
  local dir = sign(nBlocks)
	
  for i = 1, math.abs(nBlocks) do
    if not turtle.digDown() then return false, "Can't dig down." end
    if i~= nBlocks then
			if not forward(dir) then return false, "Can't move forward" end
		end
  end
  return true
end

function digBack(nBlocks) --[[ Turns back or not and digs Blocks forward, must have a tool equiped.
  27/08/2021 v0.1.0 Param: nBlocks - number of blocks to dig.
  Returns:  true if turtle digs all way.
            false if bllocked, empty space, or invalid parameter.
  Sintax: digBack([nBlocks=1])
  Note: nBlocks < 0 digs forward, nBlocks > 0 digs backwards.
  ex: digBack() or digBack(1) - Turns back and dig 1 block forward.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false, "digBack(Blocks) - Blocks must be a number." end
  if nBlocks > 0 then turnBack() end
  for i = 1, math.abs(nBlocks) do
    if not turtle.dig() then return false, "Can't dig." end
    if i ~= nBlocks then
			if not forward() then return false, "Can't go forward." end
		end
  end
  return true
end


------ PLACE FUNCTIONS ------  
function placeDir(sDir) --[[ Places one selected block in sDir direction.
  27/08/2021 v0.1.0 Param: sDir - string direction "forward"|"right"|"back"|"left"|"up"|"down"
  Returns:  true if turtle places the selected block.
            false if turtle doesn't place the selected block, or invalid parameter.
  Sintax: placeDir([sDir="forward"])
  ex: placeDir("forward") or placeDir() - Places 1 block in front of the turtle.]]
  sDir = sDir or "forward"
  if type(sDir) ~= "string" then return false end
  sDir = string.lower(sDir)

  if sDir == "forward" then
    return turtle.place()
  elseif sDir == "right" then
    turnDir("right")
    return turtle.place()
  elseif sDir == "back" then
    turnBack()
    return turtle.place()
  elseif sDir == "left" then
    turnDir("left")
    return turtle.place()
  elseif sDir == "up" then
    return turtle.placeUp()
  elseif sDir == "down" then
    return turtle.placeDown()
  end
  return false
end

function place(nBlocks) --[[ Turtle places nBlocks in a strait line forward or backwards, and returns to starting point.
  27/08/2021 v0.1.0 Param: nBlocks - number of blocks to place.
  Returns:  number of blocks placed.
            false - invalid parameter.
  Sintax: place([nBlocks=1])
  Note: nBlocks < 0 places blocks backwards, nBlocks > 0 places blocks forwards.
  ex: place(1) or place() - Places 1 Block in front of turtle.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false, "place(Blocks) - Blocks must be a number." end
  if nBlocks < 0 then
    turnBack()
    nBlocks=math.abs(nBlocks)
  end

  for i = 2, nBlocks do
    if not forward() then
      nBlocks = i - 2
      back(sign(nBlocks))
      break
    end
  end

  local placed = 0
  for i = 1, nBlocks do
    if turtle.place() then placed = placed + 1 end
    if i ~= nBlocks then
      if not back() then return placed end
    end
  end
  return placed
end

function placeBack(nBlocks) --[[ Turtle turns back and places nBlocks in a strait line forward or backwards, and returns to starting point.
  27/08/2021 v0.3.0 Param: nBlocks - number of blocks to place.
  Returns:  number of blocks placed.
            nil - invalid parameter.
  Sintax: placeBack([nBlocks=1])
  Note: nBlocks < 0 places blocks backwards, nBlocks > 0 places blocks forwards.
  ex: place(1) or place() - Places 1 Block in front of turtle.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return nil, "placeBack(Blocks) - Blocks must be a number." end
  if nBlocks > 0 then
    turnBack()
    nBlocks=math.abs(nBlocks)
  end

  for i = 2, nBlocks do
    if not forward() then
      nBlocks = i - 2
      back(sign(nBlocks))
      break
    end
  end

  local placed = 0
  for i = 1, nBlocks do
    if turtle.place() then placed = placed + 1 end
    if i ~= nBlocks then
      if not back() then return placed end
    end
  end
  return placed
end

function placeUp(nBlocks) --[[ Places nBlocks upwards or downwards, and returns to starting point.
  27/08/2021 v0.1.0 Param: nBlocks - number of blocks to place.
  Returns:  number os blocks placed.
            false - if turtle was blocked on the way back.
                  - invalid parameter.
  Sintax: placeUp([nBlocks=1])
  Note: nBlocks < 0 places blocks downwards, nBlocks > 0 places blocks upwards.
  ex: placeUp(1) or placeUp() - Places 1 Block up.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false, "placeUp(Blocks) - Blocks must be a number." end
  if nBlocks < 0 then return placeDown(math.abs(nBlocks)) end
  for i = 2, nBlocks do
    if not up() then
      nBlocks = i - 2
      down(sign(nBlocks))
      break
    end
  end

  local placed = 0
  for i = 1, nBlocks do
    if turtle.placeUp() then placed = placed + 1 end
    if i ~= nBlocks then
      if not down() then return placed end
    end
  end
  return placed
end

function placeDown(nBlocks) --[[ Places nBlocks downwards or upwards, and returns to starting point.
  27/08/2021 v0.1.0 Param: nBlocks - number of blocks to place.
  Returns:  number of blocks placed.
            false - if turtle was blocked on the way back.
                  - invalid parameter.
  Sintax: placeDown([nBlocks=1])
  Note: nBlocks < 0 places blocks upwards, nBlocks > 0 places blocks downwards.
  ex: placeDown(1) or placeDown() - Places 1 Block Down.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false, "placeDown(Blocks) - Blocks must be a number." end
  if nBlocks < 0 then return placeUp(math.abs(nBlocks)) end
  for i = 2, nBlocks do
    if not down() then
      nBlocks = i - 2
      up(sign(nBlocks))
      break
    end
  end

  local placed = 0
  for i = 1, nBlocks do
    if turtle.placeDown() then placed = placed + 1 end
    if i ~= nBlocks then
      if not up() then return placed end
    end
  end
  return placed
end
  
function placeLeft(nBlocks) --[[ Places Blocks to the left or right, and returns to starting point.
  27/08/2021 v0.1.0 Param: nBlocks - number of blocks to place.
  Returns:  number of placed blocks.
            false - if turtle was blocked on the way back.
                  - invalid parameter.
                  - couldn't place block.
  Sintax: placeLeft([nBlocks=1])
  Note: nBlocks < 0 places blocks to the right, nBlocks > 0 places blocks to the left.
  ex: placeLeft(1) or placeLeft() - Places one Block to the left of the turtle.]]
  nBlocks = nBlocks or 1

  if type(nBlocks) ~= "number" then return false, "placeLeft(Blocks) - Blocks must be a number." end
  if nBlocks < 0 then turnDir("right")
	else turnDir("left")
	end
  return place(math.abs(nBlocks))
end
  
function placeRight(nBlocks) --[[ Places Blocks to the right or left, and returns to starting point.
  27/08/2021 v0.1.0 Param: nBlocks - number of blocks to place.
  Returns:  true if turtle places all blocks all the way.
            false - if turtle was blocked on the way back.
                  - invalid parameter.
                  - couldn't place block
  Sintax: placeRight([nBlocks=1])
  Note: nBlocks < 0 places blocks to the left, nBlocks > 0 places blocks to the right.
  ex: placeRight(1) or placeLeft() - Places 1 Block on the right of the turtle.]]
  nBlocks = nBlocks or 1

  if type(nBlocks) ~= "number" then return false, "placeRight(Blocks) - Blocks must be a number." end
  if nBlocks < 0 then turnDir("left")
	else turnDir("right")
	end
  return place(math.abs(nBlocks))
end
  
function placeAbove(nBlocks) --[[ Places nBlocks forwards or backwards in a strait line, 1 block above the turtle, and returns to starting point.
  27/08/2021 v0.1.0 Param: nBlocks - number of blocks to place.
  Returns:  number of blocks placed
            false - if turtle was blocked on the way back.
                  - couldn't place block.
                  - invalid parameter.
  Sintax: placeAbove([nBlocks=1])
  ex: placeAbove(1) or placeAbove() - Places one Block above turtle.]]
    nBlocks = nBlocks or 1
    
    if type(nBlocks) ~= "number" then return false, "placeAbove(Blocks) - Blocks must be a number." end
    if nBlocks < 0 then
      nBlocks=math.abs(nBlocks)
      turnBack()
    end
    for i = 2, nBlocks do --goto last pos to place
      if i == 2 then
        if not up() then
          nBlocks = 1
          break
        end
      elseif not forward() then
        nBlocks = i - 1
        break
      end
    end
    
    local placed = 0
    for i = 1, nBlocks do --place backwards
      if i == nBlocks then
        if i ~= 1 then
          if not down() then return false, "Can't move down." end
        end
        if turtle.placeUp() then placed = placed + 1 end
      else
        if turtle.place() then placed = placed + 1 end
        if (i ~= (nBlocks-1)) then
          if not back() then return placed end
        end
      end
    end
    return placed
end

function placeBelow(nBlocks) --[[ Places nBlocks forwards or backwards in a strait line, 1 block below the turtle, and returns to starting point.
  27/08/2021 v0.1.0 Param: nBlocks - number of blocks to place.
  Returns:  number of placed blocks.
            false - if turtle was blocked on the way back.
                  - couldn't place block.
                  - invalid parameter.
  Sintax: placeBelow([Blocks=1])
  ex: placeBelow(1) or placeBelow() - Places one Block below turtle.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false, "placeBelow(Blocks) - Blocks must be a number." end
  if nBlocks < 0 then
    nBlocks=math.abs(nBlocks)
    turnBack()
  end
  for i = 2, nBlocks do
    if i == 2 then
      if not down() then
        nBlocks = 1
        break
      end
    elseif not forward() then
      nBlocks = i - 1
      break
    end
  end
  
  local placed = 0
  for i = 1, nBlocks do
    if i == nBlocks then
      if i ~= 1 then
        if not up() then return false, "Can't go up." end
      end
      if turtle.placeDown() then placed = placed + 1 end
    else
      if turtle.place() then placed = placed + 1 end
      if (i ~= (nBlocks-1)) then
        if not back() then return placed end
      end
    end
  end
  return placed
end


------ INVENTORY FUNCTIONS ------
function countItemSlots() --[[ Counts how many slots is ocupied with each item.
  04/12/2021 v0.2.0 Returns: table[itemName]=Slots ocupied by item.
  Sintax: countItemSlots()]]
  local tItemSlots = {}
  for iSlot = 1, 16 do
    local tData = turtle.getItemDetail(iSlot)
    if tData then
      if tItemSlots[tData.name] then tItemSlots[tData.name] = tItemSlots[tData.name] + 1
      else tItemSlots[tData.name] = 1
      end
    end
  end
  return tItemSlots
end

function decSlot(nSlot, bWrap) --[[ Decreases nSlot in range [1..16].
  02/11/2021 v0.2.0 Param: nSlot - number slot to decrease.
                           bWrap - boolean if slot wraps around inventory.
  Returns:  the number of slot decreased by 1.
            nil - if nSlot if not a number.
            false - if bWrap and nSlot = 1.
  Sintax: decSlot([nSlot = turtle.getSelectedSlot()][, bWrap = true])
  ex: decSlot() - Decrements the selected slot.
      decSlot(1, false) - Returns false.
      decSlot(16, false) - Returns 15]]
  nSlot, bWrap = getParam("nb", {turtle.getSelectedSlot(), true}, nSlot, bWrap)
  if type(nSlot) ~= "number" then return nil, "decSlot([Slot=selected slot][, Wrap=true]) - Slot must be a number." end
	nSlot = nSlot - 1
  if not bWrap and nSlot < 1 then return false end
  return nSlot == 0 and 16 or nSlot
end

function freeCount() --[[ Get number of free slots in turtle's inventory.
  07/10/2021 v0.2.0 Returns:  number of free slots.
  Sintax: freeCount()]]
  local nFree,i=0
  for i = 1, 16 do
    if turtle.getItemCount(i)==0 then nFree=nFree+1 end
  end	
  return nFree
end

function getFreeSlot(nStartSlot, bWrap) --[[ Get the first free slot, wrapig the search or not.
  07/10/2021 v0.2.0 Param:  nStartSlot - number slot where to start the search.
                            bWrap - boolean if the search wraps around the inventory.
  Returns:  number - first free slot number.
            false - if no free slot.
  Sintax: getFreeSlot([nStartSlot=1][, bWrap=true])
  Note: if nStartSlot<0 search backwards--]]
	nStartSlot, bWrap = getParam("nb",{1, true}, nStartSlot, bWrap)

  if not type(nStartSlot) == "number" then return false, "getFreeSlot([StartSlot=1][, Wrap=true]) - Slot must be a number." end
  local dir = sign(nStartSlot)
  nStartSlot = math.abs(nStartSlot)
  local nEndSlot = nStartSlot
  
  repeat
    local tData = turtle.getItemDetail(nStartSlot)
    if not tData then return nStartSlot end
    nStartSlot = nStartSlot + dir
    if not bWrap then
      if dir == 1 then
        if nStartSlot == 17 then break end
      else
        if nStartSlot == 0 then break end
      end
    end
    nStartSlot = bit32.band(nStartSlot-1, 15)+1
  until (nEndSlot == nStartSlot)
  return false
end

function getInventory() --[[ Builds a table with the slot, the name and quantity of items in inventory.
  04/12/2021 v0.2.0 Returns:  table[slot][itemName]=Quantity.
  Sintax: getInventory()]]
  local tInv = {}
  for iSlot = 1, 16 do
    local tData = turtle.getItemDetail(iSlot)
    if tData then
      tInv[iSlot] = {}
      tInv[iSlot][tData.name] = tData.count
    end
  end
  return tInv
end

function groupItems() --[[ Groups the same type of items in one slot in inventory.
  07/10/2021 v0.2.0 Returns:  true.
  Sintax: groupItems()]]
  local destSlot,orgSlot,tmpSlot
 
  for destSlot=1,15 do --destination slot
    if turtle.getItemCount(destSlot) ~=0 then --has some items?
      for orgSlot=destSlot+1,16 do --origin slot
        if turtle.getItemCount(orgSlot) ~= 0 then --has some items
          turtle.select(orgSlot) --select the origin slot
          if turtle.compareTo(destSlot) then --is the same family entity
            turtle.transferTo(destSlot) --transfer to destination slot if possible, doesn't matter if not
          end
        end
      end
    end
  end
	return true
end

function incSlot(nSlot, bWrap) --[[ Increases nSlot in range [1..16].
  02/11/2021 v0.2.0 Param: nSlot - number slot to be increased.
                           bWrap - boolean true if the slot number wraps around inventory.
  Returns:  the number of slot increased by 1.
            false - if it couldn't increase slot.
  Sintax: incSlot([Slot.selecetd slot][, Wrap=true])
  ex: incSlot(16) - returns 1.]]
  nSlot, bWrap = getParam("nb", {turtle.getSelectedSlot(), true}, nSlot, bWrap)
  if type(nSlot) ~= "number" then return nil, "incSlot([Slot.selecetd slot][, Wrap=true]) - Slot must be a number." end
  nSlot = nSlot + 1
  if not bWrap and (nSlot > 16) then return false end
  return bit.band(nSlot-1, 15) + 1
end

function itemSpace(nSlot) --[[ Get how many items more you can store in inventory.
  23/09/2021 v0.1.0 Param: nSlot/sItemName - number of slot/string item name.
  Returns: number of items you can store more in inventory/slot.
           false - if item is not in inventory.
                 - 1 - if slot is empty.
  Sintax: itemSpace([nSlot/item name=turtle.getSelectedSlot()])
  ex: itemSpace() gets how many items you can store, like the item in selected slot.
      itemSpace("minecraft:cobblestone") - gets how more cobblestone you can store.
      itemSpace(12) - gets how more items, like item in slot 12, you can store.]]
	nSlot = nSlot or turtle.getSelectedSlot() --default slot is the selected slot
	local stack = 0
	
	if type(nSlot) == "string" then --is it  "minecraft:cobblestone" for example.
		nSlot = search(nSlot)
		if not nSlot then return false, "Item not found." end
	end
	
	local tData = turtle.getItemDetail(nSlot)
	if not tData then return -1 end
  local itemName = tData.name
	stack = turtle.getItemSpace(nSlot) + tData.count
	
	nSlot = bit.band(nSlot-1, 15)+1 --nSlot, the start slot [1..16]
	totSpace = 0
	
	for i = 1, 16 do
		tData = turtle.getItemDetail(i)
		if tData then
      if tData.name == itemName then totSpace = totSpace + stack - tData.count end
		else totSpace = totSpace + stack
		end
	end
	
	return totSpace
end

function isEmptySlot(nSlot) --[[ Checks if nSlot is empty.
  23/09/2021 v0.2.0 Param: nSlot - number slot to check.
  Returns: true - if nSlot is empty.
           false - if nSlot is not empty.
  Sintax: isEmpty([nSlot=selected slot])
  ex: isEmpty() - Checks if selected slot is empty.
      isEmpty(12) - checks if slot 12 is empty.]]
  nSlot = nSlot or turtle.getSelectedSlot()
  if type(nSlot) ~= "number" then return nil, "isEmptySlot(Slot) - Slot is not a number." end
  return turtle.getItemDetail(nSlot) == nil
end

function isInventoryEmpty() --[[ Checks if inventory is empty.
  30/04/2022 v0.1.0 Returns: true - if inventory is empty.
                             false - if inventory is not empty.
  Sintax: isInventoryEmpty()
  ex: isInventoryEmpty() - Checks if inventory is empty.]]
  for nSlot = 1, 16 do
    if turtle.getItemDetail(nSlot) then return false end
  end
  return true
end

function itemCount(nSlot) --[[ Counts items in inventory
  31/08/2021  Param: nSlot/"inventory"/item name - number slot/string "inventory"/string item name.
              Returns: number of items counted.
                      nil - if nSlot <0 or > 16.
                          - if nSlot is neither a string nor a number.
              sintax: itemCount([nSlot=turtle.getSelectedSlot() / "inventory" / item name])
              ex: itemCount() counts items in selected slot.
                  itemCount("inventory") - counts items in inventory.
                  itemCount("minecraft:cobblestone") - counts cobblestone in inventory.]]
  nSlot = nSlot or turtle.getSelectedSlot()
  totItems = 0

  if type(nSlot) == "number" then
    if (nSlot < 1) or (nSlot > 16) then return nil, 'itemCount(nSlot/itemName/"inventory") - Slot must be a number [1..16].' end
    tData = turtle.getItemDetail(nSlot)
    if tData then totItems = tData.count end
  else
    if type(nSlot) ~= "string" then return nil, 'itemCount(nSlot/itemName/"inventory") - Invalid parameter type [number|string].' end
    for i = 1, 16 do
      tData = turtle.getItemDetail(i)
      if tData then
        if nSlot == "inventory" then totItems = totItems + tData.count
        elseif nSlot == tData.name then totItems = totItems + tData.count
        end
      end
    end
  end
  return totItems
end

function getItemName(nSlot) --[[ Gets the item name from Slot/selected slot.
  05/09/2021 v0.3.0 Param: nSlot - number slot where to get the item name.
              Returns: item name - if slot is not empty.
                        false - if slot is empty.
              Sintax: getItemName([nSlot=selected slot])
              ex: getItemName() - retuns the name of item in selected slot.]]
  nSlot = nSlot or turtle.getSelectedSlot()

  if type(nSlot) ~= "number" then return nil, "getItemName([Slot=selected slot]) - Slot must be a number." end
  if (nSlot <1 ) or (nSlot > 16) then return false, "Slot "..nSlot.." out of range." end

  local tData = turtle.getItemDetail(nSlot)
  if not tData then return false end
  return tData.name
end

function itemSelect(itemName) --[[ Selects slot [1..16] or first item with Item Name, or the turtle selected slot.
  29/08/2021 v0.1.0 Param: slot/itemName - number slot/string name of the item to select.
  Returns:  number, number - The selected slot, and number of items in that slot.
            False - if it didn't find the item name.
            nil - if type of itemName/Slot is not a number or string.
                - if itemName/Slot is a number out of range [1..16].
  Note: if executed select() is the same as turtle.getSelectedSlot()
  Sintax: select([Slot/Item Name])
  ex: select("minecraft:cobblestone") - Selects first slot with "minecraft:cobblestone"]]
  local nSlot
  local tData

  if not itemName then
    nSlot = turtle.getSelectedSlot()
  elseif type(itemName) == "number" then
    if (itemName < 1) or (itemName > 16) then return nil, "itemSelect([itemName/slot]=selected slot) - Slot must be number 1..16." end
    nSlot = itemName
  elseif type(itemName) == "string" then
      nSlot = search(itemName)
      if not nSlot then return false, "Item name not found." end
  else
    return nil, "itemSelect([itemName/slot]=selected slot) - Slot/itemName must be a number 1..16 or a string (item name)."
  end
  
  tData = turtle.getItemDetail(nSlot)
  if tData then return nSlot, tData.count
  else return nSlot, 0
  end
end

function search(sItemName, nStartSlot, bWrap) --[[ Search inventory for ItemName, starting at startSlot, and if search wrap. 
  28/08/2021 v0.1.0 Param: sItemName - string the item name.
                           nStartSlot - number slot where to start the search.
                           bWrap - boolean true if the search wraps around inventory.
  Returns:  number, number - first slot where the item was found, and the quantity.
            nil - if sItemName not supplied.
                - if nStartSlot is not a number.
            False - if the item was not found
  Note: nStartSlot < 0 search backwards, nStartSlot > 0 searchs forward.
        if not supplied nStartSlot, default is the selected slot.
        if not supplied bWrap, it defaults to true.
  Sintax: Search(sItemName [, nStartSlot=turtle.getSelectedSlot()][, bWrap=true]) ]]
	sItemName, nStartSlot , bWrap= getParam("snb", {"", turtle.getSelectedSlot(), true}, sItemName, nStartSlot, bWrap)
  if sItemName == "" then return nil, "search(sItemName, nStartSlot, bWrap) - Item name must be supplied." end
  if type(nStartSlot) ~= "number" then return nil, "search(sItemName, nStartSlot, bWrap) - Start slot must be a number." end
  dir = sign(nStartSlot)
  nStartSlot = math.abs(nStartSlot) - 1
  nStartSlot = bit32.band(nStartSlot, 15)
	slot = nStartSlot
	
	repeat
    tData = turtle.getItemDetail(slot + 1)

    if tData then
      if tData.name == sItemName then
        return slot + 1, tData.count
      end
    end
    slot = slot + dir
    if not bWrap then
      if dir == -1 then
        if slot == -1 then break end
      else
        if slot == 16 then break end
      end
    end
    slot = bit32.band(slot, 15)
  until (slot == nStartSlot)
  return false
end

function selectFreeSlot(nStartSlot, bWrap) --[[ Selects the first free slot starting at nStartSlot, and if the search wraps or not.
  07/10/2021 v0.2.0 Param: nStartSlot - number slot where to start search for free slot.
                           bWrap - boolean true if the search wraps around inventory.
  Returns:  free slot number.
            false - if no free slot.
  Sintax: selectFreeSlot([StartSlot=1][, Wrap=true])
  ex: selectFreeSlot(16, false) - Selects slot 16 if it is empty.
      selectFreeSlot(15, true) - Checks all slots starting at 15, and selects first empty.]]
  local nSlot

  nSlot=getFreeSlot(nStartSlot, bWrap) --get a free slot
  if not nSlot then return false end --not found
  if turtle.select(nSlot) then return nSlot end
  return false --couldn't select nSlot
end

------ SUCK FUNCTIONS ------
function suckDir(sDir, nItems) --[[ Sucks or drops nItems into sDir direction.
  05/09/2021 v0.1.0 Param:  sDir - "forward"|"right"|"back"|"left"|"up"|"down"
                            nItems - number of items to suck.
  Returns:  true - if turtle collects some items.
            false - if there are no items to take.
  Sintax: suckDir([sDir="forward][,nItems=all the items])
  Note: if nItems < 0 it drops nItems from selected slot.
  ex: suckDir() - Turtle sucks all the items forward.]]
  sDir, nItems = getParam("sn", {"forward"}, sDir, nItems)
  sDir = string.lower(sDir)

  if nItems and nItems < 0 then return dropDir(sDir, math.abs(nItems)) end
  if type(sDir) ~= "string" then return nil, "suckDir(sDir, nItems) - sDir must be a string." end

  if sDir == "right" then
    turnDir("right")
    sDir = "forward"
  elseif sDir == "back" then
    turnBack()
    sDir = "forward"
  elseif sDir == "left" then
    turnDir("left")
    sDir = "forward"
  end
  
  if not suckF[sDir] then return false, "Invalid direction." end
  return suckF[sDir](nItems)
end


------ FILE SYSTEM FUNCTIONS ------
function fsGetFreeSpace() --[[ Gets the total free space on disk.
  02/10/2021 v0.2.0 Returns:  Free space on disk.
  ex: fsGetFreeSpace() - Outputs free space on disk.]]
	return fs.getFreeSpace("/")
end


------ DROP FUNCTIONS ------  
function dropDir(sDir, nBlocks) --[[ Drops or sucks nBlocks from selected slot and inventory into the world in front, up or down the turtle.
  29/08/2021 v0.1.0 Param:  sDir - "forward"|"right"|"back"|"left"|"up"|"down"
                            nBlocks - number of blocks to drop/suck
  Returns:  number of dropped items.
            true - if suck some items.
            false - empty selected slot.
            nil - if invalid direction.
  Sintax: drop([sDir="forward"] [, nBlocks=stack of items])
  Note: if nBlocks not supplied, drops all items in selected slot.
        if nBlocks < 0 sucks nBlocks.
  ex: dropDir() - Drops all blocks from selected slot, forward.
      dropDir(205, "up") - Drops 205 blocks from inventory like the one on selected slot, upwards.
      dropDir(-5, "down") - Suck 5 items from down.]]

  sDir, nBlocks = getParam("sn", {"forward"}, sDir, nBlocks) --sDir as direction, nBlocks as a number.
  sDir = string.lower(sDir)
  if not dirType[sDir] then return nil, "Invalid direction." end --invalid direction
  selectedSlot = turtle.getSelectedSlot() --save selected slot
  tData = turtle.getItemDetail() --check the selected slot for items
  
  if not lookingType[sDir] then
    turnDir(sDir) --turn if it must
    sDir = "forward"
  end

  if not nBlocks then --drop all the stack from selected slot
    if tData then --is there a item to frop?
      dropF[sDir]()
      return tData.count
    else return false
    end
	else if type(nBlocks) ~= "number" then return nil end
  end

  if (not tData) and (nBlocks > -1) then return false, "Empty selected slot." end --no items                

  if nBlocks < 0 then return suckDir(sDir, math.abs(nBlocks)) end
  nBlocks = math.abs(nBlocks) --nBlocks must be a positive number
	local blocksDropped = 0 --total blocks dropped

	while (blocksDropped < nBlocks) do
    if tData.count > (nBlocks-blocksDropped) then
      dropF[sDir](nBlocks-blocksDropped)
      blocksDropped = blocksDropped + (nBlocks-blocksDropped)
    else
      dropF[sDir]()
      blocksDropped = blocksDropped + tData.count
      nextSlot, tData.count = search(tData.name)
      if nextSlot then turtle.select(nextSlot)
      elseif blocksDropped < nBlocks then break
      end
    end
  end
  turtle.select(selectedSlot) --restore selected slot
  return blocksDropped
end

function drop(nBlocks) --[[ Drops or sucks nBlocks in front of the turtle.
  29/08/2021 v0.1.0 Param: nBlocks - number of blocks to drop forward.
  Returns:  number of dropped items.
            false - empty selected slot.
            true - if suck some items.
  Sintax: drop([nBlocks])
  Note: if nBlocks not supplied, drops all items from selected slot.
  ex: drop() - Drops all blocks from selected slot, in front of the turtle.
      drop(205) - Drops 205 blocks from inventory like the one on selected slot, forward.]]
  return dropDir("forward", nBlocks)
end

function dropUp(nBlocks) --[[ Drops or sucks nBlocks upwards.
  29/08/2021 v0.1.0 Param: nBlocks - number of blocks to drop up.
  Returns:  number of dropped items.
            false - empty selected slot.
            true - if suck some items.
  Sintax: dropUp([nBlocks])
  Note: if nBlocks not supplied, drops all items from selected slot.
  ex: dropUp() - Drops all blocks from selected slot, upwards.
      dropUp(205) - Drops 205 blocks from inventory like the one on selected slot, upwards.]]
  return dropDir("up", nBlocks)
end

function dropDown(nBlocks) --[[ Drops or sucks nBlocks downwards.
  29/08/2021 v0.1.0 Param: nBlocks - number of blocks to drop down.
  Returns:  number of dropped items.
            false - empty selected slot.
            true - if suck some items.          
  Sintax: dropDown([nBlocks])
  Note: if nBlocks not supplied, drops all items from selected slot.
  ex: dropDown() - Drops all blocks from selected slot, downwards.
  dropDown(205) - Drops 205 blocks from inventory like the one on selected slot, downwards.]]
  return dropDir("down", nBlocks)
end

function dropLeft(nBlocks) --[[ Rotate left and drops or sucks nBlocks forward.
  11/09/2021 v0.1.0 Param: nBlocks - number of blocks to drop left.
  Returns:  number of dropped items.
            false - empty selected slot.
            true - if suck some items.
  Sintax: dropLeft([nBlocks])
  Note: if nBlocks not supplied, drops all items from selected slot.
  ex: dropLeft() - Rotate left and drops all blocks from selected slot forward.
  dropLeft(205) - Rotate left and drops 205 blocks from inventory like the one on selected slot, forward.]]
  return dropDir("left", nBlocks)
end

function dropRight(nBlocks) --[[ Rotate right and drops or sucks nBlocks forward.
  11/09/2021 v0.1.0 Param: nBlocks - number of blocks to drop right.
  Returns:  number of dropped items.
            false - empty selected slot.
            true - if suck some items.
  Sintax: dropRight([nBlocks])
  Note: if nBlocks not supplied, drops all items from selected slot.
  ex: dropRight() - Rotate right and drops all blocks from selected slot, forward.
  dropRight(205) - Rotate right and drops 205 blocks from inventory like the one on selected slot, forward.]]
  return dropDir("right", nBlocks)
end

function dropBack(nBlocks) --[[ Rotate back and drops or sucks nBlocks forward.
  29/08/2021 v0.1.0 Param: nBlocks - number of blocks to drop back.
  Returns:  number of dropped items.
            false - empty selected slot.
            true - if suck some items.
  Sintax: dropBack([nBlocks])
  Note: if nBlocks not supplied, drops all items from selected slot.
  ex: dropBack() - Rotate back and drops all blocks from selected slot, forward.
      dropBack(205) - Rotate back and drops 205 blocks from inventory like the one on selected slot, forward.]]
  return dropDir("back", nBlocks)
end


---- TEST AREA ------


INIT()


TERMINATE()
