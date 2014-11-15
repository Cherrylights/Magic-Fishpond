class Lotus {

  float posx;
  float posy;
  float posx1 = random(1.7*width/3, 2.9*width/3);
  float posy1 = random(1.7*height/3, 2.9*height/3);
  int an = int(random(1, PI));
  float theta = 0;
  float r = random(70,90);
  color c;
  
  void colorChoose() {   
  int colorDice = (int) random (4);

    if (colorDice == 0) c = color(222, 79, 129, 200);
    else if (colorDice == 1) c = color(0, 150, 255, 200);
    else if (colorDice == 2) c = color(109, 88, 167, 200);
    else c = color(249, 133, 136, 200);
  }


  void display() {
    noStroke();
    posx = noise(theta)*10+ posx1;
    posy = noise(theta)*10 + posy1;
    fill(c);  
    arc( posx, posy, r, r, PI/2+an, PI*2+1+an);
    theta += random(0.005, 0.03);
  }
}
