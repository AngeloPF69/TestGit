
lookingType = { "up", "forward", "down"} --where is the turtle looking, it can't look to the sides or back.


------ MOVING FUNCTIONS ------

function forward(nBlocks) --[[Moves nBlocks forward or backwards, until blocked.
  27/08/2021  Returns:  true - If turtle goes all way.
                        false - If turtle was blocked.
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

function back(nBlocks) --[[Moves nBlocks back or forward, until blocked.
  27/08/2021 -  Returns:  true - If turtle goes all way.
                          false - If turtle was blocked.
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

function up(nBlocks) --[[Moves nBlocks up or down, until blocked.
  27/08/2021 -  Returns:  true - If turtle goes all way.
                          false - If turtle was blocked.
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

function down(nBlocks) --[[Moves nBlocks down or up, until blocked.
  27/08/2021 -  Returns:  true - If turtle goes all way.
                          false - If turtle was blocked.
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

function getParam(sParamOrder, tDefault, ...) --[[ Sorts parameters by type.
  27/08/2021  Returns: Parameters sorted by type, nil if no parameters.
              ex: getParam("sns", {"default" }, number, string) - Outputs: string, number, default.
              Note: Only sorts two parameters type (string, number).
                    The default table is returned when no parameter is supplied.
              ]]
  if not sParamOrder then return nil end
  
  local Args={...}
  local retTable = {}
  local checked={}

  function addParam(sType)
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

function isInTable(value, t) --[[ Verifies if value is in table t, value can be a table too.
  27/08/2021  Returns:  true - value is in t.
                        false - at the least one value is not in table t.
              ex: isInTable("forward", lookingType) - outputs true.]]
  totMatch = 0

  for k1, v1 in pairs(t) do
    if type(value) == "table" then
      for k2, v2 in pairs (value) do
        if v2 == v1 then totMatch = totMatch + 1 end
      end
    elseif v1 == value then return true
    end
  end
  if totMatch == 0 then return false
  elseif #value ~= totMatch then return false
  end
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

function turnBack() --[[Turtle turns back.
  27/08/2021  Returns:  true.]]
  turtle.turnRight()
  turtle.turnRight()
  return true
end

function turn(sDir) --[[Turtle turns to sDir direction {"back", "right", "left"}.
  27/08/2021  Returns:  true if sDir is a valid direction.
                        false if sDir is not a valid direction.
              sintax: turn([sDir="back"]) - sDir {"right", "back", "left"}
              ex: turn("back") or turn() - Turns the turtle back.]]
  sDir = sDir or "back"
  
  if sDir == "back" then
    turnBack()
  elseif sDir == "left" then
    turtle.turnLeft()
  elseif sDir == "right" then
    turtle.turnRight()
  else return false
  end
  return true
end


------ MOVING AND ROTATING FUNCTIONS ------

function goLeft(nBlocks) --[[Turns left or  right and advances nBlocks until blocked.
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

function goRight(nBlocks) --[[Turns right or left and advances nBlocks until blocked.
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

function goBack(nBlocks) --[[Turns back or not and advances nBlocks until blocked.
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

function go(sDir, nBlocks) --[[Turtle goes in sDir nBlocks until blocked.
  27/08/2021  Returns:  true if turtle goes all way.
                        false if bllocked.
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


------ DIG FUNCTIONS ------  

function dig(nBlocks) --[[Turtle digs nBlocks forward or turns back and digs nBlocks, must have a tool equiped.
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
    if not turtle.forward() then return false end
  end
  return true
end

function digLeft(nBlocks) --[[Turtle digs nBlocks to the left or right, must have a tool equiped.
  27/08/2021  Returns:  true if turtle digs all way.
                        false if blocked, empty space, or invalid parameter.
              sintax: digLeft([nBlocks=1])
              Note: nBlocks < 0 digs to the right, nBlocks > 0 digs to the left
              ex: digLeft() or digLeft(1) - Dig 1 block left.]]
  nBlocks = nBlocks or 1
  
  turtle.turnLeft()
  return dig(nBlocks)
end

function digRight(nBlocks) --[[Turtle digs nBlocks to the right or left, must have a tool equiped.
  27/08/2021  Returns:  true if turtle digs all way.
                        false if blocked, empty space, or invalid parameter.
              sintax: digRight([nBlocks=1])
              Note: nBlocks < 0 digs to the left, nBlocks > 0 digs to the Right.
              ex: digRight() or digRight(1) - Dig 1 block right.]]
  nBlocks = nBlocks or 1
  
  turtle.turnRight()
  return dig(nBlocks)
end

function digUp(nBlocks) --[[Turtle digs nBlocks upwards or downwards, must have a tool equiped.
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
    if not turtle.up() then return false end
  end
  return true
end

function digDown(nBlocks) --[[Turtle digs nBlocks downwards or upwards, must have a tool equiped.
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
    if not turtle.down() then return false end
  end
  return true
end

function digAbove(nBlocks) --[[Digs nBlocks forwards or backwards, 1 block above the turtle, must have a tool equiped.
  27/08/2021  Returns:  true if turtle digs all way.
                        false if blocked, empty space, or invalid parameter.
              sintax: digAbove([nBlocks=1])
              Note: nBlocks < 0 digs backwards, nBlocks > 0 digs forwards.
              ex: digAbove() or digAbove(1) - Dig 1 block up, and advances 1 block forward.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false end
  if nBlocks < 0 then turnBack() end
  for i = 1, math.abs(nBlocks) do
    if not turtle.digUp() then return false end
    if not turtle.forward() then return false end
  end
  return true
end

function digBelow(nBlocks) --[[Digs nBlocks forwards or backwards, 1 block below the turtle, must have a tool equiped.
  27/08/2021  Returns:  true if turtle digs all way.
                        false if blocked, empty space, or invalid parameter.
              sintax: digBelow([nBlocks=1])
              Note: nBlocks < 0 digs backwards, nBlocks > 0 digs forwards.
              ex: digBelow() or digBelow(1) - Dig 1 block down, and advances 1 block forward.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false end
  if nBlocks < 0 then turnBack() end
  for i = 1, nBlocks do
    if not turtle.digDown() then return false end
    if not turtle.forward() then return false end
  end
  return true
end

function digBack(nBlocks) --[[Turns back or not and digs Blocks forward, must have a tool equiped.
  27/08/2021  Returns:  true if turtle digs all way.
                        false if bllocked, empty space, or invalid parameter.
              sintax: digBack([nBlocks=1])
              Note: nBlocks < 0 digs forward, nBlocks > 0 digs backwards.
              ex: digBack() or digBack(1) - Turns back and dig 1 block forward, and advances 1 block forward.]]
  nBlocks = nBlocks or 1
  
  if type(nBlocks) ~= "number" then return false end
  if nBlocks > 0 then turnBack() end
  for i = 1, math.abs(nBlocks) do
    if not turtle.dig() then return false end
    if not turtle.forward() then return false end
  end
  return true
end


------ PLACE FUNCTIONS ------  

function placeDir(sDir) --[[Places one selected block in sDir {"forward", "right", "back", "left", "up", "down"}.
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

function place(nBlocks) --[[Turtle places nBlocks in a strait line forward or backwards, and returns to starting point.
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

function placeUp(nBlocks) --[[Places nBlocks upwards or downwards, and returns to starting point.
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
  
function placeDown(nBlocks) --[[Places nBlocks downwards or upwards, and returns to starting point.
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
  
function placeLeft(nBlocks) --[[Places Blocks to the left or right, and returns to starting point.
  27/08/2021  Returns:  number of placed blocks.
                        false - if turtle was blocked on the way back.
                              - invalid parameter.
                              - couldn't place block.
              sintax: placeLeft([nBlocks=1])
              Note: nBlocks < 0 places blocks to the right, nBlocks > 0 places blocks to the left.
              ex: placeLeft(1) or placeLeft() - Places one Block to the left of the turtle.]]
  
  turtle.turnLeft()
  return place(nBlocks)
end
  
function placeRight(nBlocks) --[[Places Blocks to the right or left, and returns to starting point.
  27/08/2021  Returns:  true if turtle places all blocks all the way.
                        false - if turtle was blocked on the way back.
                              - invalid parameter.
                              - couldn't place block
              sintax: placeRight([nBlocks=1])
              Note: nBlocks < 0 places blocks to the left, nBlocks > 0 places blocks to the right.
              ex: placeRight(1) or placeLeft() - Places 1 Block on the right of the turtle.]]
  turtle.turnRight()
  return place(nBlocks)
end
  
function placeAbove(nBlocks) --[[Places nBlocks forwards or backwards in a strait line, 1 block above the turtle, and returns to starting point.
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

function placeBelow(nBlocks) --[[Places nBlocks forwards or backwards in a strait line, 1 block below the turtle, and returns to starting point.
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

function invSearch(sItemName, nStartSlot) --[[ Search inventory for ItemName, starting at startSlot. 
  28/08/2021  returns:  The first slot where the item was found, and the quantity
                        False - if the item was not found
                              - if sItemName not supplied.
                              - if nStartSlot is not a number.
              Note: nStartSlot < 0 search backwards, nStartSlot > 0 searchs forward.
                    if not supplied nStartSlot, default is the selected slot.
              sintax: invSearch(sItemName [, nStartSlot=turtle.getSelectedSlot()])]]
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

function select(value) --[[ Select slot value or select slot with itemName = value. 
  29/08/2021  returns:  The selected slot.
                        False - if the item was not found
                              - if nStartSlot is not a number or a string.
                              - if value is a number and ( < 1 or > 16 )
              Note: if executed select() is the same as turtle.getSelectedSlot()
              sintax: select([value/Item Name])
              ex: select("minecraft:cobblestone") - Selects first slot with "minecraft:cobblestone"]]
  if not value then return turtle.getSelectedSlot() end
  if type(value) == "number" then
    if (value < 1) or (value > 16) then return false end
    if turtle.select(value) then return value end
  end
  if type(value) ~= "string" then return false end
  slot = invSearch(value)
  if slot then
    turtle.select(slot)
    return slot
  end
  return false
end
------ DROP FUNCTIONS ------  

function dropDir(sDir, nBlocks) --[[Drops nBlocks from selected slot and inventory in the world in front, up or down the turtle.
  29/08/2021  Returns:  number of dropped items.
                        false - empty selected slot.
                              - if nBlocks is not a number
              Sintax: drop([sDir="forward"] [,nBlocks])
              Note: if nBlocks not supplied, drops all items in selected slot.
              ex: dropDir() - Drops all blocks from selected slot, forward.
                  dropDir(205, "up") - Drops 205 blocks from inventory like the one on selected slot, upwards.]]

  tData = turtle.getItemDetail() --check the selected slot for items
  if not tData then return false end --no items                

  sDir, nBlocks = getParam("sn", {"forward"}, sDir, nBlocks) --asign sDir and nBlocks

  if not isInTable(sDir, lookingType) then return false end --invalid direction
	
  dropFunction = { ["up"]=turtle.dropUp, ["forward"]=turtle.drop, ["down"]=turtle.dropDown } --functions to drop

  if not nBlocks then --drop all the stack from selected slot
		dropFunction[sDir]()
		return tData.count
	end

  nBlocks = math.abs(nBlocks) --nBlocks must be a positive number
	local blocksDropped = 0 --total blocks dropped

	while (blocksDropped < nBlocks) do
    if tData.count > (nBlocks-blocksDropped) then
      dropFunction[sDir](nBlocks-blocksDropped)
      blocksDropped = blocksDropped + (nBlocks-blocksDropped)
    else
      dropFunction[sDir]()
      blocksDropped = blocksDropped + tData.count
      nextSlot, tData.count = invSearch(tData.name)
      if nextSlot then turtle.select(nextSlot)
      elseif blocksDropped < nBlocks then break
      end
    end
  end
  return blocksDropped
end

function drop(nBlocks) --[[Drops nBlocks from selected slot and inventory in the world in front of the turtle.
  29/08/2021  Returns:  number of dropped items.
                        false - empty selected slot.
                              - if nBlocks is not a number
              Sintax: drop([nBlocks])
              Note: if nBlocks not supplied, drops all items from selected slot.
              ex: drop() - Drops all blocks from selected slot, in front of the turtle.
                  drop(205) - Drops 205 blocks from inventory like the one on selected slot, forward.]]
  return dropDir("forward", nBlocks)
end

function dropUp(nBlocks) --[[Drops nBlocks from selected slot and inventory in the world upwards.
  29/08/2021  Returns:  number of dropped items.
                        false - empty selected slot.
                              - if nBlocks is not a number
              Sintax: dropUp([nBlocks])
              Note: if nBlocks not supplied, drops all items from selected slot.
              ex: dropUp() - Drops all blocks from selected slot, upwards.
                  dropUp(205) - Drops 205 blocks from inventory like the one on selected slot, upwards.]]
  return dropDir("up", nBlocks)
end

function dropDown(nBlocks) --[[Drops nBlocks from selected slot and inventory in the world downwards.
  29/08/2021  Returns:  number of dropped items.
                        false - empty selected slot.
                              - if nBlocks is not a number
              Sintax: dropDown([nBlocks])
              Note: if nBlocks not supplied, drops all items from selected slot.
              ex: dropDown() - Drops all blocks from selected slot, downwards.
                  dropDown(205) - Drops 205 blocks from inventory like the one on selected slot, downwards.]]
  return dropDir("down", nBlocks)
end

------ TEST AREA -----
print(select(17))

