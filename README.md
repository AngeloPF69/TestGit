# TestGit
Repository to teste Git.

Avilable functions:

  General:

    getParam(sParamOrder, tDefault, ...) Sorts parameters by type, ex: getParam("sns", {"forward", 1}, 10, "left") output: left, 10, forward.
    isInTable(value, t) Verifies if value is in table t, value can be a table too.
    sign(value) Returns: -1 if value < 0, 0 if value == 0, 1 if value > 0

  Rotations:
  
    turnBack() The turtle turns back.
    turn([Direction="back"]) Rotates turtle back, left or right.
    
  Moving:
  
    down([Blocks=1]) Moves the turtle down or up blocks, until it hits something.
    up([Blocks=1]) Moves the turtle up or down blocks, until it hits something.
    back([Blocks=1]) Moves the turtle backwards or upwards blocks, until blocked.
    forward([Blocks=1]) Moves the turtle forward or backwards blocks, until blocked.
  
  Rotations and Moving:
  
    go([sDir="forward", [Blocks=1]) Turtle advances blocks, in sDir { "forward", "right", "back", "left", "up", "down" } until blocked.
    goBack([Blocks=1]) Rotates turtle back or not, and moves blocks forward, until it hits something.
    goRight([Blocks=1]) Rotates turtle to the right or left, and moves blocks forward, until it hits something.
    goLeft([Blocks=1]) Rotates turtle to the left or right, and moves blocks forward, until it hits something.

  Dig:
  
    dig([Blocks=1]) Dig Blocks forward or backwards with equiped tool.
    digUp([Blocks=1]) Dig Blocks upwards or downwards with equiped tool.
    digDown([Blocks=1]) Dig Blocks downwards or upwards with equiped tool.
    digRight([Blocks=1]) Rotates turtle Right or left, and dig Blocks forward with equiped tool.
    digLeft([Blocks=1]) Rotates turtle left or right, and dig Blocks forward with equiped tool.
    digAbove([Blocks=1]) Dig Blocks forward or backwards, 1 block above the turtle, with equiped tool.
    digBelow([Blocks=1]) Dig Blocks forward or backwards, 1 block below the turtle, with equiped tool.
    digBack([Blocks=1]) Rotates turtle back or not, and dig Blocks forward.

  Drop:

    dropDir(sDir, [Blocks=stack]) Drops Blocks from selected slot and inventory in the world in front, up or down the turtle.
    drop([Blocks=stack]) Drops Blocks from selected slot and inventory in the world in front of the turtle.
    dropUp([Blocks=stack]) Drops Blocks from selected slot and inventory in the world upwards.
    dropDown([Blocks=stack]) Drops nBlocks from selected slot and inventory in the world downwards.

  Place:

    placeDir([sDir="forward"]) Places inventory selected Block in sDir { "forward", "right", "back", "left", "up", "down" }.
    place([Blocks=1]) Places inventory selected Blocks in a strait line forward or backwards, and returns to initial position.
    placeUp([Blocks=1]) Places inventory selected Blocks in a strait line upward or downwards, and returns to initial position.
    placeDown([Blocks=1]) Places inventory selected Blocks in a strait line downward or upwards, and returns to initial position.
    placeLeft([Blocks=1]) Rotates turtle left or right, places inventory selected Blocks forward, and returns to initial position.
    placeRight([Blocks=1]) Rotates turtle Right or left, places inventory selected Blocks forward, and returns to initial position.
    placeAbove([Blocks=1]) places Blocks forwards or backwards, 1 block above the turtle, and returns to initial position.
    placeBelow([Blocks=1]) Places selected Blocks forwards or backwards, 1 block below the turtle, and returns to initial position.

  Inventory:

    itemCount(nSlot) Counts items in inventory.
    itemSelect(value) Select slot value or select slot with itemName = value. 
    Search(sItemName, nStartSlot) Search inventory for ItemName, starting at startSlot. 
    
