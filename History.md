# Version 0.1.0
  forward(nBlocks) - Moves nBlocks forward or backwards, if nBlocks < 0, until blocked.
  back(nBlocks) - Moves nBlocks back or forward, if nBlocks < 0, until blocked.
  up(nBlocks) - Moves nBlocks up or down, if nBlocks < 0, until blocked.
  down(nBlocks) - Moves nBlocks down or up, if nBlocks < 0, until blocked.
  
  turnDir(sDir) - Turtle turns to sDir direction {"back", "right", "left"}.
  turnBack() - Turtle turns back.
  
  sDir {"forward", "right", "back", "left", "up", "down"}
  goDir(sDir, nBlocks) - Turtle goes in sDir direction, or the other way if nBlocks < 0, until blocked.
  goLeft(nBlocks) - Turns left or  right if nBlocks <0, and advances nBlocks until blocked.
  goRight(nBlocks) - Turns right or left if nBlocks < 0, and advances nBlocks until blocked.
  goBack(nBlocks) - Turns back or not if nBlocks < 0, and advances nBlocks until blocked.
  
  digDir(sDir, nBlocks) - Turtle digs in sDir direction or the other way if nBlocks < 0, must have a tool equiped.
  dig(nBlocks) - Turtle digs nBlocks forward or turns back if nBlocks < 0, and digs nBlocks, must have a tool equiped.
  digLeft(nBlocks) - Turtle digs nBlocks to the left or right if nBlocks < 0, must have a tool equiped.
  digRight(nBlocks) - Turtle digs nBlocks to the right or left if nBlocks <0, must have a tool equiped.
  digUp(nBlocks) - Turtle digs nBlocks upwards or downwards if nBlocks < 0, must have a tool equiped.
  digDown(nBlocks) - Turtle digs nBlocks downwards or upwards if nBlocks < 0, must have a tool equiped.
  digAbove(nBlocks) - Digs nBlocks forwards or backwards if nBlocks < 0, 1 block above the turtle, must have a tool equiped.
  digBelow(nBlocks) - Digs nBlocks forwards or backwards if nBlocks < 0, 1 block below the turtle, must have a tool equiped.
  digBack(nBlocks) - Turns back or not if nBlocks < 0, and digs Blocks forward, must have a tool equiped.
