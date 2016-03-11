HashMap<Long, Star> starMap;

void SetupStarMap() {
  starMap = new HashMap<Long, Star>();
}

HashMap<Long, Cursor> cursorMap;

void SetupCursorMap() {
  cursorMap = new HashMap<Long, Cursor>();
}


HashMap<Integer, StarType> idToType;

void SetupIdToType() {
  idToType = new HashMap<Integer, StarType>();

  idToType.put(0, StarType.YELLOW);
  idToType.put(1, StarType.RED_DWARF);


  
}

