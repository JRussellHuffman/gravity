import TUIO.*;
import java.util.*; 
import java.util.concurrent.*;

TuioProcessing tuioClient;
boolean verbose = false;

AbstractQueue<TuioActionWrapper> actionQueue = new ConcurrentLinkedQueue<TuioActionWrapper>();
AbstractQueue<CursorActionWrapper> cursorQueue = new ConcurrentLinkedQueue<CursorActionWrapper>();

class TuioActionWrapper {
  TuioAction action;
  TuioObject tObject;

  TuioActionWrapper(TuioObject tObj, TuioAction act) {
    action = act;
    tObject = tObj;
  }
}

class CursorActionWrapper {
  TuioAction action;
  TuioCursor tCursor;

  CursorActionWrapper(TuioCursor tCurs, TuioAction act) {
    action = act;
    tCursor = tCurs;
  }
}

// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  if (verbose) println("add obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
  actionQueue.offer(new TuioActionWrapper(tobj, TuioAction.ADD));

  //Star son = new Star(tobj);
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  if (verbose) println("set obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
    +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
  actionQueue.offer(new TuioActionWrapper(tobj, TuioAction.UPDATE));
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  if (verbose) println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
  actionQueue.offer(new TuioActionWrapper(tobj, TuioAction.REMOVE));
}

// --------------------------------------------------------------
// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  if (verbose) println("add cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
  //redraw();
  cursorQueue.offer(new CursorActionWrapper(tcur, TuioAction.ADD));
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  if (verbose) println("set cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
    +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
  //redraw();
  cursorQueue.offer(new CursorActionWrapper(tcur, TuioAction.UPDATE));
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  if (verbose) println("del cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
  //redraw()
  cursorQueue.offer(new CursorActionWrapper(tcur, TuioAction.REMOVE));
}

// --------------------------------------------------------------
// called when a blob is added to the scene
void addTuioBlob(TuioBlob tblb) {
  if (verbose) println("add blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea());
  //redraw();
}

// called when a blob is moved
void updateTuioBlob (TuioBlob tblb) {
  if (verbose) println("set blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea()
    +" "+tblb.getMotionSpeed()+" "+tblb.getRotationSpeed()+" "+tblb.getMotionAccel()+" "+tblb.getRotationAccel());
  //redraw()
}

// called when a blob is removed from the scene
void removeTuioBlob(TuioBlob tblb) {
  if (verbose) println("del blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+")");
  //redraw()
}

// --------------------------------------------------------------
// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {
  if (verbose) println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
//<<<<<<< Updated upstream
//=======
  //if (callback) redraw();
//>>>>>>> Stashed changes
}

void TuioUpdate() {

  while (actionQueue.peek () != null) {
    TuioActionWrapper wrap = actionQueue.poll();
    TuioObject curObj = wrap.tObject;
    switch(wrap.action) {
    case ADD :
      Star newStar = new Star(curObj);      
      break;

    case REMOVE :

      Star remStar = starMap.get(curObj.getSessionID());
      if (remStar != null) {
        //remStar.Die();
      }
      break;

    case UPDATE :
      Star upBlock = starMap.get(curObj.getSessionID());
      if (upBlock!=null) {
        upBlock.UpdateFromTuio(curObj);
      }
      break;
    }
  }


  while (cursorQueue.peek () != null) {
    CursorActionWrapper wrap = cursorQueue.poll();
    TuioCursor tCur = wrap.tCursor;
    switch(wrap.action) {
    case ADD :
    Cursor newCursor = new Cursor(tCur);
      break;

    case REMOVE :
    Cursor remCursor = cursorMap.get(tCur.getSessionID());
      if (remCursor!=null) {
        remCursor.OnRemove();
      }
      break;

    case UPDATE :
      Cursor upCursor = cursorMap.get(tCur.getSessionID());
      if (upCursor!=null) {
        upCursor.UpdateFromTuio(tCur);
      }
      break;
    }
  }
}
