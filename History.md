# Version 0.1.0
  - forward(nBlocks) - Moves nBlocks forward or backwards, if nBlocks < 0, until blocked.
  - back(nBlocks) - Moves nBlocks back or forward, if nBlocks < 0, until blocked.
  - up(nBlocks) - Moves nBlocks up or down, if nBlocks < 0, until blocked.
  - down(nBlocks) - Moves nBlocks down or up, if nBlocks < 0, until blocked.
  
  - turnDir(sDir) - Turtle turns to sDir direction {"back", "right", "left"}.
  - turnBack() - Turtle turns back.
  
  - sDir {"forward", "right", "back", "left", "up", "down"}
  - goDir(sDir, nBlocks) - Turtle goes in sDir direction, or the other way if nBlocks < 0, until blocked.
  - goLeft(nBlocks) - Turns left or  right if nBlocks <0, and advances nBlocks until blocked.
  - goRight(nBlocks) - Turns right or left if nBlocks < 0, and advances nBlocks until blocked.
  - goBack(nBlocks) - Turns back or not if nBlocks < 0, and advances nBlocks until blocked.
  
  - digDir(sDir, nBlocks) - Turtle digs in sDir direction or the other way if nBlocks < 0, must have a tool equiped.
  - dig(nBlocks) - Turtle digs nBlocks forward or turns back if nBlocks < 0, and digs nBlocks, must have a tool equiped.
  - digLeft(nBlocks) - Turtle digs nBlocks to the left or right if nBlocks < 0, must have a tool equiped.
  - digRight(nBlocks) - Turtle digs nBlocks to the right or left if nBlocks <0, must have a tool equiped.
  - digUp(nBlocks) - Turtle digs nBlocks upwards or downwards if nBlocks < 0, must have a tool equiped.
  - digDown(nBlocks) - Turtle digs nBlocks downwards or upwards if nBlocks < 0, must have a tool equiped.
  - digAbove(nBlocks) - Digs nBlocks forwards or backwards if nBlocks < 0, 1 block above the turtle, must have a tool equiped.
  - digBelow(nBlocks) - Digs nBlocks forwards or backwards if nBlocks < 0, 1 block below the turtle, must have a tool equiped.
  - digBack(nBlocks) - Turns back or not if nBlocks < 0, and digs Blocks forward, must have a tool equiped.

  - detectDir(sDir) - Detects if is a block in sDir.
  - detectAbove(nBlocks) - Detects nBlocks forwards or backwards if nBlocks < 0, 1 block above the turtle.
  - detectBelow(nBlocks) - Detects nBlocks forwards or backwards if nBlocks < 0, 1 block below the turtle.

  - inspectDir(sDir) - Inspect a block in sDir direction.

  - placeDir(sDir) - Places one selected block in sDir.
  - place(nBlocks) - Turtle places nBlocks in a strait line forward or backwards if nBlocks < 0, and returns to starting point.
  - placeUp(nBlocks) - Places nBlocks upwards or downwards if nBlocks < 0, and returns to starting point.
  - placeDown(nBlocks) - Places nBlocks downwards or upwards if nBlocks < 0, and returns to starting point.
  - placeLeft(nBlocks) - Places Blocks to the left or right if nBlocks < 0, and returns to starting point.
  - placeRight(nBlocks) - Places Blocks to the right or left if nBlocks < 0, and returns to starting point.
  - placeAbove(nBlocks) - Places nBlocks forwards or backwards if nBlocks < 0, in a strait line, 1 block above the turtle, and returns to starting point.
  - placeBelow(nBlocks) - Places nBlocks forwards or backwards if nBlocks < 0, in a strait line, 1 block below the turtle, and returns to starting point.

  - suckDir(sDir, nItems) - Sucks nItems from sDir direction.
  
  - dropDir(sDir, nBlocks) - Drops or sucks if nBlocks <0, between selected slot to inventory or the world in front, up or down the turtle.
  - drop(nBlocks) - Drops or sucks if nBlocks < 0, in front of the turtle.
  - dropUp(nBlocks) - Drops or sucks if nBlocks < 0, upwards.
  - dropDown(nBlocks) - Drops or sucks if nBlocks <0, downwards.
  - dropLeft(nBlocks) - Rotate left and drops or sucks if nBlocks < 0, forward.
  - dropRight(nBlocks) - Rotate right and drops or sucks if nBlocks < 0, forward.
  - dropBack(nBlocks) - Rotate back and drops or sucks if nBlocks < 0, forward.
  
  - itemCount(nSlot) - Counts items in inventory.
  - itemName(nSlot) - Gets the item name from Slot/selected slot.
  - search(sItemName, nStartSlot) - Search inventory for ItemName, starting at startSlot. 
  - itemSelect(itemName) - Selects slot [1..16] or first item with Item Name, or the turtle selected slot.

  - compareAbove(nBlocks) - Compares nBlocks above the turtle in a strait line with selected slot block.
  - compareBelow(nBlocks) - Compares nBlocks below the turtle in a strait line with selected slot block.

  - attackDir(sDir) - Turtle attack in sDir direction.

  - checkType(sType, ...) - Checks if parameters are from sType.
  - getParam(sParamOrder, tDefault, ...) - Sorts parameters by type.
  - tableInTable(tSearch, t) - Verifies if tSearch is in table t.
  - sign(value) - Returns: -1 if value < 0, 0 if value == 0, 1 if value > 0
