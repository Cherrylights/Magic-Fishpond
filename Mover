class Mover {

  PVector direction;

  float speed;
  float SPEED;

  float noiseScale;
  float noiseStrength;
  float forceStrength;

  Fish f;

  Mover () {
    setRandomValues();
  }

  // SET ---------------------------

  void setRandomValues () {
    f = new Fish (width/2, height/2);
    f.ellipseSize = random (4, 15);

    float angle = random (TWO_PI);
    direction = new PVector (cos (angle), sin (angle));

    speed = random (4, 7);
    SPEED = speed;
    noiseScale = 80;
    noiseStrength = 1;
    forceStrength = random (0.1, 0.2);
  }


  // HOW TO MOVE ----------------------------

  void seek (float x, float y, float strength) {
    PVector location = f.getHead();

    float angle = atan2 (y-location.y, x -location.x);

    PVector force = new PVector (cos (angle), sin (angle));
    force.mult (forceStrength * strength);

    direction.add (force);
    direction.normalize();
  }

  void typo (float x, float y) {
    PVector location = f.getHead();

    float angle = atan2 (y-location.y, x -location.x);

    PVector force = new PVector (cos (angle), sin (angle));
    force.mult (0.7);

    direction.add (force);
    direction.normalize();
  }

  void addRadial () {
    PVector location = f.getHead();

    float m = noise (frameCount / (2*noiseScale));
    m = map (m, 0, 1, - 1.2, 1.2);

    float maxDistance = m * dist (0, 0, width/2, height/2);
    float distance = dist (location.x, location.y, width/2, height/2);

    float angle = map (distance, 0, maxDistance, 0, TWO_PI);

    PVector force = new PVector (cos (angle), sin (angle));
    force.mult (forceStrength);
    //    String inString = myPort.readStringUntil('\n');
    //
    //    if (inString != null) {
    //
    //      inString = trim(inString);
    //      float[] values = float(split(inString, ","));
    //      if (values.length >=2) {
    //        tiltValueX = values[0];
    //        tiltValueY = values[1];
    //      }
    //    }
    //    println("tiltX: " + tiltValueX);
    //    println("tiltY: " + tiltValueY);

    //    if (tiltValueY < -0.5) {
    //      PVector lift = new PVector(-50, 0);
    //      force = PVector.add(force, lift);
    //    }
    //    if (tiltValueX > 3.1) {
    //      PVector lift = new PVector(0, -50);
    //      force = PVector.add(force, lift);
    //    }
    //    if (tiltValueX < 1.8) {
    //      PVector lift = new PVector(0, 50);
    //      force = PVector.add(force, lift);
    //    }
    //    if (tiltValueY > 0.5) {
    //      PVector lift = new PVector(50, 0);
    //      force = PVector.add(force, lift);
    //    }
    //    if (tiltValueX > 3.1 && tiltValueY < -0.5) {
    //      PVector lift = new PVector(-50, -50);
    //      force = PVector.add(force, lift);
    //    }
    //    if (tiltValueX < 1.8 && tiltValueY < -0.5) {
    //      PVector lift = new PVector(-50, 50);
    //      force = PVector.add(force, lift);
    //    }
    //    if (tiltValueX > 3.1 && tiltValueY > 0.5) {
    //      PVector lift = new PVector(50, -50);
    //      force = PVector.add(force, lift);
    //    }
    //    if (tiltValueX < 1.8 && tiltValueY > 0.5) {
    //      PVector lift = new PVector(50, 50);
    //      force = PVector.add(force, lift);
    //    }
    direction.add (force);
    direction.normalize();
  }



  // MOVE -----------------------------------------

  void move () {
    PVector location = f.getHead();

    PVector velocity = direction.get();
    velocity.mult (speed);
    location.add (velocity);

    f.setHead (location);
  }

  // CHECKEDGES --------------------------------------------------------

  void checkEdges () {
    PVector location = f.getTail();
    float diameter = f.getSize();

    if (location.x < -diameter / 2) {
      location.x = width+diameter /2;
      f.setHead (location);
    } else if (location.x > width+diameter /2) {
      location.x = -diameter /2;
      f.setHead (location);
    }

    if (location.y < -diameter /2) {
      location.y = height+diameter /2;
      f.setHead (location);
    } else if (location.y > height+diameter /2) {
      location.y = -diameter /2;
      f.setHead (location);
    }
  }

  // UPDATE --------------------------------

  void update (int mode, PVector f) {

    if (mode == 0) {
      speed = SPEED * 0.7;
      addRadial ();
      move();
      checkEdges();
    } else if (mode == 1) { 
      for (Hand hand : leap.getHandList ()) {
        PVector handPosition = leap.getPosition(hand);
        speed = SPEED * 0.7;
        seek (handPosition.x, handPosition.y, 1);
        move();
      }
    } else if (mode == 2) {
      typo(f.x, f.y);
      move();
    }
    display();
  }

  // DISPLAY ---------------------------------------------------------------

  void display () {
    f.display();
  }
}
