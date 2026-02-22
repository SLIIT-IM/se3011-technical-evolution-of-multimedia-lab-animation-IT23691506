// Player
float px = 350, py = 175;
float step = 6;
float pr = 20;

// Orb

float x = 200, y = 100;
float xs = 4, ys = 3;
float r = 15;

// Helper

float hx, hy;
float ease = 0.08;

// Game

boolean trails = false;
int score = 0;

int state = 0; // 0=start, 1=play, 2=end
int startTime;
int duration = 30; // seconds


void setup() {
  size(700, 350);

  hx = px;
  hy = py;
}

void draw() {

  noStroke();
  // traill
  if (!trails) {
    background(245);
  } else {
    noStroke();
    fill(245, 40);
    rect(0, 0, width, height);
  }

  // START screen
  if (state == 0) {

    textAlign(CENTER, CENTER);
    textSize(24);
    fill(0);
    text("Catch the Orb\nPress ENTER to start", width/2, height/2);
  }
  // PLAY screen
  if (state ==1) {

    //Timer
    int elapsed = (millis() - startTime) / 1000;
    int left = duration - elapsed;

    fill(0);
    textSize(16);
    textAlign(LEFT, TOP);
    text("Time: " + left, 20,20);
    text("Score: " + score, 20, 40);

    if (left <= 0) {
      state = 2;
    }
// player control
    if (keyPressed) {
      if (keyCode == RIGHT) px += step;
      if (keyCode == LEFT)  px -= step;
      if (keyCode == DOWN)  py += step;
      if (keyCode == UP)    py -= step;
    }

    px = constrain(px, pr, width - pr);
    py = constrain(py, pr, height - pr);

    // Orb movemennt
    x += xs;
    y += ys;

    if (x > width - r|| x < r) xs *= -1;
    if (y > height - r ||y < r) ys *= -1;

    float d = dist(px, py, x, y);

    if (d < pr + r) {
      score++;

      //increase speed
      xs *= 1.1;
      ys *= 1.1;

      //reset orb
      x = random(r,width - r);
      y = random(r,height - r);
    }

    hx = hx + (px - hx) *ease;
    hy = hy + (py - hy) *ease;

    //orb
    fill(255,120, 80);
    ellipse(x, y, r*2, r*2);

    //player
    fill(60, 120,200);
    ellipse(px, py, pr*2, pr*2);

    //helper
    fill(80, 200, 120);
    ellipse(hx, hy, 16, 16);
  }

  // END screen
  if (state == 2) {

    textAlign(CENTER, CENTER);
    textSize(24);
    fill(0);
    text("Time Over!\nFinal Score: " + score +
         "\nPress R to Restart",
         width/2, height/2);
  }
}
void keyPressed() {

  // Start
  if (state ==0 && keyCode== ENTER) {
    state = 1;
    startTime = millis();
    score = 0;
  }

  // reset
  if (state == 2 && (key == 'r' ||key == 'R')) {
    state = 0;
    score = 0;
    //speed
    xs = 4;
    ys = 3;
  }

  if (key == 't'|| key == 'T') {
    trails = !trails;
  }
}
