digF = {["up"] = turtle.digUp, ["forward"] = turtle.dig, ["down"] = turtle.digDown} --original dig functions
movF = {["up"] = turtle.up, ["forward"] = turtle.forward, ["down"] = turtle.down} --original move functions
insF = {["up"] = turtle.inspectUp, ["down"] = turtle.inspectDown, ["forward"] = turtle.inspect} --original inspect functions
dropF = { ["up"] = turtle.dropUp, ["forward"] = turtle.drop, ["down"] = turtle.dropDown } --original drop functions
suckF = {["forward"] = turtle.suck, ["up"] = turtle.suckUp, ["down"] = turtle.suckDown} --original suck functions.

dirType = { ["forward"]=1, ["right"]=2, ["back"]=4, ["left"]=8, ["up"]=16, ["down"]=32 } --moving direction options
lookingType = { ["up"] = 16, ["forward"] = 1, ["down"] = 32} --where is the turtle looking, it can't look to the sides or back.
tTurtle = { ["x"] = 0, ["y"] = 0, ["z"] = 0, --coords for turtle
						leftHand = "empty",
						rightHand = "empty",
} 

------ FUEL ------
--refuel([item Name/Slot=selected slot][, count=stack]) refuel the turtle with item name, item in slot, or item in selected slot.
function refuel(itemName, count)
	
end

------ EQUIP ------
--equip([sHand=empty][, item Name]) equip tool to left or right hand, from inventory or selected slot, with item Name.
function equip(sHand, itemName)

end


------ TURTLE STATUS FUNCTIONS ----

function setCoords(x, y, z) --[[ Set coords x, y, z for turtle.
  03/09/2021  Returns:  true.
              ex: setCoords(10, 23, 45) - Sets coords x to 10, y to 23 and z to 45.]] 
	tTurtle.x, tTurtle.y, tTurtle.z = x, y, z
  return true
end

function getCoords() --[[ Gets coords from turtle.
  03/09/2021  Returns: the turtle coords x, y, z.
              ex: getCoords() - Returns coords of turtle, 3 values, x, y, z.]] 
	return tTurtle.x, tTurtle.y, tTurtle.z
end


------ ATTACK FUCTIONS ------

function attackDir(sDir) --[[ Turtle attack in sDir direction {"forward", "right", "back", "left", "up", "down"}.
  05/09/2021  Returns:  true if turtle attack something.
                        false if there is nothing to attack, or no weapon.
                        nil if invalid parameter.
              sintax: attackDir([sDir="forward"]) - sDir {"forward", "right", "back", "left", "up", "down"}
              ex: attackDir("left") - Rotates left and attacks. ]]
  sDir = sDir or "forward"

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
  return nil
end


------ MEASUREMENTS FUNCTIONS ------

function distTo(x, y, z) --[[ Gets the three components of the distance from the turtle to point.
  03/09/2021  Returns:  the distance vector3 from turtle to coords x, y, z.
              Note: returns a negative value if turtle is further away than the point x, y, z.
              ex: distTo(1, 10, 34) - Returns 3 values.]] 
	return x-tTurtle.x, y-tTurtle.y, z-tTurtle.z
end


------ COMPARE FUNCTIONS ------

function compareAbove(nBlocks) --[[ Compares nBlocks above the turtle in a strait line with selected slot block.
  04/09/2021  Returns:  true - if all the blocks are the same.
                        false - if blocked, empty space, or found a diferent block.
												nil if invalid parameter.
              sintax: compareAbove([nBlocks=1])
              Note: nBlocks < 0 turn back and compares forward, nBlocks > 0 compares forwards.
              ex: compareAbove() or compareAbove(1) - Compares 1 block up.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return nil end  --nBlocks must be a number.
  local dir = sign(nBlocks)
  if nBlocks < 0 then turnBack() end
  nBlocks = math.abs(nBlocks)

  for i = 1, nBlocks do
    if not turtle.compareUp() then return false end
    if nBlocks ~= i then
			if not forward() then return false end
		end
  end
  return true
end

function compareBelow(nBlocks) --[[ Compares nBlocks below the turtle in a strait line with selected slot block.
  04/09/2021  Returns:  true - if all the blocks are the same.
                        false - if blocked, empty space, or found a diferent block.
												nil if invalid parameter.
              sintax: compareBelow([nBlocks=1])
              Note: nBlocks < 0 turn back and compares forward, nBlocks > 0 compares forwards.
              ex: compareBelow() or compareBelow(1) - Compares 1 block down.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return nil end
  local dir = sign(nBlocks)
  if nBlocks < 0 then turnBack() end
  nBlocks = math.abs(nBlocks)

  for i = 1, nBlocks do
    if not turtle.compareDown() then return false end
    if nBlocks ~= i then
			if not forward() then return false end
		end
  end
  return true
end


------ DETECT FUNCTIONS ------

function detectDir(sDir) --[[ Detects if is a block in sDir direction {"forward", "right", "back", "left", "up", "down" }.
  03/09/2021  Returns:  true - If turtle detects a block.
                        false - if turtle didn't detect a block.
                        nil - invalid parameter.
              ex: detectDir([sDir="forward"]) - Detect blocks forward.]]
	sDir = sDir or "forward"

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
  return nil
end

function detectAbove(nBlocks) --[[ Detects nBlocks forwards or backwards, 1 block above the turtle.
  03/09/2021  Returns:  true - if turtle detects a line of nBlocks above it.
                        false - if blocked, empty space.
												nil - if invalid parameter.
              sintax: detectAbove([nBlocks=1])
              Note: nBlocks < 0 detects backwards, nBlocks > 0 detects forwards.
              ex: detectAbove() or detectAbove(1) - Detects 1 block up.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return nil end
  local dir = sign(nBlocks)

  for i = 1, nBlocks, dir do
    if not turtle.detectUp() then return false end
    if nBlocks ~= i then
			if not forward(dir) then return false end
		end
  end
  return true
end

function detectBelow(nBlocks) --[[ Detects nBlocks forwards or backwards, 1 block below the turtle.
  03/09/2021  Returns:  true - if turtle detects a line of nBlocks below.
                        false - if blocked, empty space.
												nil - if invalid parameter
              sintax: detectBelow([nBlocks=1])
              Note: nBlocks < 0 detects backwards, nBlocks > 0 detects forwards.
              ex: detectBelow() or detectBelow(1) - Detect 1 block down.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return nil end
  local dir = sign(nBlocks)

  for i = 1, nBlocks, dir do
    if not turtle.detectDown() then return false end
    if i ~= nBlocks then
			if not forward(dir) then return false end
		end
  end
  return true
end


------ INSPECT FUNCTIONS ------

function inspectDir(sDir) --[[ Inspect a block in sDir direction {"forward", "right", "back", "up", "down" }.
  05/09/2021  Returns:  true, table with data - If turtle detects a block.
                        false, message - if turtle didn't detect a block.
              ex: detectDir([sDir="forward"]) - Inspects a block forward.]]
	sDir = sDir or "forward"
  
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
	if isKey(sDir, insF) then return insF[sDir]() end
  return false
end


------ MOVING FUNCTIONS ------

function forward(nBlocks) --[[ Moves nBlocks forward or backwards, until blocked.
  27/08/2021  Returns:  true - if turtle goes all way.
                        false - if turtle was blocked.
              Note: nBlocks < 0 moves backwards, nBlocks > 0 moves forward.
              ex: forward(3) - Moves 3 blocks forward.]] 
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false end
  if nBlocks < 0 then return back(math.abs(nBlocks)) end
  for i = 1, nBlocks do
    if not turtle.forward() then return false end
  end
  return true
end

function back(nBlocks) --[[ Moves nBlocks back or forward, until blocked.
  27/08/2021 -  Returns:  true - if turtle goes all way.
                          false - if turtle was blocked.
                Note: nBlocks < 0 moves forward, nBlocks > 0 moves backwards.
                ex: back(-3) - Moves 3 blocks forward.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false end
  if nBlocks < 0 then return forward(math.abs(nBlocks)) end
  for i = 1, nBlocks do
    if not turtle.back() then return false end
  end
  return true
end

function up(nBlocks) --[[ Moves nBlocks up or down, until blocked.
  27/08/2021 -  Returns:  true - if turtle goes all way.
                          false - if turtle was blocked.
                Note: nBlocks < 0 moves downwards, nBlocks > 0 moves upwards.
                ex: up(3) - Moves 3 blocks up.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false end
  if nBlocks < 0 then return down(math.abs(nBlocks)) end
  for i = 1, nBlocks do
    if not turtle.up() then return false end
  end
  return true
end

function down(nBlocks) --[[ Moves nBlocks down or up, until blocked.
  27/08/2021 -  Returns:  true - if turtle goes all way.
                          false - if turtle was blocked.
                Note: nBlocks < 0 moves up, nBlocks > 0 moves down.
                ex: down(3) - Moves 3 blocks down.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false end
  if nBlocks < 0 then return up(math.abs(nBlocks)) end
  for i = 1, nBlocks do
      if not turtle.down() then return false end
  end
  return true
end


------ GENERAL FUNCTIONS ------

function checkType(sType, ...) --[[ Checks if parameters are from sType.
  03/09/2021  Returns: true - if all parameters match the sType.
              ex: checkType("snt", "hello", number1, tTable) - Outputs: true.]]
	Args = { ... }
  
  if #Args ~= #sType then return false end
	for i = 1, #sType do
		if sType:sub(i,i) ~= type(Args[i]):sub(1,1) then return false end
	end
	return true
end

function getParam(sParamOrder, tDefault, ...) --[[ Sorts parameters by type.
  27/08/2021  Returns: Parameters sorted by type, nil if no parameters.
              ex: getParam("sns", {"default" }, number, string) - Outputs: string, number, default.
              Note: Only sorts two parameters type (string, number).
                    The default table is returned when no parameter is supplied.]]
  if not sParamOrder then return nil end
  
  local Args={...}
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
    for i = 1, #tDefault do
      if type(tDefault[i]) == sType then table.insert(retTable, tDefault[i]) end
    end
  end
  
  for i = 1, #sParamOrder do
    if sParamOrder:sub(i,i) == "s" then addParam("string")
    elseif sParamOrder:sub(i,i) == "n" then addParam("number")
    end
  end
  
  if #retTable == 0 then return nil
  else return table.unpack(retTable);
  end
end

function isKey(Key, t) --[[ Checks if Key is in t table.
  21/09/2021  Returns:  true - if Key is in t.
                        false - if Key is not in t.
              ex: isKey("hello", {["hello"] = 2, ["hi"] = 4}) - Outputs: true.]]
  for k,v in pairs(t) do
    if k == Key then return true end
  end
  return false
end

function tableInTable(tSearch, t) --[[ Verifies if al elements of tSearch is in table t.
  27/08/2021  Returns:  true - tSearch is in t.
                        false - at the least one element of tSearch is not in table t.
              ex: isInTable("forward", lookingType) - outputs true.]]
  if type(tSearch) ~= "table" then return nil end

  totMatch = 0

  for k1, v1 in pairs(tSearch) do
    for k2, v2 in pairs (t) do
      if v2 == v1 then
        totMatch = totMatch + 1
        break
      end
    end
  end

  print(#tSearch, totMatch)
  if #tSearch ~= totMatch then return false end
  return true
end

function sign(value) --[[ Returns: -1 if value < 0, 0 if value == 0, 1 if value > 0
  28/08/2021  Note: returns false if value is not a number, or not supplied.]]
  if type(value) ~= "number" then return false end
  if value < 0 then return -1 end
  if value == 0  then return 0 end
  return 1
end

------ ROTATING FUNCTIONS ------  

function turnBack() --[[ Turtle turns back.
  11/09/2021  Returns:  true.
              sintax: turnBack()
              ex: turnBack() - Turns the turtle back.]]
  turtle.turnRight()
  turtle.turnRight()
  return true
end

function turnDir(sDir) --[[ Turtle turns to sDir direction {"back", "right", "left"}.
  27/08/2021  Returns:  true if sDir is a valid direction.
                        false if sDir is not a valid direction.
              sintax: turn([sDir="back"]) - sDir {"right", "back", "left"}
              ex: turn("back") or turn() - Turns the turtle back.]]
  sDir = sDir or "back"

  if not dirType[sDir] then return false, "Invalid direction." end
  if sDir == "back" then return turnBack()
  elseif sDir == "left" then return turtle.turnLeft()
  elseif sDir == "right" then return turtle.turnRight()
  end
  return true
end


------ MOVING AND ROTATING FUNCTIONS ------

function goDir(sDir, nBlocks) --[[ Turtle goes in sDir nBlocks until blocked.
  27/08/2021  Returns:  true if turtle goes all way.
                        false if blocked.
              sintax: go([sDir="forward"], [nBlocks=1]) - sDir {"forward", "right", "back", "left", "up", "down"}
              ex: go("left", 3) or go(3, "left") - Rotates left and moves 3 Blocks forward.
              ex: go() - Moves 1 block forward.
              ex: go(-3, "up") - moves 3 blocks down.]]
  sDir, nBlocks = getParam("sn", {"forward", 1}, sDir, nBlocks)

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
  27/08/2021  Returns:  true if turtle goes all way.
                        false if bllocked, or invalid parameter.
              Note: nBlocks < 0 goes right, nBlocks > 0 goes left, nBlocks = 0 turns left.
              ex: goLeft(3) - Moves 3 Blocks to the left.]]
  nBlocks = nBlocks or 1

  if type(nBlocks) ~= "number" then return false end
  if nBlocks < 0 then turtle.turnRight()
  else turtle.turnLeft()
  end

  for i = 1, math.abs(nBlocks) do
    if not turtle.forward() then return false end
  end
  return true
end

function goRight(nBlocks) --[[ Turns right or left and advances nBlocks until blocked.
  27/08/2021  Returns:  true if turtle goes all way.
                        false if bllocked, or invalid parameter.
              Note: nBlocks < 0 goes left, nBlocks > 0 goes right, nBlocks = 0 turns right.
              ex: goRight(3) - Moves 3 Blocks to the right.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false end
  if nBlocks < 0 then turtle.turnLeft()
  else turtle.turnRight()
  end

  for i= 1, math.abs(nBlocks) do
    if not turtle.forward() then return false end
  end
  return true
end

function goBack(nBlocks) --[[ Turns back or not and advances nBlocks until blocked.
  27/08/2021  Returns:  true if turtle goes all way.
                        false if blocked, or invalid parameter.
              Note: nBlocks < 0 moves forward, nBlocks >= 0 turns back and advances nBlocks.
              ex: goBack(3) - Turns back and moves 3 blocks forward.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false end
  if nBlocks >= 0  then turnBack() end
  for i = 1, math.abs(nBlocks) do
    if not turtle.forward() then return false end
  end
  return true
end

------ DIG FUNCTIONS ------  

function digDir(sDir, nBlocks) --[[ Turtle digs in sDir direction nBlocks.
  08/09/2021  Returns:  true if turtle digs all way.
                      false if blocked, empty space.
                      nil if invalid parameter
              sintax: digDir([sDir="forward"], [nBlocks=1]) - sDir {"forward", "right", "back", "left", "up", "down"}
              ex: digDir("left", 3) or digDir(3, "left") - Rotates left and digs 3 Blocks forward.
              ex: digDir() - Digs 1 block forward.
              ex: digDir(-3, "up") - Digs 3 blocks down.]]
  sDir, nBlocks =getParam("sn", {"forward", 1}, sDir, nBlocks)
  negOrient = {["forward"] = "back", ["right"] = "left", ["back"] = "forward", ["left"] = "right", ["up"] = "down", ["down"] = "up"}
  
  if type(nBlocks) ~= "number" then return nil end
  if nBlocks < 0 then
    nBlocks = math.abs(nBlocks)
    sDir = negOrient[sDir]
  end

  local success, message = turnDir(sDir)

  if not success  then return false, message end
  if (sDir == "left") or (sDir == "right") or (sDir == "back") then sDir = "forward" end
  for i = 1, nBlocks do
    if not digF[sDir]() then return false end
    if i~= nBlocks then
			if not movF[sDir]() then return false end
		end
  end
  return true
end

function dig(nBlocks) --[[ Turtle digs nBlocks forward or turns back and digs nBlocks, must have a tool equiped.
  27/08/2021  Returns:  true if turtle digs all way.
                        false if blocked, empty space, or invalid parameter.
              sintax: dig([nBlocks=1])
              Note: nBlocks < 0 turns back and digs forward, nBlocks > 0 digs forward.
              ex: dig() or dig(1) - Dig 1 block forward.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false end
  if nBlocks < 0 then turnBack() end
  for i = 1, math.abs(nBlocks) do
    if not turtle.dig() then return false end
    if i~= nBlocks then
			if not turtle.forward() then return false end
		end
  end
  return true
end

function digLeft(nBlocks) --[[ Turtle digs nBlocks to the left or right, must have a tool equiped.
  27/08/2021  Returns:  true if turtle digs all way.
                        false if blocked, empty space, or invalid parameter.
              sintax: digLeft([nBlocks=1])
              Note: nBlocks < 0 digs to the right, nBlocks > 0 digs to the left
              ex: digLeft() or digLeft(1) - Dig 1 block left.]]
  nBlocks = nBlocks or 1
  
	if type(nBlocks) ~= "number" then return false end
  if nBlocks > -1 then turtle.turnLeft()
  else turtle.turnRight()
  end
  return dig(math.abs(nBlocks))
end

function digRight(nBlocks) --[[ Turtle digs nBlocks to the right or left, must have a tool equiped.
  27/08/2021  Returns:  true if turtle digs all way.
                        false if blocked, empty space, or invalid parameter.
              sintax: digRight([nBlocks=1])
              Note: nBlocks < 0 digs to the left, nBlocks > 0 digs to the Right.
              ex: digRight() or digRight(1) - Dig 1 block right.]]
  nBlocks = nBlocks or 1
  
	if type(nBlocks) ~= "number" then return false end
  if nBlocks > -1 then turtle.turnRight()
  else turtle.turnLeft()
  end
  return dig(math.abs(nBlocks))
end

function digUp(nBlocks) --[[ Turtle digs nBlocks upwards or downwards, must have a tool equiped.
  27/08/2021  Returns:  true if turtle digs all way.
                        false if blocked, empty space, or invalid parameter.
              sintax: digUp([nBlocks=1])
              Note: nBlocks < 0 digs downwards, nBlocks > 0 digs upwards.
              ex: digUp() or digUp(1) - Dig 1 block up.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false end
  if nBlocks < 0 then return digDown(math.abs(nBlocks)) end
  for i = 1, nBlocks do
    if not turtle.digUp() then return false end
    if i ~= nBlocks then
			if not turtle.up() then return false end
		end
  end
  return true
end

function digDown(nBlocks) --[[ Turtle digs nBlocks downwards or upwards, must have a tool equiped.
  27/08/2021  Returns:  true if turtle digs all way.
                        false if bllocked, empty space, or invalid parameter.
              sintax: digDown([nBlocks=1])
              Note: nBlocks < 0 digs upwards, nBlocks > 0 digs downwards.
              ex: digDown() or digDown(1) - Dig 1 block up.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false end
  if nBlocks < 0 then return digUp(math.abs(nBlocks)) end
  for i = 1, nBlocks do
    if not turtle.digDown() then return false end
    if i ~= nBlocks then
			if not turtle.down() then return false end
		end
  end
  return true
end

function digAbove(nBlocks) --[[ Digs nBlocks forwards or backwards, 1 block above the turtle, must have a tool equiped.
  27/08/2021  Returns:  true if turtle digs all way.
                        false if blocked, empty space, or invalid parameter.
              sintax: digAbove([nBlocks=1])
              Note: nBlocks < 0 digs backwards, nBlocks > 0 digs forwards.
              ex: digAbove() or digAbove(1) - Dig 1 block up.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false end
  local dir = sign(nBlocks)

  for i = 1, math.abs(nBlocks) do
    if not turtle.digUp() then return false end
    if i~= nBlocks then
			if not forward(dir) then return false end
		end
  end
  return true
end

function digBelow(nBlocks) --[[ Digs nBlocks forwards or backwards, 1 block below the turtle, must have a tool equiped.
  27/08/2021  Returns:  true if turtle digs all way.
                        false if blocked, empty space, or invalid parameter.
              sintax: digBelow([nBlocks=1])
              Note: nBlocks < 0 digs backwards, nBlocks > 0 digs forwards.
              ex: digBelow() or digBelow(1) - Dig 1 block down.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false end
  local dir = sign(nBlocks)
	
  for i = 1, math.abs(nBlocks) do
    if not turtle.digDown() then return false end
    if i~= nBlocks then
			if not forward(dir) then return false end
		end
  end
  return true
end

function digBack(nBlocks) --[[ Turns back or not and digs Blocks forward, must have a tool equiped.
  27/08/2021  Returns:  true if turtle digs all way.
                        false if bllocked, empty space, or invalid parameter.
              sintax: digBack([nBlocks=1])
              Note: nBlocks < 0 digs forward, nBlocks > 0 digs backwards.
              ex: digBack() or digBack(1) - Turns back and dig 1 block forward.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false end
  if nBlocks > 0 then turnBack() end
  for i = 1, math.abs(nBlocks) do
    if not turtle.dig() then return false end
    if i ~= nBlocks then
			if not forward() then return false end
		end
  end
  return true
end


------ PLACE FUNCTIONS ------  

function placeDir(sDir) --[[ Places one selected block in sDir {"forward", "right", "back", "left", "up", "down"}.
  27/08/2021  Returns:  true if turtle places the selected block.
                        false if turtle doesn't place the selected block, or invalid parameter.
              sintax: placeDir([sDir="forward"])
              ex: placeDir("forward") or placeDir() - Places 1 block in front of the turtle.]]
  sDir = sDir or "forward"
  if type(sDir) ~= "string" then return false end

  if sDir == "forward" then
    return turtle.place()
  elseif sDir == "right" then
    turtle.turnRight()
    return turtle.place()
  elseif sDir == "back" then
    turnBack()
    return turtle.place()
  elseif sDir == "left" then
    turtle.turnLeft()
    return turtle.place()
  elseif sDir == "up" then
    return turtle.placeUp()
  elseif sDir == "down" then
    return turtle.placeDown()
  end
  return false
end

function place(nBlocks) --[[ Turtle places nBlocks in a strait line forward or backwards, and returns to starting point.
  27/08/2021  Returns:  number of blocks placed.
                        false - if turtle was blocked on the way back
                              - invalid parameter.
                              - couldn't place block.
              sintax: place([nBlocks=1])
              Note: nBlocks < 0 places blocks backwards, nBlocks > 0 places blocks forwards.
              ex: place(1) or place() - Places 1 Block in front of turtle.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false end
  if nBlocks < 0 then
    turnBack()
    nBlocks=math.abs(nBlocks)
  end
  for i = 2, nBlocks do
    if not turtle.forward() then
      nBlocks=i-2
      back()
      break
    end
  end

  for i = 1, nBlocks do
    if not turtle.place() then return false end
    if i ~= nBlocks then
      if not turtle.back() then return false end
    end
  end
  return nBlocks
end

function placeUp(nBlocks) --[[ Places nBlocks upwards or downwards, and returns to starting point.
  27/08/2021  Returns:  number os blocks placed.
                        false - if turtle was blocked on the way back.
                              - invalid parameter.
              sintax: placeUp([nBlocks=1])
              Note: nBlocks < 0 places blocks downwards, nBlocks > 0 places blocks upwards.
              ex: placeUp(1) or placeUp() - Places 1 Block up.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false end
  if nBlocks < 0 then return placeDown(math.abs(nBlocks)) end
  for i = 2, nBlocks do
    if not turtle.up() then
      nBlocks=i
      down()
      break
    end
  end

  for i = 1, nBlocks do
    turtle.placeUp()
    if i ~= nBlocks then
      if not turtle.down() then return false end
    end
  end
  return nBlocks
end
  
function placeDown(nBlocks) --[[ Places nBlocks downwards or upwards, and returns to starting point.
  27/08/2021  Returns:  number of blocks placed.
                        false - if turtle was blocked on the way back.
                              - invalid parameter.
              sintax: placeDown([nBlocks=1])
              Note: nBlocks < 0 places blocks upwards, nBlocks > 0 places blocks downwards.
              ex: placeDown(1) or placeDown() - Places 1 Block Down.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false end
  if nBlocks < 0 then return placeUp(math.abs(nBlocks)) end
  for i = 2, nBlocks do
    if not turtle.down() then
      nBlocks=i
      up()
      break
    end
  end

  for i = 1, nBlocks do
    turtle.placeDown()
    if i ~= nBlocks then
      if not turtle.up() then return false end
    end
  end
  return nBlocks
end
  
function placeLeft(nBlocks) --[[ Places Blocks to the left or right, and returns to starting point.
  27/08/2021  Returns:  number of placed blocks.
                        false - if turtle was blocked on the way back.
                              - invalid parameter.
                              - couldn't place block.
              sintax: placeLeft([nBlocks=1])
              Note: nBlocks < 0 places blocks to the right, nBlocks > 0 places blocks to the left.
              ex: placeLeft(1) or placeLeft() - Places one Block to the left of the turtle.]]
  nBlocks = nBlocks or 1

  if type(nBlocks) ~= "number" then return false end
  if nBlocks < 0 then turtle.turnRight()
	else turtle.turnLeft()
	end
  return place(math.abs(nBlocks))
end
  
function placeRight(nBlocks) --[[ Places Blocks to the right or left, and returns to starting point.
  27/08/2021  Returns:  true if turtle places all blocks all the way.
                        false - if turtle was blocked on the way back.
                              - invalid parameter.
                              - couldn't place block
              sintax: placeRight([nBlocks=1])
              Note: nBlocks < 0 places blocks to the left, nBlocks > 0 places blocks to the right.
              ex: placeRight(1) or placeLeft() - Places 1 Block on the right of the turtle.]]
  nBlocks = nBlocks or 1

  if type(nBlocks) ~= "number" then return false end
  if nBlocks < 0 then turtle.turnLeft()
	else turtle.turnRight()
	end
  return place(math.abs(nBlocks))
end
  
function placeAbove(nBlocks) --[[ Places nBlocks forwards or backwards in a strait line, 1 block above the turtle, and returns to starting point.
  27/08/2021  Returns:  number of blocks placed
                      false - if turtle was blocked on the way back.
                            - couldn't place block.
                            - invalid parameter.
            sintax: placeAbove([nBlocks=1])
            ex: placeAbove(1) or placeAbove() - Places one Block above turtle.]]
    nBlocks = nBlocks or 1
    
    if type(nBlocks) ~= "number" then return false end
    if nBlocks < 0 then
      nBlocks=math.abs(nBlocks)
      turnBack()
    end
    for i = 2, nBlocks do --goto last pos to place
      if i == 2 then
        if not turtle.up() then
          nBlocks=1
          break
        end
      elseif not turtle.forward() then
        nBlocks = i-1
        break
      end
    end
    
    for i = 1, nBlocks do --place backwards
      if i == nBlocks then
        if i ~= 1 then
          if not turtle.down() then return false end
        end
        if not turtle.placeUp() then return false end
      else
        turtle.place()
        if (i ~= (nBlocks-1)) then
          if not turtle.back() then return false end
        end
      end
    end
    return nBlocks
end

function placeBelow(nBlocks) --[[ Places nBlocks forwards or backwards in a strait line, 1 block below the turtle, and returns to starting point.
  27/08/2021  Returns:  number of placed blocks.
                      false - if turtle was blocked on the way back.
                            - couldn't place block.
                            - invalid parameter.
            sintax: placeBelow([Blocks=1])
            ex: placeBelow(1) or placeBelow() - Places one Block below turtle.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false end
  if nBlocks < 0 then
    nBlocks=math.abs(nBlocks)
    turnBack()
  end
  for i = 2, nBlocks do
    if i == 2 then
      if not turtle.down() then
        nBlocks=1
        break
      end
    elseif not turtle.forward() then
      nBlocks = i-1
      break
    end
  end
  
  for i = 1, nBlocks do
    if i == nBlocks then
      if i ~= 1 then
        if not turtle.up() then return false end
      end
      if not turtle.placeDown() then return false end
    else
      turtle.place()
      if (i ~= (nBlocks-1)) then
        if not turtle.back() then return false end
      end
    end
  end
  return nBlocks
end


------ INVENTORY FUNCTIONS ------

--not tested--
--itemSpace([slot/item Name=selected slot]) get the how many items more you can store in inventory.
function itemSpace(nSlot)
	nSlot = nSlot or turtle.getSelectedSlot() --default slot is the selected slot
	local stack = 0
	
	if type(nSlot) == "string" then --is it  "minecraft:cobblestone" for example.
		nSlot = search(nSlot)
		if not nSlot then return false, "Item not found." end
	end
	
	local tData = turtle.getItemDetail(nSlot)
	if not tData then return false, "Empty slot "..nSlot.."." end
	stack = turtle.getItemSpace(nSlot) + tData.count
	
	nSlot = bit.band(nSlot-1, 15)+1 --nSlot, the start slot [1..16]
	totSpace = 0
	
	for i = 1, 16 do
		tData = turtle.getItemDetail(i)
		if tData then totSpace = totSpace + tData.count
		else totSpace = totSpace + stack
		end
	end
	
	return totSpace
end

function compareDir(sDir, nSlot) --[[ Compares item in slot with block in sDir direction.
  21/09/2021  Returns: true - if the item in slot and in the world is the same.
                      false - if block in slot and in the world are not the same,
                              invalid direction,
                              if nSlot is not a number,
                              if empty slot.
              sintax: compareDir([sDir="forward"][, nSlot=selected slot])
              ex: compareDir() compares selected slot with block in front of turtle.
                  compareDir("left", 2) - compares item in slot 2 with block on the left.]]
	sDir, nSlot = getParam("sn", {"forward", turtle.getSelectedSlot()}, sDir, nSlot)
	
	if not dirType[sDir] then return false, "Invalid direction." end
	if type(nSlot) ~= "number" then return false, "Slot is not a number." end
	local invData = turtle.getItemDetail(nSlot)
	if not invData then return false, "Empty slot." end
	
	if (sDir == "left") or (sDir == "right") or (sDir == "back") then
		turnDir(sDir)
		sDir = "forward"
	end
	
	local success, worlData = insF[sDir]()
	if worlData.name == invData.name then return true end
	return false
end

function itemCount(nSlot) --[[ Counts items in inventory
  31/08/2021  Returns: number of items counted.
                      false - if nSlot <0 or > 16.
                            - if nSlot is neither a string nor a number.
              sintax: itemCount([nSlot=turtle.getSelectedSlot() / "inventory" / item name])
              ex: itemCount() counts items in selected slot.
                  itemCount("inventory") - counts items in inventory.
                  itemCount("minecraft:cobblestone") - counts cbblestone in inventory.]]
  nSlot = nSlot or turtle.getSelectedSlot()
  totItems = 0

  if type(nSlot) == "number" then
    if (nSlot < 1) or (nSlot > 16) then return false end
    tData = turtle.getItemDetail(nSlot)
    if tData then totItems = tData.count end
  else
    if type(nSlot) ~= "string" then return false end
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

function itemName(nSlot) --[[ Gets the item name from Slot/selected slot.
  05/09/2021  Returns: item name - if selected slot/slot is not empty.
                        false - if selected slot/slot is empty. ]]
  nSlot = nSlot or turtle.getSelectedSlot()

  if type(nSlot) ~= "number" then return nil end
  if (nSlot <1 ) or (nSlot > 16) then return false, "Slot "..nSlot.." out of range." end

  local tData = turtle.getItemDetail(nSlot)
  if not tData then return false end
  return tData.name
end

function search(sItemName, nStartSlot) --[[ Search inventory for ItemName, starting at startSlot. 
  28/08/2021  returns:  The first slot where the item was found, and the quantity
                        False - if the item was not found
                              - if sItemName not supplied.
                              - if nStartSlot is not a number.
              Note: nStartSlot < 0 search backwards, nStartSlot > 0 searchs forward.
                    if not supplied nStartSlot, default is the selected slot.
              sintax: Search(sItemName [, nStartSlot=turtle.getSelectedSlot()]) ]]
	if not sItemName then return false end
	sItemName, nStartSlot = getParam("sn", {turtle.getSelectedSlot()}, sItemName, nStartSlot)
  if type(nStartSlot) ~= "number" then return false end
  dir = sign(nStartSlot)
  nStartSlot = math.abs(nStartSlot)-1
  nStartSlot = bit32.band(nStartSlot, 15)
	slot = nStartSlot
	
	repeat
    tData = turtle.getItemDetail(slot+1)

    if tData then
      if tData.name == sItemName then
        return slot+1, tData.count
      end
    end
    slot = slot + dir
    slot = bit32.band(slot, 15)
  until (slot == nStartSlot)
  return false
end

function itemSelect(itemName) --[[ Selects slot [1..16] or first item with Item Name, or the turtle selected slot.
  29/08/2021  returns:  The selected slot, and items in that slot.
                        False - if the item was not found
                              - if nStartSlot is not a number or a string.
                              - if value is a number and ( < 1 or > 16 )
              Note: if executed select() is the same as turtle.getSelectedSlot()
              sintax: select([Slot/Item Name])
              ex: select("minecraft:cobblestone") - Selects first slot with "minecraft:cobblestone"]]
  local nSlot
  local tData

  if not itemName then
    nSlot = turtle.getSelectedSlot()
    tData = turtle.getItemDetail()
    if tData then return nSlot, tData.count
    else return nSlot
    end
  end
  if type(itemName) == "number" then
    if (itemName < 1) or (itemName > 16) then return false end
    if turtle.select(itemName) then return itemName end
  end

  if type(itemName) ~= "string" then return false end
  nSlot = search(itemName)

  if nSlot then
    turtle.select(nSlot)
    tData = turtle.getItemDetail()
    if tData then return nSlot, tData.count
    else return nSlot
    end
  end
  return false
end

------ SUCK FUNCTIONS ------

function suckDir(sDir, nItems) --[[ Sucks nItems from sDir direction {"forward", "right", "back", "left", "up", "down"}.
  05/09/2021  Returns:  true if turtle collects some items.
                        false if there are no items to take.
              sintax: suckDir([sDir="forward][,nItems=all the items])
              ex: suckDir() - Turtle sucks all the items forward.]]
  sDir, nItems = getParam("sn", {"forward"}, sDir, nItems)
  if nItems < 0 then return dropDir(sDir, math.abs(nItems)) end
  if type(sDir) ~= "string" then return false end

  if sDir == "right" then
    turtle.turnRight()
    sDir = "forward"
  elseif sDir == "back" then
    turnBack()
    sDir = "forward"
  elseif sDir == "left" then
    turtle.turnLeft()
    sDir = "forward"
  end

  if not isKey(sDir, suckF) then return false, "Invalid direction." end
  return suckF[sDir](nItems)
end

------ DROP FUNCTIONS ------  

function dropDir(sDir, nBlocks) --[[ Drops or sucks nBlocks from selected slot and inventory in the world in front, up or down the turtle.
  29/08/2021  Returns:  number of dropped items.
                        true - if suck some items.
                        false - empty selected slot.
                        nil - if invalid direction.
              Sintax: drop([sDir="forward"] [, nBlocks=stack of items])
              Note: if nBlocks not supplied, drops all items in selected slot.
              ex: dropDir() - Drops all blocks from selected slot, forward.
                  dropDir(205, "up") - Drops 205 blocks from inventory like the one on selected slot, upwards.
                  drop(-5, "down") - Suck 5 items from down.]]

  selectedSlot = turtle.getSelectedSlot() --save selected slot
  tData = turtle.getItemDetail() --check the selected slot for items
  sDir, nBlocks = getParam("sn", {"forward"}, sDir, nBlocks) --sDir as direction, nBlocks as a number.

  if not dirType[sDir] then return nil, "Invalid direction." end --invalid direction

  if not lookingType[sDir] then
    goDir(sDir, 0) --turn if it must
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
  29/08/2021  Returns:  number of dropped items.
                        false - empty selected slot.
                        true - if suck some items.
              Sintax: drop([nBlocks])
              Note: if nBlocks not supplied, drops all items from selected slot.
              ex: drop() - Drops all blocks from selected slot, in front of the turtle.
                  drop(205) - Drops 205 blocks from inventory like the one on selected slot, forward.]]
  return dropDir("forward", nBlocks)
end

function dropUp(nBlocks) --[[ Drops or sucks nBlocks upwards.
  29/08/2021  Returns:  number of dropped items.
                        false - empty selected slot.
                        true - if suck some items.
              Sintax: dropUp([nBlocks])
              Note: if nBlocks not supplied, drops all items from selected slot.
              ex: dropUp() - Drops all blocks from selected slot, upwards.
                  dropUp(205) - Drops 205 blocks from inventory like the one on selected slot, upwards.]]
  return dropDir("up", nBlocks)
end

function dropDown(nBlocks) --[[ Drops or sucks nBlocks downwards.
  29/08/2021  Returns:  number of dropped items.
                        false - empty selected slot.
                        true - if suck some items.          
              Sintax: dropDown([nBlocks])
              Note: if nBlocks not supplied, drops all items from selected slot.
              ex: dropDown() - Drops all blocks from selected slot, downwards.
                  dropDown(205) - Drops 205 blocks from inventory like the one on selected slot, downwards.]]
  return dropDir("down", nBlocks)
end

function dropLeft(nBlocks) --[[ Rotate left and drops or sucks nBlocks forward.
  11/09/2021  Returns:  number of dropped items.
                        false - empty selected slot.
                        true - if suck some items.
              Sintax: dropLeft([nBlocks])
              Note: if nBlocks not supplied, drops all items from selected slot.
              ex: dropLeft() - Rotate left and drops all blocks from selected slot forward.
                  dropLeft(205) - Rotate left and drops 205 blocks from inventory like the one on selected slot, forward.]]
  return dropDir("left", nBlocks)
end

function dropRight(nBlocks) --[[ Rotate right and drops or sucks nBlocks forward.
  11/09/2021  Returns:  number of dropped items.
                        false - empty selected slot.
                        true - if suck some items.
              Sintax: dropRight([nBlocks])
              Note: if nBlocks not supplied, drops all items from selected slot.
              ex: dropRight() - Rotate right and drops all blocks from selected slot, forward.
                  dropRight(205) - Rotate right and drops 205 blocks from inventory like the one on selected slot, forward.]]
  return dropDir("right", nBlocks)
end

function dropBack(nBlocks) --[[ Rotate back and drops or sucks nBlocks forward.
  29/08/2021  Returns:  number of dropped items.
                        false - empty selected slot.
                        true - if suck some items.
              Sintax: dropBack([nBlocks])
              Note: if nBlocks not supplied, drops all items from selected slot.
              ex: dropBack() - Rotate back and drops all blocks from selected slot, forward.
                  dropBack(205) - Rotate back and drops 205 blocks from inventory like the one on selected slot, forward.]]
  return dropDir("back", nBlocks)
end


---- TEST AREA ------

-- [x] setCoords(x,y,z) sets coords x, y, z for turtle. x
-- [x] distTo(x, y, z) gets the three components of the distance from the turtle to point.
-- [x] getCoords() gets coords from turtle.
-- [x] itemSpace([slot/item Name=selected slot]) get the how many items more you can store in inventory.



------ TESTING ------

sleep(1)
print(itemSpace())

------ TESTED ------
-- [x] checkType(sType, ...) Checks if parameters are from sType.
-- [x] getParam(sParamOrder, tDefault, ...) Sorts parameters by type.
-- [x] tableInTable(tSearch, t) Verifies if tSearch is in table t.
-- [x] sign(value) Returns: -1 if value < 0, 0 if value == 0, 1 if value > 0
-- [x] inspectDir([sDir="forward]) turtle inspect block in sDir direction {"forward", "right", "back", "left", "up", "down"}.
-- [x] suckDir([sDir="forward"][,count=all the items]) sucks items from sDir direction {"forward", "right", "back", "left", "up", "down"}.
-- [x] attackDir([sDir="forward"]) Turtle attack in sDir direction {"forward", "right", "back", "left", "up", "down"}.
-- [x] compareAbove([Blocks=1]) compare blocks above the turtle in a strait line with selected slot.
-- [x] compareBelow([Blocks=1]) compare blocks below the turtle in a strait line with selected slot.
-- [x] detectAbove([Blocks=1]) detects if exits Blocks above the turtle in a strait line forward or backwards.
-- [x] detectBelow([Blocks=1]) detects if exits Blocks below the turtle in a strait line forward or backwards.
-- [x] detectDir([Direction="forward"]) detects if there is a block in Direction { "forward", "right", "back", "left", "up", "down" }.
-- [x] itemName([Slot=Selected slot]) gets the item name from Slot.
-- [x] itemCount([selected slot/slot/inventory/item name]) counts items in inventory.
-- [x] itemSelect([Slot/Item Name]) selects slot [1..16] or first item with Item Name, or the turtle selected slot.
-- [x] Search([ItemName[, StartSlot=Selected Slot]]) Search inventory for ItemName, starting at StartSlot. 
-- [x] placeBelow([Blocks=1]) places inventory selected Blocks in a strait line 1 block below the turtle and forward, and returns to initial position.
-- [x] placeAbove([Blocks=1]) places inventory selected Blocks in a strait line 1 block above the turtle and forward, and returns to initial position.
-- [x] placeRight([Blocks=1]) rotates turtle Right, places inventory selected Blocks in a strait line forward, and returns to initial position.
-- [x] placeLeft([Blocks=1]) rotates turtle left, places inventory selected Blocks in a strait line forward, and returns to initial position.
-- [x] place([Blocks=1]) places inventory selected Blocks in a strait line forward.
-- [x] placeDown([Blocks=1]) places inventory selected Blocks in a strait line downward, and returns to initial position.
-- [x] placeUp([Blocks=1]) places inventory selected Blocks in a strait line upward, and returns to initial position.
-- [x] placeDir([Direction="forward"]) places inventory selected Block in Direction { "forward", "right", "back", "left", "up", "down" }.
-- [x] digBack([Blocks=1]) rotates turtle back or not and dig Blocks forward.
-- [x] digAbove([Blocks=1]) dig Blocks, 1 block above the turtle, and forward or backwards.
-- [x] digBelow([Blocks=1]) dig Blocks, 1 block below the turtle, and forward or backwards.
-- [x] digUp([Blocks=1]) dig Blocks upwards or downwards.
-- [x] digDown([Blocks=1]) dig Blocks downwards or upwards.
-- [x] digRight([Blocks=1]) rotates turtle Right or left and dig Blocks forward with tool.
-- [X] digLeft([Blocks=1]) rotates turtle left or right and dig Blocks forward with tool.
-- [x] dig([Blocks=1]) dig Blocks forward or backwards with tool.
-- [x] digDir([Direction="forward"][, Blocks=1]) turtle digs in Direction direction Blocks.
-- [X] turnDir([Direction="back"]) rotates turtle back, left or right.
-- [x] turnBack() Turtle turns back.
-- [x] goDir([Direction="forward][, nBlocks]) turtle goes in Direction { "forward", "right", "back", "left", "up", "down" } nBlocks until blocked.
-- [x] goLeft(nBlocks) turns left or  right if nBlocks <0, and advances nBlocks until blocked.
-- [x] goRight(nBlocks) turns right or left if nBlocks < 0, and advances nBlocks until blocked.
-- [x] goBack(nBlocks) turns back or not if nBlocks < 0, and advances nBlocks until blocked.
-- [x] back([Blocks=1]) moves the turtle backwards blocks, until it hits something.
-- [x] forward([Blocks=1]) Moves nBlocks forward or backwards, until blocked.
-- [x] down([Blocks=1]) moves the turtle down blocks, until it hits something.
-- [x] up([Blocks=1]) moves the turtle up blocks, until it hits something.
-- [x] dropDir([sDir="forward"][, nBlocks=stack of items]) drops nBlocks from selected slot and inventory in the world in front, up or down the turtle.
-- [x] drop(nBlocks) drops nBlocks from selected slot and inventory in the world in front of the turtle.
-- [x] dropUp(nBlocks) drops nBlocks from selected slot and inventory in the world upwards.
-- [x] dropDown(nBlocks) drops nBlocks from selected slot and inventory in the world downwards.
-- [x] dropLeft(nBlocks) rotate left and drops or sucks nBlocks forward.
-- [x] dropRight(nBlocks) rotate right and drops or sucks nBlocks forward.
-- [x] dropBack(nBlocks) rotate back and drops or sucks nBlocks forward.
