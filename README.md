# TestGit
computercraft turtle lua improved commands.

Avilable functions:

  Equip:
  
    getFreeHand() Gets turtle free hand: "left"|"right"|false.
    equip(Side) Equip tool in the selected slot.
    
  General:

    isKey(Key, t) Checks if Key is in t table.
    checkType(sType, ...) Checks if parameters are from sType.
    getParam(sParamOrder, tDefault, ...) Sorts parameters by type.
    tableInTable(tSearch, t) Verifies if tSearch is in table t.
    sign(value) Returns: -1 if value < 0, 0 if value == 0, 1 if value > 0

  Attack:

    attackLeft([Side]) rotate left and attack the entity in front.
    attackRight([Side]) rotate right and attack the entity in front.
    attackBack([Side]) rotate back and attack the entity in front.
    attackDir([sDir="forward"]) turtle attack in sDir direction {"forward", "right", "back", "left", "up", "down"}

  Rotations:
  
    turnBack() the turtle turns back.
    turn([Direction="back"]) rotates turtle back, left or right.
    
  Moving:
  
    down([Blocks=1]) moves the turtle down or up blocks.
    up([Blocks=1]) moves the turtle up or down blocks.
    back([Blocks=1]) moves the turtle backwards or forward blocks.
    forward([Blocks=1]) moves the turtle forward or backwards blocks.
  
  Rotations and Moving:
  
    go([sDir="forward", [Blocks=1]) turtle advances blocks, in sDir { "forward", "right", "back", "left", "up", "down" }.
    goBack([Blocks=1]) rotates turtle back or not, and moves blocks forward.
    goRight([Blocks=1]) rotates turtle to the right or left, and moves blocks forward.
    goLeft([Blocks=1]) rotates turtle to the left or right, and moves blocks forward.

  Dig:
  
    dig([Blocks=1]) dig Blocks forward or backwards with equiped tool.
    digUp([Blocks=1]) dig Blocks upwards or downwards with equiped tool.
    digDown([Blocks=1]) dig Blocks downwards or upwards with equiped tool.
    digRight([Blocks=1]) rotates turtle Right or left, and dig Blocks forward with equiped tool.
    digLeft([Blocks=1]) rotates turtle left or right, and dig Blocks forward with equiped tool.
    digAbove([Blocks=1]) dig Blocks forward or backwards, 1 block above the turtle, with equiped tool.
    digBelow([Blocks=1]) dig Blocks forward or backwards, 1 block below the turtle, with equiped tool.
    digBack([Blocks=1]) rotates turtle back or not, and dig Blocks forward.

  Drop:

    dropDir(sDir, [Blocks=stack]) Drops Blocks from selected slot and inventory in the world in front, up or down the turtle.
    drop([Blocks=stack]) Drops Blocks from selected slot and inventory in the world in front of the turtle.
    dropUp([Blocks=stack]) Drops Blocks from selected slot and inventory in the world upwards.
    dropDown([Blocks=stack]) Drops nBlocks from selected slot and inventory in the world downwards.
    dropLeft([nBlocks=stack]) Rotate left and drops or sucks nBlocks forward.
    dropRight([nBlocks=stack]) Rotate right and drops or sucks nBlocks forward.
    dropBack([nBlocks=stack]) Rotate back and drops or sucks nBlocks forward.

  Place:

    placeDir([sDir="forward"]) places inventory selected Block in sDir { "forward", "right", "back", "left", "up", "down" }.
    place([Blocks=1]) places inventory selected Blocks in a strait line forward or backwards, and returns to initial position.
    placeUp([Blocks=1]) places inventory selected Blocks in a strait line upward or downwards, and returns to initial position.
    placeDown([Blocks=1]) places inventory selected Blocks in a strait line downward or upwards, and returns to initial position.
    placeLeft([Blocks=1]) rotates turtle left or right, places inventory selected Blocks forward, and returns to initial position.
    placeRight([Blocks=1]) rotates turtle Right or left, places inventory selected Blocks forward, and returns to initial position.
    placeAbove([Blocks=1]) places Blocks forwards or backwards, 1 block above the turtle, and returns to initial position.
    placeBelow([Blocks=1]) Places selected Blocks forwards or backwards, 1 block below the turtle, and returns to initial position.

  Detect:

    detectDir(sDir) detects if is a block in sDir direction {"forward", "right", "back", "left", "up", "down" }.
    detectAbove([Blocks=1]) detects if exits Blocks above the turtle in a strait line forward or backwards.
    detectBelow([Blocks=1]) detects if exits Blocks below the turtle in a strait line forward or backwards.

  Inspect:

    inspectLeft() rotate left and inspect block in front of turtle.
    inspectRight() rotate right and inspect block in front of turtle.
    inspectBack() rotate back and inspect block in front of turtle.
    inspectDir([sDir="forward]) turtle inspect block in sDir direction {"forward", "right", "back", "left", "up", "down"}.

  Compare:

    compareDir([sDir="forward"][, nSlot=selected slot]) Compares item in slot with block in sDir direction.
    compareAbove([Blocks=1]) compare blocks above the turtle in a strait line with selected slot.
    compareBelow([Blocks=1]) compare blocks below the turtle in a strait line with selected slot.

  Inventory:

    itemCount([selected slot/slot/"inventory"/item name=Selected slot]) counts items in slot, inventory.
    itemName([Slot=Selected slot]) Gets the item name from Slot.
    itemSelect([Slot/Item Name]) selects slot [1..16] or first item with Item Name, or the turtle selected slot.
    search(sItemName, nStartSlot) search inventory for ItemName, starting at startSlot. 
    
