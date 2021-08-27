------ MOVING FUNCTIONS ------
local function forward(Blocks) --[[Moves forward Blocks, until blocked.
27/08/2021 -  Returns: true - If turtle goes all way.
                       false - If turtle was blocked.
              ex: forward(3) - Moves 3 blocks forward.]] 
  Blocks = Blocks or 1
  
  for i = 1, Blocks do
    if not turtle.forward() then return false end
  end
  return true
end

local function back(Blocks) --[[Moves back Blocks, until blocked.
27/08/2021 -  Returns: true - If turtle goes all way.
                       false - If turtle was blocked.
              ex: back(3) - Moves 3 blocks backwards.]]
  Blocks = Blocks or 1
  
  for i = 1, Blocks do
    if not turtle.back() then return false end
  end
  return true
end

local function up(Blocks) --[[Moves up Blocks, until blocked.
27/08/2021 -  Returns: true - If turtle goes all way.
                       false - If turtle was blocked.
              ex: forward(3) - Moves 3 blocks up.]]
  Blocks = Blocks or 1
  
  for i = 1, Blocks do
    if not turtle.up() then return false end
  end
  return true
end

local function down(Blocks) --[[Moves down Blocks, until blocked.
27/08/2021 -  Returns: true - If turtle goes all way.
                       false - If turtle was blocked.
              ex: down(3) - Moves 3 blocks down.]]
  Blocks = Blocks or 1
  
  for i = 1, Blocks do
      if not turtle.down() then return false end
  end
  return true
end


------ GENERAL FUNCTIONS ------

local function getParam(sParamOrder, ...) --[[ Sorts parameters by type.
27/08/2021  Returns: Parameters sorted by type.
            ex: getParam("sns", number, string, string) - Outputs: string, number, string.
            Note: Just two parameters type (string, number)]]
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
  end
  
  for i = 1, #sParamOrder do
    if sParamOrder:sub(i,i) == "s" then addParam("string")
    elseif sParamOrder:sub(i,i) == "n" then addParam("number")
    end
  end
  
  return table.unpack(retTable);
end


------ ROTATING FUNCTIONS ------  

local function turnBack() --[[Turtle turns back.
27/08/2021  Returns:  true.]]
  turtle.turnRight()
  turtle.turnRight()
  return true
end

local function turn(sDir) --[[Turtle turns  to sDir direction.
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

local function goLeft(Blocks) --[[Turns left and advances Blocks until blocked.
27/08/2021  Returns:  true if turtle goes all way.
                      false if bllocked.
            ex: goLeft(3) - Moves 3 Blocks to the left.]]
  Blocks = Blocks or 1
  
  turtle.turnLeft()
  for i = 1, Blocks do
    if not turtle.forward() then return false end
  end
  return true
end

local function goRight(Blocks) --[[Turns right and advances Blocks until blocked.
27/08/2021  Returns:  true if turtle goes all way.
                      false if bllocked.
            ex: goRight(3) - Moves 3 Blocks to the right.]]
  Blocks = Blocks or 1
  
  turtle.turnRight()
  for i= 1, Blocks do
    if not turtle.forward() then return false end
  end
  return true
end

local function goBack(Blocks) --[[Turns back and advances Blocks until blocked.
27/08/2021  Returns:  true if turtle goes all way.
                      false if bllocked.
            ex: goBack(3) - Moves 3 Blocks back.]]
  Blocks = Blocks or 1
  
  turnBack()
  for i = 1, Blocks do
    if not turtle.forward() then return false end
  end
  return true
end

local function go(sDir, Blocks) --[[Turtle goes in sDir Blocks until blocked.
27/08/2021  Returns:  true if turtle goes all way.
                      false if bllocked.
            sintax: go([sDir="forward"], [Blocks=1]) - sDir {"forward", "right", "back", "left", "up", "down"}
            ex: go("left", 3) or go(3, "left") - Moves 3 Blocks to the left.]]
  sDir = sDir or "forward"
  Blocks = Blocks or 1
  sDir, Blocks = getParam("sn", sDir, Blocks)
    
  if sDir == "forward" then return forward(Blocks)
  elseif sDir == "right" then return goRight(Blocks)
  elseif sDir == "back" then return goBack(Blocks)
  elseif sDir == "left" then return goLeft(Blocks)
  elseif sDir == "up" then return up(Blocks)
  elseif sDir == "down" then return down(Blocks)
  end
  return false
end


------ DIG FUNCTIONS ------  

local function dig(Blocks)
  Blocks = Blocks or 1
  
  for i = 1, Blocks do
    if not turtle.dig() then return false end
    if not turtle.forward() then return false end
  end
  return true
end

local function digLeft(Blocks)
  Blocks = Blocks or 1
  
  turtle.turnLeft()
  return dig(Blocks)
end

local function digRight(Blocks)
  Blocks = Blocks or 1
  
  turtle.turnRight()
  return dig(Blocks)
end

local function digUp(Blocks)
  Blocks = Blocks or 1
  
  for i = 1, Blocks do
    if not turtle.digUp() then return false end
    if not turtle.up() then return false end
  end
  return true
end

local function digDown(Blocks)
  Blocks = Blocks or 1
  
  for i = 1, Blocks do
    if not turtle.digDown() then return false end
    if not turtle.up() then return false end
  end
  return true
end

local function digAbove(Blocks)
  Blocks = Blocks or 1
  
  for i = 1, Blocks do
    if not turtle.digUp() then return false end
    if not turtle.forward() then return false end
  end
  return true
end

local function digBelow(Blocks)
  Blocks = Blocks or 1
  
  for i = 1, Blocks do
    if not turtle.digDown() then return false end
    if not turtle.forward() then return false end
  end
  return true
end

local function digBack(Blocks)
  Blocks = Blocks or 1
  
  turnBack()
  for i = 1, Blocks do
    if not turtle.dig() then return false end
    if not turtle.forward() then return false end
  end
  return true
end


------ PLACE FUNCTIONS ------  

local function placeDir(sDir) --[[Places one selected block in sDir direction.
27/08/2021  Returns:  true if turtle places the selected block.
                      false if turtle doesn't place the selected block.
            sintax: placeDir([sDir="forward"]) - sDir {"forward", "right", "back", "left", "up", "down"}
            ex: placeDir("forward") or placeDir() - Places 1 block in front of the turtle.]]
  sDir = sDir or "forward"

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

local function place(Blocks) --[[Turtle places Blocks in a strait line forward, and returns to starting point.
27/08/2021  Returns:  true.
                      false if turtle was blocked, on the way back.
            sintax: place([Blocks=1])
            ex: place(1) or place() - Places 1 Block in front of turtle.]]
  Blocks = Blocks or 1
  
  for i = 2, Blocks do
    if not turtle.forward() then
      Blocks=i-2
      back()
      break
    end
  end

  for i = 1, Blocks do
    turtle.place()
    if i ~= Blocks then
      if not turtle.back() then return false end
    end
  end
  return true
end

local function placeUp(Blocks) --[[Turtle places Blocks in a strait line upwards, and returns to starting point.
27/08/2021  Returns:  true.
                      false if turtle was blocked, on the way back.
            sintax: placeUp([Blocks=1])
            ex: placeUp(1) or placeUp() - Places 1 Block up.]]
    Blocks = Blocks or 1
    
    for i = 2, Blocks do
      if not turtle.up() then
        Blocks=i
        down()
        break
      end
    end

    for i = 1, Blocks do
      turtle.placeUp()
      if i ~= Blocks then
        if not turtle.down() then return false end
      end
    end
    return true
end
  
local function placeDown(Blocks) --[[Turtle places Blocks in a strait line downwards, and returns to starting point.
27/08/2021  Returns:  true.
                      false if turtle was blocked, on the way back.
            sintax: placeDown([Blocks=1])
            ex: placeDown(1) or placeDown() - Places 1 Block Down.]]
  Blocks = Blocks or 1
  
  for i = 2, Blocks do
    if not turtle.down() then
      Blocks=i
      up()
      break
    end
  end

  for i = 1, Blocks do
    turtle.placeDown()
    if i ~= Blocks then
      if not turtle.up() then return false end
    end
  end
  return true
end
  
local function placeLeft(Blocks) --[[Turtle places Blocks in a strait line to the left, and returns to starting point.
27/08/2021  Returns:  true.
                      false if turtle was blocked, on the way back.
            sintax: placeLeft([Blocks=1])
            ex: placeLeft(1) or placeLeft() - Places one Block in front of turtle.]]
    turtle.turnLeft()
    return place(Blocks)
end
  
local function placeRight(Blocks) --[[Turtle places Blocks in a strait line to the right, and returns to starting point.
27/08/2021  Returns:  true.
                      false if turtle was blocked, on the way back.
            sintax: placeRight([Blocks=1])
            ex: placeRight(1) or placeLeft() - Places 1 Block on the right.]]
    turtle.turnRight()
    return place(Blocks)
end
  
local function placeAbove(Blocks) --[[Places Blocks in a strait line, 1 block above the turtle, and returns to starting point.
27/08/2021  Returns:  true.
                      false if turtle was blocked, on the way back, or couldn't place block.
            sintax: placeAbove([Blocks=1])
            ex: placeAbove(1) or placeAbove() - Places one Block above turtle.]]
    Blocks = Blocks or 1
    
    for i = 2, Blocks do --goto last pos to place
      if i == 2 then
        if not turtle.up() then
          Blocks=1
          break
        end
      elseif not turtle.forward() then
        Blocks = i-1
        break
      end
    end
    
    for i = 1, Blocks do --place backwards
      if i == Blocks then
        if i ~= 1 then
          if not turtle.down() then return false end
        end
        if not turtle.placeUp() then return false end
      else
        turtle.place()
        if (i ~= (Blocks-1)) then
          if not turtle.back() then return false end
        end
      end
    end
    return true
end

local function placeBelow(Blocks) --[[Places Blocks in a strait line, 1 block below the turtle, and returns to starting point.
27/08/2021  Returns:  true.
                      false if turtle was blocked, on the way back, or couldn't place block.
            sintax: placeBelow([Blocks=1])
            ex: placeBelow(1) or placeBelow() - Places one Block below turtle.]]
  Blocks = Blocks or 1
  
  for i = 2, Blocks do
    if i == 2 then
      if not turtle.down() then
        Blocks=1
        break
      end
    elseif not turtle.forward() then
      Blocks = i-1
      break
    end
  end
  
  for i = 1, Blocks do
    if i == Blocks then
      if i ~= 1 then
        if not turtle.up() then return false end
      end
      if not turtle.placeDown() then return false end
    else
      turtle.place()
      if (i ~= (Blocks-1)) then
        if not turtle.back() then return false end
      end
    end
  end
  return true
end


------ DROP FUNCTIONS ------  

--drop([Blocks="all"]) drops all blocks from selected slot, or in inventory ex: drop(197), drops 197 brocks of the same type from inventory.
local function drop(Blocks) --[[Drops Blocks in a inventory or in the world in front of turtle.
27/08/2021  Returns:  true.
                      false.
            sintax: drop([Blocks="all"])
            ex: drop("all") or placeBelow(198) - Drops all blocks, or 197 like the one on selected slot.]]
  Blocks = Blocks or "all"
  
end

--dropUp([Blocks="all"]) drops all blocks from selected slot to inventory above, or in inventory ex: drop(197), drops 197 brocks of the same type from inventory.
local function dropUp(Blocks) --[[Drops Blocks in a inventory or in the world upwards.
27/08/2021  Returns:  true.
                      false.
            sintax: dropUp([Blocks="all"])
            ex: dropUp("all") or dropUp(198) - Drops all blocks, or 197 like the one on selected slot, upwards.]]
  Blocks = Blocks or "all"
  
end

--dropDown([Blocks="all"]) drops all blocks from selected slot to inventory below, or in inventory ex: drop(205), drops 205 brocks of the same type from inventory.
local function dropDown(Blocks) --[[Drops Blocks in a inventory or in the world downwards.
27/08/2021  Returns:  true.
                      false.
            sintax: dropDown([Blocks="all"])
            ex: dropDown("all") or dropDown(198) - Drops all blocks, or 197 like the one on selected slot, downwards.]]
  Blocks = Blocks or "all"
  
end
