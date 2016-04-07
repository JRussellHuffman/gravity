HashMap<Long, Star> starMap; // What is this?

void SetupStarMap() {
  starMap = new HashMap<Long, Star>();
}

HashMap<Long, Cursor> cursorMap;

void SetupCursorMap() {
  cursorMap = new HashMap<Long, Cursor>();
}


HashMap<Integer, StarType> idToType; // This matches integers to star types

void SetupIdToType() {
  idToType = new HashMap<Integer, StarType>();

  idToType.put(49, StarType.YELLOW);
  idToType.put(33, StarType.RED_DWARF);
  idToType.put(20, StarType.BLUE);
  
}