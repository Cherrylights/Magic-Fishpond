class Fish {
  PVector [] location;
  float ellipseSize;

  color c1;
  color c2;

  Fish (float x, float y) {
    setRandomColor ();

    location = new PVector [round (random (8, 15))];
    location[0] = new PVector (x, y);

    for (int i = 1; i < location.length; i++) {
      location[i] = location[0].get ();
    }
    ellipseSize = random (8, 30);
  }

  // GET ------------------------------

  float getSize () {
    return ellipseSize;
  }

  PVector getHead () {
    return location [location.length-1].get();
  }

  PVector getTail () {
    return location [0].get();
  }

  // SET ---------------------

  void setColor (color C1, color C2) {
    c1 = C1;
    c2 = C2;
  }

  void setRandomColor () {
    int colorDice = (int) random (4);

    if (colorDice == 0) c1 = color(222, 79, 129, 100);
    else if (colorDice == 1) c1 = color(0, 150, 255, 100);
    else if (colorDice == 2) c1 = color(109, 88, 167, 100);
    else c1 = color(249, 133, 136, 100);

    float dice = random (100);
    if (dice < 25) {
      colorDice = (int) random (4);

      if (colorDice == 0) c2 = #ffedbc;
      else if (colorDice == 1) c2 = #A75265;
      else if (colorDice == 2) c2 = #ec7263;
      else c2 = #0096FF;
    } else c2 = c1;
  }

  void setHead (PVector pos) {
    location [location.length-1]= pos.get();

    updateBody ();
  }

  // HELPERS ---------------

  void updateBody () {
    for (int i = 0; i < location.length-1; i++)
    {
      location [i] = location [i+1];
    }
  }

  // DISPLAY --------------------

  void display () {
    noStroke();
    for (int i = 0; i < location.length; i++) {
      color c = lerpColor (c1, c2, map (i, 0, location.length, 1, 0 ) );
      float s = map (i, 0, location.length, 1, ellipseSize  );
      fill(c);
      ellipse (location[i].x, location [i].y, s+mag, s+mag);
    }
  }
}
