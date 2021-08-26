local function forward(Blocks)
  Blocks = Blocks or 1
  
  for i = 1, Blocks do
    if not turtle.forward() then return false end
  end
  return true
end

local function back(Blocks)
  Blocks = Blocks or 1
  
  for i = 1, Blocks do
    if not turtle.back() then return false end
  end
  return true
end

local function up(Blocks)
  Blocks = Blocks or 1
  
  for i = 1, Blocks do
    if not turtle.up() then return false end
  end
  return true
end

local function down(Blocks)
  Blocks = Blocks or 1
  
  for i = 1, Blocks do
      if not turtle.down() then return false end
  end
  return true
end

--getParam(sParamOrder, ...) returns parameters ordered by type (string, number), 1st parameter nil if no parameters.
local function getParam(sParamOrder, ...)
  if not sParam then return nil end
  
  Args={...}
  retParam = {}
  
  function addParam(sType) --adds parameter to returning table
    for i = 1, #Args do
      if type(Args[i]) == sType then
        table.insert(retParam, Args[i])
        table.remove(Args, i)
        return
      end
    end
  end
  
  for i = 1, #sParamOrder do --checks parameter type to order, and request to add
    if sParamOrder[i] == "s" then addParam("string")
    elseif sParamOrder[i] == "n" then addParam("number")
    end
  end
  
  retStr = "" --build string to return from return parameters table
  for i = 1, #retParam do
      retStr = retStr .. retParam[i]
      if i ~= #retParam then retStr = retStr .. ","
  end
    
  return load("return ".. retStr)
end
  
--go([sDir="forward", [Blocks=1]) the turtle advances in sDir direction { "forward", "right", "back", "left", "up", "down" }.
local function go(sDir, Blocks)
  sDir, Blocks = getParam("sn", sDir, Blocks)
  sDir = sDir or "forward"
  Blocks = Blocks or 1
    
  if sDir == "forward" then return forward(Blocks)
  elseif sDir == "right" then return goRight(Blocks)
  elseif sDir == "back" then return goBack(Blocks)
  elseif sDir == "left" then return goLeft(Blocks)
  elseif sDir == "up" then return up(Blocks)
  elseif sDir == "down" then return down(Blocks)
  end
  return false
end

local function goLeft(Blocks)
  Blocks = Blocks or 1
  
  turtle.turnLeft()
  for i = 1, Blocks do
    if not turtle.forward() then return false end
  end
  return true
end

local function goRight(Blocks)
  Blocks = Blocks or 1
  
  turtle.turnRight()
  for i= 1, Blocks do
    if not turtle.forward() then return false end
  end
  return true
end

local function turnBack()
  turtle.turnRight()
  turtle.turnRight()
end

local function goBack(Blocks)
  Blocks = Blocks or 1
  
  turnBack()
  for i = 1, Blocks do
    if not turtle.forward() then return false end
  end
  turnBack()
  return true
end

local function turn(sDir)
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

--place([Blocks=1]) places inventory selected Blocks in a strait line forward.
local function place(Blocks)
  Blocks = Blocks or 1
  sPlaceDir = "forward"
  sMoveDir = "forward"
  
  for i = 1, Blocks do
    if turtle.detect() then return false end --there is a block already
    if i == Blocks then
      return placeDir(sPlaceDir)
    else
      if not go(sMoveDir, 2) then
        back()
        return turtle.place()
      else turn()
      end
      
    end
  end
  return true
end  
  
--placeDir(sDir) places inventory selected Block in sDir direction { "forward", "right", "back", "left", "up", "down" }.
local function placeDir(sDir)
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

--placeUp([Blocks=1]) places inventory selected Blocks in a strait line upward.
local function placeUp(Blocks)
    Blocks = Blocks or 1
    
    --go to last position to place block
      --if it stopped before get there back 1
    if not up(Blocks-1) then down() end
      
    --1:place block
      --if this not the last block back 1 goto 1
    for i = Blocks, 1, -1 do
      if not turtle.placeUp() then return false end
      if not turtle.down() then return false end
    end
    return true
end
  
--placeDown([Blocks=1]) places inventory selected Blocks in a strait line downward.
local function placeDown(Blocks)
    Blocks = Blocks or 1
    
    --go to last position to place block
      --if it stopped before get there back 1
    if not down(Blocks-1) then up() end
      
    --1:place block
      --if this not the last block back 1 goto 1
    for i = Blocks, 1, -1 do
      if not turtle.placeDown() then return false end
      if not turtle.up() then return false end
    end
    return true
end
  
--placeLeft([Blocks=1]) rotates turtle left, places inventory selected Blocks in a strait line forward.
local function placeLeft(Blocks)
    Blocks = Blocks or 1
    
    turtle.turnLeft()
    return place(Blocks)
end
  
--placeRight([Blocks=1]) rotates turtle Right, places inventory selected Blocks in a strait line forward.
local function placeRight(Blocks)
    Blocks = Blocks or 1
    
    turtle.turnRight()
    return place(Blocks)
end
  
--placeAbove([Blocks=1]) places inventory selected Blocks in a strait line 1 block above the turtle and forward.
local function placeAbove(Blocks)
    Blocks = Blocks or 1
    
    for i = 2, Blocks do --goto last pos to place
      if i == 2 then
        if not turtle.up() return false end
      elseif not turtle.forward() then
        Blocks = i
        break end
      end
    end
    
    for i = 1, Blocks do --place backwards
      if i == Blocks then
        if not turtle.down() then return false end
        if not turtle.placeUp() then return false end
      else
        if not turtle.place() then return false end
        if (i ~= (Blocks-1)) then
          if not turtle.back() then return false end
        end
      end
    end
end
--placeBelow([Blocks=1]) places inventory selected Blocks in a strait line 1 block below the turtle and forward.
