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
  
    down([Blocks=1]) Moves the turtle down blocks, until it hits something.
    up([Blocks=1]) Moves the turtle up blocks, until it hits something.
    back([Blocks=1]) Moves the turtle backwards blocks, until it hits something.
    forward([Blocks=1]) Moves the turtle forward blocks, until it hits something.
  
  Rotations and Moving:
  
    go([sDir="forward", [Blocks=1]) Turtle advances in sDir { "forward", "right", "back", "left", "up", "down" } until blocked.
    goBack([Blocks=1]) Rotates turtle back, and moves blocks forward, until it hits something.
    goRight([Blocks=1]) Rotates turtle to the right, and moves blocks forward, until it hits something.
    goLeft([Blocks=1]) Rotates turtle to the left, and moves blocks forward, until it hits something.

  Dig:
  
    dig([Blocks=1]) Dig Blocks forward with tool.
    digUp([Blocks=1]) Dig Blocks upwards.
    digDown([Blocks=1]) Dig Blocks downwards.
    digRight([Blocks=1]) Rotates turtle Right and dig Blocks forward.
    digLeft([Blocks=1]) Rotates turtle left and dig Blocks forward.
    digAbove([Blocks=1]) Dig Blocks, 1 block above the turtle, and forward.
    digBelow([Blocks=1]) Dig Blocks, 1 block below the turtle, and forward.
    digBack([Blocks=1]) Rotates turtle back and dig Blocks.

  Drop:

    dropDir(sDir, nBlocks) Drops nBlocks from selected slot and inventory in the world in front, up or down the turtle.
    drop(nBlocks) Drops nBlocks from selected slot and inventory in the world in front of the turtle.
    dropUp(nBlocks) Drops nBlocks from selected slot and inventory in the world upwards.
    dropDown(nBlocks) Drops nBlocks from selected slot and inventory in the world downwards.

  Place:

    placeDir([sDir="forward"]) Places inventory selected Block in sDir { "forward", "right", "back", "left", "up", "down" }.
    place([Blocks=1]) Places inventory selected Blocks in a strait line forward, and returns to initial position.
    placeUp([Blocks=1]) Places inventory selected Blocks in a strait line upward, and returns to initial position.
    placeDown([Blocks=1]) Places inventory selected Blocks in a strait line downward, and returns to initial position.
    placeLeft([Blocks=1]) Rotates turtle left, places inventory selected Blocks forward, and returns to initial position.
    placeRight([Blocks=1]) Rotates turtle Right, places inventory selected Blocks forward, and returns to initial position.
    placeAbove([Blocks=1]) Places selected slot Blocks, 1 block above the turtle, and returns to initial position.
    placeBelow([Blocks=1]) Places selected slot Blocks, 1 block below the turtle, and returns to initial position.

  Inventory:

    select(value) Select slot value or select slot with itemName = value. 
    invSearch(sItemName, nStartSlot) Search inventory for ItemName, starting at startSlot. 
