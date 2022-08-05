print(textutils.serialize(peripheral.getNames()))
print(peripheral.getType("right"))
print(peripheral.isPresent("left"))
print(textutils.serialise(peripheral.getMethods(peripheral.getNames()[1])))
