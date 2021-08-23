local function forward(Blocks)
  Blocks = Blocks or 1
  
  for i=1, Blocks do
    if not turtle.forward() then return false end
  end
  return true
end
