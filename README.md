# TestGit
Repository to teste Git.

Avilable functions:

  General:

    getParam(sParamOrder, ...) Sorts parameters by type, ex: getParam("sns", 10, "left", "right") output: left, 10, right.

  Rotations:
  
    turnBack() The turtle turns back.
    turn([Direction="back"]) Rotates turtle back, left or right.
    
  Moving:
  
    down([Blocks=1]) Moves the turtle down blocks, until it hits something.
    up([Blocks=1]) Moves the turtle up blocks, until it hits something.
    back([Blocks=1]) Moves the turtle backwards blocks, until it hits something.
    forward([Blocks=1]) Moves the turtle forward blocks, until it hits something.
    go([sDir="forward", [Blocks=1]) Turtle advances in sDir { "forward", "right", "back", "left", "up", "down" } until blocked.
  
  Rotations and Moving:
  
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

  Place:

    placeDir([sDir="forward"]) Places inventory selected Block in sDir direction { "forward", "right", "back", "left", "up", "down" }.
    place([Blocks=1]) Places inventory selected Blocks in a strait line forward, and returns to initial position.
    placeUp([Blocks=1]) Places inventory selected Blocks in a strait line upward, and returns to initial position.
    placeDown([Blocks=1]) Places inventory selected Blocks in a strait line downward, and returns to initial position.
    placeLeft([Blocks=1]) Rotates turtle left, places inventory selected Blocks in a strait line forward, and returns to initial position.
    placeRight([Blocks=1]) Rotates turtle Right, places inventory selected Blocks in a strait line forward, and returns to initial position.
    placeAbove([Blocks=1]) Places inventory selected Blocks in a strait line 1 block above the turtle and forward, and returns to initial position.
    placeBelow([Blocks=1]) Places inventory selected Blocks in a strait line 1 block below the turtle and forward, and returns to initial position.
