import geomerative.*;
import ddf.minim.*;
import com.onformative.leap.*;
import com.leapmotion.leap.*;
import com.leapmotion.leap.Gesture.State;
import com.leapmotion.leap.Gesture.Type;
import com.leapmotion.leap.Hand;
import com.leapmotion.leap.SwipeGesture;
import com.leapmotion.leap.CircleGesture;
import com.onformative.leap.LeapMotionP5;
//import processing.serial.*;


RFont myFont;
RGroup myGroup;
RPoint[] myPoints;
String myText = "PEACE | LOVE";

//Serial myPort;
LeapMotionP5 leap;

PFont f;
PImage cover;

Minim minim;
AudioSnippet water;
AudioSnippet waterdrop;
AudioSnippet fish1;
AudioSnippet lacita;

ArrayList <Mover> bouncers;
Lotus[]lotus;

int mode = 0;
float mag;
//float stirValue;
//float tiltValueX;
//float tiltValueY;
int transparency = 255;
boolean music = false;

void setup () {
  size (displayWidth, displayHeight, P2D);
  noCursor();
  bouncers = new ArrayList ();
  //  myPort = new Serial(this, Serial.list()[5], 9600);
  //  myPort.bufferUntil('\n');

  RG.init(this);
  myFont = new RFont("FreeSans.ttf", 150, CENTER);
  RCommand.setSegmentLength(15);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);

  leap = new LeapMotionP5(this);
  leap.enableGesture(Type.TYPE_CIRCLE);
  leap.enableGesture(Type.TYPE_SWIPE);

  minim = new Minim(this);
  water = minim.loadSnippet("water.wav");
  waterdrop = minim.loadSnippet("waterdrop.wav");
  fish1 = minim.loadSnippet("fish1.mp3");
  lacita = minim.loadSnippet("lacita.mp3");
  water.loop();

  cover = loadImage("cover.png");

  lotus = new Lotus[5];
  for (int i = 0; i<lotus.length; i++) {
    lotus[i] = new Lotus();
    lotus[i].colorChoose();
  }    
  mag = 1;

  f = createFont("Helvetica", 15, true);

  frameRate (30);
}

void draw () {
  background (0);

  myGroup = myFont.toGroup(myText);
  myPoints = myGroup.getPoints();

  textFont(f);
  fill(255);
  text("Mode: " + mode, 80, 50);

  image(cover, 0, 0);
  tint(255, transparency);

  if (keyPressed && key == '8') {
    Mover newMover = new Mover ();
    bouncers.add (newMover);
    if (!fish1.isPlaying()) {
      fish1.rewind();
      fish1.play();
    }
  }

  if (keyPressed && key == '9') {
    for (int i = 0; i < bouncers.size (); i++) {
      bouncers.remove(i);
    }
  }

  //  String inString = myPort.readStringUntil('\n');
  //  if (inString != null) {
  //    inString = trim(inString);
  //    float[] values = float(split(inString, ","));
  //    if (values.length >=3) {
  //      stirValue = values[2];
  //    }
  //  }

  //  println("stirValue: " + stirValue);
  //  if (stirValue > 954.0) { 
  //    Mover newMover = new Mover ();
  //    bouncers.add (newMover); 
  //    if (!fish1.isPlaying()) {
  //      fish1.rewind();
  //      fish1.play();
  //    }
  //  }

  //  if (stirValue < 600.0) {
  //    for (int i =0; i<bouncers.size (); i++) {
  //      bouncers.remove(i);
  //    }
  //  }

  if (keyPressed && key == '1') {
    bouncers.clear();
  }

  if ( key == ENTER) {
    for (int i=0; i<myPoints.length; i++) {
      Mover newMover = new Mover();
      bouncers.add (newMover);
    }
    translate(width/2, height/2);
    for (int i =0; i<myPoints.length; i++) {
      Mover m = bouncers.get (i);
      m.update (mode, new PVector(myPoints[i].x, myPoints[i].y));
    }
    mode = 2;
    music = true;
  }
  if (music) {
    lacita.play();
  }

  if (mode == 1 || mode == 0) {
    for (int i = 0; i < bouncers.size (); i++) {
      Mover m = bouncers.get (i);
      m.update (mode, new PVector(myPoints[i].x, myPoints[i].y));
    }
    music = false;
  }

  for ( int i =0; i< lotus.length; i++) {
    lotus[i].display();
  }
}

void swipeGestureRecognized(SwipeGesture gesture) {
  if (gesture.state() == State.STATE_STOP) {
    System.out.println("//////////////////////////////////////");
    System.out.println("Gesture type: " + gesture.type());
    System.out.println("Duration: " + gesture.durationSeconds() + "s");
    if (!waterdrop.isPlaying()) {
      waterdrop.rewind();
      waterdrop.play();
    }
    System.out.println("//////////////////////////////////////");
    if (mode ==0) {
      mode = 1;
    } else if (mode == 1) {
      mode = 0;
    }
    println(mode);
  } else if (gesture.state() == State.STATE_START) {
  } else if (gesture.state() == State.STATE_UPDATE) {
  }
} 

void circleGestureRecognized(CircleGesture gesture, String clockwiseness) {
  if (gesture.state() == State.STATE_STOP) {

    System.out.println("//////////////////////////////////////");
    System.out.println("Gesture type: " + gesture.type().toString());
    System.out.println("Clockwiseness: " + clockwiseness);
    System.out.println("Duration: " + gesture.durationSeconds() + "s");
    System.out.println("//////////////////////////////////////");
  } else if (gesture.state() == State.STATE_START) {
    transparency = 0;
  } else if (gesture.state() == State.STATE_UPDATE) {
    if (clockwiseness == "clockwise") {
      mag+=0.03;
      mag = constrain(mag, -3, 6);
    } else if (clockwiseness == "counterclockwise") {
      mag-=0.03;
      mag = constrain(mag, -3, 6);
    }
  }
}

void keyPressed() {
  if (bouncers.isEmpty()) {
    println("true");
  }
  if (myText == "") {
    println("empty");
  }
  if (myText.length() < 30 && key =='A'|| key =='a'||key =='B'||key =='b'||key =='C'||
  key =='c'||key =='D'||key =='d'||key =='E'||key =='e'||key =='F'||key =='f'||key =='G'||
  key =='g'||key =='H'||key =='h'||key =='I'||key =='i'||key =='J'||key =='j'||key =='K'||
  key =='k'||key =='L'||key =='l'||key =='M'||key =='m'||key =='N'||key =='n'||key =='O'||
  key =='o'||key =='P'||key =='p'||key =='Q'||key =='q'||key =='R'||key =='r'||key =='S'||
  key =='s'||key =='T'||key =='t'||key =='U'||key =='u'||key =='V'||key =='v'||key =='W'||
  key =='w'||key =='X'||key =='x'||key =='Y'||key =='y'||key =='Z'||key =='z'||key ==' ') {
    if (key == ' ') {
      myText+=" ";
    } else {
      myText+=key;
    }
  }
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    myText="";
  }
}
void mouseReleased() {
  if (mouseButton == LEFT) {
    mode = 0;
  }
}
