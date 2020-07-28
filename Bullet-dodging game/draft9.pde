import java.util.List;
import java.util.ArrayList; 
import java.util.Iterator;

// images
PImage heart1;
PImage heart2;
PImage bullet1;
PImage bullet2;
PImage background;
PImage green1;
PImage green2;
PImage red;
PImage blue1;
PImage blue2;
PImage player1;
PImage player2;
PImage obstacle;

Player player;
Life_Icon life;
Bullet_Icon bul;
List<Bullet> my_bullets = new ArrayList<Bullet>();
List<Bullet> bullets = new ArrayList<Bullet>();
List<Enemy> enemies = new ArrayList<Enemy>();

int MAX_HP = 6;            // total hit points
int hp = 6;                // remaining hit points
int MAX_BULLET = 60;       // total bullets
int bullet_num = 60;       // remaining bullets
int score = 0;             // current score
int high_score = 0;        // highest score
int enemies_destroyed = 0; // number of enemies killed
int hit = 0;               // number of bullets that hit the target
int total = 0;             // total number of bullets fired
int time = 0;              // time elapsed
int last_time = 0;         // time when the last enemy appears
int state = 0;             // state: 0--before game; 1-- during game; 2--after game
boolean pause = false;     // whether the game is paused

// ****** definition of all the classes ******
class Player {
  int size = 150;          // size of the player
  float xpos = width / 2;  // horizontal position of the player
  float ypos = height / 2; // vertical position of the player

  // update the player's position
  void update() {
    if (keyPressed) {
      if (keyCode == LEFT) {
        xpos -= 10;  // go leftward
      } else if (keyCode == RIGHT) {
        xpos += 10;  //go rightward
      } else if (keyCode == UP) {
        ypos -= 10;  // go upward
      } else if (keyCode == DOWN) {
        ypos += 10;  // go downward
      }
    }
    // keep the player from moving outside the screen
    xpos = constrain(xpos, 50, width - 50);
    ypos = constrain(ypos, 50, height - 50);
    // keep the player from moving into the obstacle
    if (ypos > 710 - size / 3 && ypos < 890 + size / 3) {
      if (xpos < width / 2) {
        xpos = constrain(xpos, 50, 500 - size / 3);  // keep the player from moving rightward
      } else {
        xpos = constrain(xpos, 700 + size / 3, width - 50);  // keep the player from moving leftward
      }
    }
    if (xpos > 500 - size / 3 && xpos < 700 + size / 3) {
      if (ypos < 850) {
        ypos = constrain(ypos, 50, 700 - size / 3);  // keep the player from moving downward
      } else {
        ypos = constrain(ypos, 900 + size / 3, height - 50);  // keep the player from moving upward
      }
    }
  }

  // show the player on the screen
  void show() {
    // temporarily set the player's position as the origin so that we can perform rotate()
    pushMatrix();
    translate(xpos, ypos);
    float angle = 0;  // orientation of the player
    if (keyCode == LEFT) {
      angle = - PI / 2;
    } else if (keyCode == RIGHT) {
      angle = PI / 2;
    } else if (keyCode == DOWN) {
      angle = PI;
    }
    rotate(angle);
    image(player1, - size / 2, - size / 2, size, size);
    rotate(- angle + calculate_angle(xpos, ypos, mouseX, mouseY));  // orientation of the turret above the hull of the tank
    image(player2, -30, -90, 60, 120);
    popMatrix();
  }

  void shoot() {
    if (bullet_num > 0) {
      float angle = calculate_angle_(xpos, ypos, mouseX, mouseY);  // direction of the bullet
      float turret_length = 80;  // length of the turret
      my_bullets.add(new My_Bullet(xpos + turret_length * sin(angle), ypos + turret_length * cos(angle)));  // initial position of the bullet
      bullet_num --;  //decrement of number of bullet left
    }
  }
}

abstract class Bullet {
  int size, speed, damage;
  float xpos, ypos, xspeed, yspeed;
  
  // return true if the bullet hits the obstacle
  boolean check_obstacle() {
    if (xpos > 500 - size / 2 && xpos < 700 + size / 2 && ypos > 700 - size / 2 && ypos < 900 + size / 2) {
      return true; 
    }
    return false;
  }

  // decrement hp and return true if the bullet hits the player
  boolean check_collision() {
    if (dist(xpos, ypos, player.xpos, player.ypos) < player.size / 2) {
      hp -= damage;
      return true;
    }
    return false;
  }
  
  abstract boolean update();  // update the position of the bullet
  abstract void show();  // draw the bullet on the screen
}

// player's bullet
class My_Bullet extends Bullet {
  My_Bullet(float xpos, float ypos) {
    size = 12;  // size of the bullet
    speed = 10;  // total velocity of the bullet
    damage = 1;  // damage of the bullet
    this.xpos = xpos;  // horizontal position of the bullet
    this.ypos = ypos;  // vertical position of the bullet
    // calculate the horizontal and vertical speed of the bullet
    float x_dist = mouseX - player.xpos;
    float y_dist = mouseY - player.ypos;
    xspeed = speed * x_dist / dist(player.xpos, player.ypos, mouseX, mouseY);
    yspeed = speed * y_dist / dist(player.xpos, player.ypos, mouseX, mouseY);
  }

  // update the position of the bullet
  boolean update() {
    xpos += xspeed;
    ypos += yspeed;
    // return true if the bullet hits the boundary
    if (xpos < - size / 2 || xpos > width + size / 2 || ypos < - size / 2 || ypos > height + size / 2) {
      return true;
    }
    return false;
  }

  // draw the bullet on the screen
  void show() {
    fill(0);
    circle(xpos, ypos, size);
  }

  // check if the player's bullet has hit any enemy
  boolean check_hit() {
    // traverse the enemy array
    Iterator itr = enemies.iterator();
    while (itr.hasNext()) {
      Enemy e = (Enemy)itr.next();
      // if the bullet touches an enemy, decrement its hp, increment the number of bullets that hit the target
      if (dist(xpos, ypos, e.xpos, e.ypos) < (size + e.size) / 2) {
        e.hp --;
        hit ++;
        // if the enemy's hp is reduced to zero, remove it from the array, increment the score and the number of enemies destroyed
        if (e.hp == 0) {
          if (e.max_hp == 5) {
            score += 500;
          } else if (e.max_hp == 4) {
            score += 750;
          } else {
            score += 1000;
          }
          itr.remove();
          enemies_destroyed ++;
        }
        return true;  // return true so that the bullet will be removed from the bullet array
      }
    }
    return false;
  }
}

// green bullet with no special effect and little damage
class Green_Bullet extends Bullet {
  Green_Bullet(float xpos, float ypos) {
    size = 12;  // size of the bullet
    speed = 6;  // total velocity of the bullet
    damage = 1;  // damage of the bullet
    this.xpos = xpos;  // horizontal position of the bullet
    this.ypos = ypos;  // vertical position of the bullet
    // calculate the horizontal and vertical speed of the bullet
    float x_dist = player.xpos - xpos;
    float y_dist = player.ypos - ypos;
    xspeed = speed * x_dist / dist(xpos, ypos, player.xpos, player.ypos);
    yspeed = speed * y_dist / dist(xpos, ypos, player.xpos, player.ypos);
  }

  // update the position of the bullet
  boolean update() {
    xpos += xspeed;
    ypos += yspeed;
    // return true if the bullet hits the boundary
    if (xpos < - size / 2 || xpos > width + size / 2 || ypos < - size / 2 || ypos > height + size / 2) {
      return true;
    }
    return false;
  }
  
  // draw the bullet on the screen
  void show() {
    fill(0, 200, 0);
    stroke(50);
    strokeWeight(5);
    circle(xpos, ypos, size);
    noStroke();
  }
}

// bouncing bullet
class Red_Bullet extends Bullet {
  boolean bounced = false;  // whether the bullet has touched any wall once
  Red_Bullet(float xpos, float ypos) {
    size = 24;  // size of the bullet
    speed = 8;  // total velocity of the bullet
    damage = 2;  // damage of the bullet
    this.xpos = xpos;  // horizontal position of the bullet
    this.ypos = ypos;  // vertical position of the bullet
    // calculate the horizontal and vertical speed of the bullet
    float x_dist = player.xpos - xpos;
    float y_dist = player.ypos - ypos;
    xspeed = speed * x_dist / dist(xpos, ypos, player.xpos, player.ypos);
    yspeed = speed * y_dist / dist(xpos, ypos, player.xpos, player.ypos);
  }

  // update the position of the bullet
  boolean update() {
    xpos += xspeed;
    ypos += yspeed;
    // if the bullet hits the boundary or the obstacle
    if (xpos <= size / 2 || xpos >= width - size / 2 ||  // left & right boundary
    (ypos > 700 - size / 2 && ypos < 900 + size / 2 && (abs(xpos - 500) < size / 2 || abs(xpos - 700) < size / 2))) {  // left & right wall of the obstacle
      if (bounced == false) {  // if the bullet hasn't bounced, reverse the horizontal velocity and mark it as bounced
        bounced = true;
        xspeed = - xspeed;
        xpos += 2.5 * xspeed;
      } else {
        return true;  // return true if the bullet has bounced once and hit the boundary again
      }
    } else if (ypos <= size / 2 || ypos >= height - size / 2 ||  // upper & lower boundary
    (xpos > 500 - size / 2 && xpos < 700 + size / 2 && (abs(ypos - 700) < size / 2 || abs(ypos - 900) < size / 2))) {  // upper & lower wall of the obstacle
      if (bounced == false) {  // if the bullet hasn't bounced, reverse the vertical velocity and mark it as bounced
        bounced = true;
        yspeed = - yspeed;
        ypos += 2.5 * yspeed;
      } else {
        return true;  // return true if the bullet has bounced once and hit the boundary again
      }
    }
    return false;
  }
  
  // draw the bullet on the screen
  void show() {
    stroke(0);
    strokeWeight(1);
    fill(220, 50, 50);
    circle(xpos, ypos, size);
    noStroke();
  }
}

// homing bullet
class Blue_Bullet extends Bullet {
  int remaining_time = 300;  // the remaining time before the bullet disappears
  List<Path> path = new ArrayList<Path>();  // the trajectory of the bullet
  Blue_Bullet(float xpos, float ypos) {
    size = 25;  // size of the bullet
    speed = 4;  // total velocity of the bullet
    damage = 2;  // damage of the bullet
    this.xpos = xpos;  // horizontal position of the bullet
    this.ypos = ypos;  // vertical position of the bullet
  }

  boolean update() {
    remaining_time --;  // decrement the remaining time
    // return true if the time reduces to zero so that the bullet will be removed from the bullet array
    if (remaining_time == 0) {
      return true;
    } else if (remaining_time > 75) {
      // update the horizontal and vertical speed of the bullet
      float x_dist = player.xpos - xpos;
      float y_dist = player.ypos - ypos;
      xspeed = speed * x_dist / dist(xpos, ypos, player.xpos, player.ypos);
      yspeed = speed * y_dist / dist(xpos, ypos, player.xpos, player.ypos);
    }
    xpos += xspeed;
    ypos += yspeed;
    // update the trajectory of the bullet
    path.add(new Path(xpos, ypos));
    update_path();
    // return true if the bullet hits the boundary (seems impossible)
    if (xpos < - size / 2 || xpos > width + size / 2 || ypos < - size / 2 || ypos > height + size / 2) {
      return true;
    }
    return false;
  }

  // draw the bullet on the screen
  void show() {
    fill(50, 50, 255);
    stroke(0);
    strokeWeight(5);
    circle(xpos, ypos, size);
    noStroke();
  }
  
  // update the trajectory of the bullet
  void update_path() {
    Iterator itr = path.iterator();
    while (itr.hasNext()) {
      Path p = (Path)itr.next();
      p.update();
      p.show();
      // remove the object if it has become transparent
      if (p.alpha == 0) {
          itr.remove();
      }
    }
  }
}

// the trajectory of the homing bullet
class Path {
  float xpos, ypos;
  int size = 25, alpha = 255;
  Path(float xpos, float ypos) {
    this.xpos = xpos;
    this.ypos = ypos;
  }
  
  // the path will gradually become transparent
  void update() {
    alpha -= 12;
  }
  
  void show() {
    fill(0, 0, 200, alpha);
    stroke(50, 50, 150, alpha);
    strokeWeight(5);
    circle(xpos, ypos, size);
    noStroke();
  }
}

abstract class Enemy {
  int size, speed, max_hp, hp, appear_time = time;
  float xpos, ypos;
  
  // draw the hp bar above the enemy
  void show_hp() {
    fill(255);
    stroke(0);
    strokeWeight(2);
    rect(xpos - 60, ypos - 100, 120, 10);  // total hit points
    noStroke();
    fill(255, 0, 0);
    rect(xpos - 59, ypos - 99, 119 * hp / max_hp, 8); // remaining hit points
  }
  
  // keep the enemy from moving into the obstacle
  void constrain_position() {
    if (ypos > 710 - size / 2 && ypos < 890 + size / 2) {
      if (xpos < width / 2) {
        xpos = constrain(xpos, 50, 500 - size / 2);  // keep the player from moving rightward
      } else {
        xpos = constrain(xpos, 700 + size / 2, width - 50);  // keep the player from moving leftward
      }
    }
    if (xpos > 500 - size / 2 && xpos < 700 + size / 2) {
      if (ypos < 850) {
        ypos = constrain(ypos, 50, 700 - size / 2);  // keep the player from moving downward
      } else {
        ypos = constrain(ypos, 900 + size / 2, height - 50);  // keep the player from moving upward
      }
    }
  }
  
  abstract void update();  // update the position of the bullet
  abstract void show();    // draw the enemy on the screen
  abstract void shoot();   // fire a bullet
}

// fast enemy moving around the arena
class Green_Enemy extends Enemy {
  int dist = 200;  // margin between its path and the boundary of the arena
  int pos = 3;  // position of the enemy: 0--right; 1--bottom; 2--left; 3--top
  Green_Enemy() {
    size = 120;  // size of the enemy
    speed = 5;   // velocity of the enemy
    max_hp = 5;  // total hit points
    hp = 5;      // current hit points
    xpos = width + size / 2;  // horizontal position of the enemy
    ypos = dist;              // vertical position of the enemy
  }

  // the enemy moves in counterclockwise direction, starting from the upper right
  void update() {
    if (pos == 3) {         // top
      xpos -= speed;        // move leftward
      if (xpos <= dist) {
        pos = 2;            // turn left at the upper left corner
      }
    } else if (pos == 2) {  // left
      ypos += speed;        // move downward
      if (ypos >= height - dist) {
        pos = 1;            // turn left at the lower left corner
      }
    } else if (pos == 1) {  // bottom
      xpos += speed;        // move rightward
      if (xpos >= width - dist) {
        pos = 0;            // turn left at the lower right corner
      }
    } else {                // right
      ypos -= speed;        // move upward
      if (ypos <= dist) {
        pos = 3;            // turn left at the upper right corner
      }
    }

    if ((time - appear_time) % 30 == 0) {
      shoot();  // fire a bullet 
    }
  }

  // draw the enemy on the screen
  void show() {
    // temporarily set the enemy's position as the origin so that we can perform rotate()
    pushMatrix();
    translate(xpos - 60 + size / 2, ypos - 60 + size / 2);
    rotate(pos * PI / 2);  // the orientation of the bottom part
    image(green1, - size / 2, - size / 2, size, size);
    rotate(- pos * PI / 2 + calculate_angle(xpos, ypos, player.xpos, player.ypos));  // the orientation of the turret
    image(green2, -25, -80, 50, 100);
    popMatrix();
    show_hp();
  }

  // fire a bullet
  void shoot() {
    float angle = calculate_angle_(xpos, ypos, player.xpos, player.ypos);  // direction of the bullet
    float turret_length = 80;  // length of the turret
    bullets.add(new Green_Bullet(xpos + turret_length * sin(angle), ypos + turret_length * cos(angle)));  // initial position of the bullet
  }
}

// enemy that follows the player and shoots bouncing bullets
class Red_Enemy extends Enemy {
  float xspeed, yspeed;  // directional velocities of the enemy
  Red_Enemy() {
    size = 120;  // size of the enemy
    speed = 3;   // total velocity of the enemy
    max_hp = 4;  // total hit points
    hp = 4;      // current hit points
    xpos = random(size / 2, height - size / 2);  // horizontal position of the enemy
    ypos = int(random(2)) * width;               // vertical position of the enemy
  }

  // the enemy follows the player's position
  void update() {
    // update the horizontal and vertical velocities according to the player's position
    float x_dist = player.xpos - xpos;
    float y_dist = player.ypos - ypos;
    xspeed = speed * x_dist / dist(xpos, ypos, player.xpos, player.ypos);
    yspeed = speed * y_dist / dist(xpos, ypos, player.xpos, player.ypos);
    xpos += xspeed;
    ypos += yspeed;
    constrain_position();  // keep the enemy from moving into the obstacle
    
    if ((time - appear_time) % 60 == 0) {
      shoot();  // fire a bullet
    }
  }

  // draw the enemy on the screen
  void show() {
    // temporarily set the enemy's position as the origin so that we can perform rotate()
    pushMatrix();
    translate(xpos - 60 + size / 2, ypos - 60 + size / 2);
    rotate(calculate_angle(xpos, ypos, player.xpos, player.ypos));  // the enemy heads towards the player's current position
    image(red, - size / 2, - size / 2, size, size);
    popMatrix();
    show_hp();
  }

  // fire a bouncing bullet
  void shoot() {
    float angle = calculate_angle_(xpos, ypos, player.xpos, player.ypos);  // direction of the bullet
    float turret_length = 60;  // length of the bullet
    bullets.add(new Red_Bullet(xpos + turret_length * sin(angle), ypos + turret_length * cos(angle)));  // initial position of the bullet
  }
}

// slow enemy that heads towards a fixed position and shoots homing bullets
class Blue_Enemy extends Enemy {
  float xtarget, ytarget, xspeed, yspeed;  // target position and directional velocities of the enemy
  Blue_Enemy() {
    size = 135;  // size of the enemy
    speed = 2;   // total velocity of the enemy
    max_hp = 7;  // total hit points
    hp = 7;      // current hit points
    // randomize the target position in the middle of the field
    xtarget = random(300, 900);
    ytarget = random(300, 900);
    xpos = int(random(2)) * height;            // horizontal position of the enemy
    ypos = random(size / 2, width - size / 2); // vertical position of the enemy
  }

  // the enemy heads towards its target position
  void update() {
    constrain_position();  // keep the enemy from moving into the object
    // update the horizontal and vertical velocities (if it's blocked by the obstacle)
    float x_dist = xtarget - xpos;
    float y_dist = ytarget - ypos;
    xspeed = speed * x_dist / dist(xpos, ypos, xtarget, ytarget);
    yspeed = speed * y_dist / dist(xpos, ypos, xtarget, ytarget);
    // update the position if it hasn't reached the target point
    if (abs(xpos - xtarget) > 1 || abs(ypos - ytarget) > 1) {
      xpos += xspeed;
      ypos += yspeed;
    }

    if ((time - appear_time) % 100 == 0) {
      shoot();  // fire a bullet
    }
  }

  // draw the enemy on the screen
  void show() {
    // temporarily set the enemy's position as the origin so that we can perform rotate()
    pushMatrix();
    translate(xpos - 75 + size / 2, ypos - 60 + size / 2);
    float angle = calculate_angle(xpos, ypos, xtarget, ytarget);  // the orientation of the bottom part
    rotate(angle);
    image(blue1, - size / 2, - size / 2, size, size);
    rotate(- angle + calculate_angle(xpos, ypos, player.xpos, player.ypos));  // the orientation of the turret
    image(blue2, -30, -100, 60, 120);
    popMatrix();
    show_hp();
  }

  // fire a homing bullet
  void shoot() {
    float angle = calculate_angle_(xpos, ypos, player.xpos, player.ypos);  // direction of the bullet
    float turret_length = 100;  // length of the bullet
    bullets.add(new Blue_Bullet(xpos + turret_length * sin(angle), ypos + turret_length * cos(angle)));  // initial position of the bullet
  }
}

// the player restores hitpoints by reaching the life icon
class Life_Icon {
  int size = 60;  // size of the icon
  float xpos = random(size / 2, width - size / 2);  // randomize horizontal position of the icon
  float ypos = random(size / 2, height - size / 2); // randomize vertical position of the icon

  Life_Icon() {
    // make sure the icon won't appear within the obstacle
    while(xpos > 500 && xpos < 700 && ypos > 700 && ypos < 900) {
      xpos = random(size / 2, width - size / 2);
      ypos = random(size / 2, height - size / 2);
    }
  }
  
  // draw the icon
  void show() {
    image(heart2, xpos, ypos, size, size);
  }

  // increment hp and return true if the player has touched the icon
  boolean check_collision() {
    if (dist(xpos, ypos, player.xpos, player.ypos) < (size + player.size) / 2) {
      if (hp < MAX_HP) {
        hp ++;
      }
      return true;  //return true so that the icon will be reinitialized
    }
    return false;
  }
}

// the player collects bullets by reaching the bullet icon
class Bullet_Icon {
  int size = 65;  // size of the icon
  float xpos = random(size / 2, width - size / 2);  // randomize horizontal position of the icon
  float ypos = random(size / 2, height - size / 2); // randomize vertical position of the icon
  
  Bullet_Icon() {
    // make sure the icon won't appear within the obstacle
    while(xpos > 500 && xpos < 700 && ypos > 700 && ypos < 900) {
      xpos = random(size / 2, width - size / 2);
      ypos = random(size / 2, height - size / 2);
    }
  }
  
  // draw the icon
  void show() {
    image(bullet2, xpos, ypos, size, size);
  }

  // increase bullet number and return true if the player has touched the icon
  boolean check_collision() {
    if (dist(xpos, ypos, player.xpos, player.ypos) < (size + player.size) / 2) {
      bullet_num = constrain(bullet_num + 10, 0, MAX_BULLET);
      return true;  //return true so that the icon will be reinitialized
    }
    return false;
  }
}

//****** end of class definitions ******

// calculate the angle between the given vector and (0, -1), where the given vector is pointing from this position to the target position
float calculate_angle(float this_xpos, float this_ypos, float target_xpos, float target_ypos) {
  PVector reference = new PVector(0, -1);
  PVector actual = new PVector(target_xpos - this_xpos, target_ypos - this_ypos);
  if (this_xpos < target_xpos) {
    return PVector.angleBetween(reference, actual);
  } else {
    return -PVector.angleBetween(reference, actual);
  }
}

// calculate the angle between the given vector and (0, +1)
float calculate_angle_(float this_xpos, float this_ypos, float target_xpos, float target_ypos) {
  PVector reference = new PVector(0, 1);
  PVector actual = new PVector(target_xpos - this_xpos, target_ypos - this_ypos);
  if (this_xpos < target_xpos) {
    return PVector.angleBetween(reference, actual);
  } else {
    return -PVector.angleBetween(reference, actual);
  }
}

// show the hit points, bullet number, score, number of enemies destroyed, and accuracy at the top of the screen
void show_status() {
  // dark background at the top-left corner
  noStroke();
  fill(0, 60);
  rect(-50, -50, 320, 200, 50);
  // hit points
  fill(255, 200);
  stroke(0);
  strokeWeight(3);
  rect(80, 28, 145, 27, 5);
  image(heart1, 20, 19, 45, 45);
  fill(255, 0, 0);
  noStroke();
  rect(82, 30, 142 * hp / MAX_HP, 24, 3);
  fill(0);
  strokeWeight(5);
  textSize(24);
  text(hp + " / 6", 125, 50);
  // warning when hp <= 2
  if (hp <= 2) {
    fill(255, 0, 0);
    textSize(45);
    text("!", 240, 57);
  }

  // remaining bullets
  fill(255, 200);
  stroke(0);
  strokeWeight(3);
  rect(80, 83, 145, 27, 5);
  image(bullet1, 15, 70, 55, 55);
  fill(60, 60, 255);
  noStroke();
  rect(82, 85, 142 * bullet_num / MAX_BULLET, 24, 3);
  fill(0);
  strokeWeight(5);
  textSize(24);
  text(bullet_num + " / 60", 110, 105);
  // warning when number <= 20
  if (bullet_num <= 20) {
    fill(0, 0, 255);
    textSize(45);
    text("!", 240, 113);
  }

  // dark background at the top-right corner
  noStroke();
  fill(0, 60);
  rect(850, -50, 400, 270, 50);
  // score
  fill(0);
  textSize(42);
  text("Score: " + score, 900, 70);
  // number of enemies destroyed
  textSize(25);
  text("Enemies Destroyed: " + enemies_destroyed, 900, 125);
  // shot accuracy = hit / total
  int accuracy = 0;
  if (total > 0) {
    accuracy = 100 * hit / total;
  }
  text("Accuracy: " + accuracy + "%", 900, 170);
}

void setup() {
  size(1200, 1200);
  // load images
  heart1 = loadImage("heart1.png");
  heart2 = loadImage("heart2.png");
  bullet1 = loadImage("bullet1.png");
  bullet2 = loadImage("bullet2.png");
  background = loadImage("background.png");
  green1 = loadImage("green1.png");
  green2 = loadImage("green2.png");
  red = loadImage("red.png");
  blue1 = loadImage("blue1.png");
  blue2 = loadImage("blue2.png");
  player1 = loadImage("player1.png");
  player2 = loadImage("player2.png");
  obstacle = loadImage("obstacle.png");
  // initialize objects
  player = new Player();
  life = new Life_Icon();
  bul = new Bullet_Icon();
}

void draw() {
  if (state == 0) {  // before the game starts
    background(background);
    image(obstacle, 500, 700, 200, 200);
    player.show();
    life.show();
    bul.show();
    show_status();
    fill(0);
    textSize(60);
    text("Press SPACE to start/pause", 200, 400);
  } else if (state == 1) {  // during the game
      if (!pause) {  // if the game is not paused
      background(background);
      image(obstacle, 500, 700, 200, 200);
      player.update();
      player.show();
      life.show();
      if (life.check_collision()) {
        life = new Life_Icon();  // reinitialize the icon after it has been collected by the player
      }
      bul.show();
      if (bul.check_collision()) {
        bul = new Bullet_Icon();  // reinitialize the icon after it has been collected by the player
      }
      // create a new enemy after a certain time interval or if all enemies have been destroyed
      boolean next_enemy = false;
      if (enemies.isEmpty()) {
        next_enemy = true;
      }
      if (time  < 3000) {
        if ((time - last_time) % 1000 == 0) {
          next_enemy = true;
        }
      } else {
        if ((time - last_time) % 500 == 0) {
          next_enemy = true;
        }
      }
      // probability: 40% green enemy; 40% red enemy; 20% blue enemy
      if (next_enemy) {
        float rand = random(1);
        if (rand < 0.4) {
          enemies.add(new Green_Enemy());
        } else if (rand < 0.8) {
          enemies.add(new Red_Enemy());
        } else {
          enemies.add(new Blue_Enemy());
        }
        last_time = time;  // record the time when the last enemy was created
      }
      // update and draw all the existing enemies
      Iterator itr = enemies.iterator(); 
      while (itr.hasNext()) {
        Enemy e = (Enemy)itr.next();
        e.update();
        e.show();
      }
      // update and draw all the existing bullets shot by the enemies; remove the bullet that has hit the player, the boundary or the obstacle
      itr = bullets.iterator();
      while (itr.hasNext()) {
        Bullet b = (Bullet)itr.next();
        if (b.update()) {
          itr.remove();
        } else {
          b.show();
          if (b.check_collision() || b.check_obstacle()) {
            itr.remove();
            if (hp <= 0) {
              hp = 0;
              state = 2;  // game over when hp is reduced to zero
            }
          }
        }
      }
      // update, draw and count the bullets shot by the player; remove the bullet that has hit the enemies, the boundary or the obstacle
      itr = my_bullets.iterator();
      while (itr.hasNext()) {
        My_Bullet b = (My_Bullet)itr.next(); 
        if (b.update()) {
          total ++;
          itr.remove();
        } else {
          b.show();
          if (b.check_hit() || b.check_obstacle()) {
            total ++;
            itr.remove();
          }
        }
      }
      show_status();  // show the data at the top of the screen
      if (state == 1) {  // keep incrementing the score and time during the game
        score ++;
        time ++;
      } else {  // if game over
        // update the highest score
        if (score > high_score) {
          high_score = score;
        }
        // dark background at the center of the screen
        noStroke();
        fill(0, 80);
        rect(220, 270, 800, 400, 50);
        // show game over and the highest score
        fill(0);
        textSize(60);
        text("Game Over", 450, 380);
        textSize(40);
        text("High score: " + high_score, 445, 470);
        textSize(60);
        text("Press SPACE to restart", 300, 580);
      }
    } else {  // if the game is paused, stop updating any data
      fill(0);
      textSize(60);
      text("Press SPACE to resume", 270, 400);
    }
  }
}

// the player fires a bullet when the mouse is pressed during the game
void mousePressed() {
  if (state == 1 && ! pause) {
    player.shoot();
  }
}

// the player can start/restart, pause/resume the game by press the spacebar
void keyPressed() {
  if (key == 32) {  // keyCode for spacebar
    if (state == 0) {  // start the game if it hasn't started
      state = 1;
    } else if (state == 2) {  // after game over, reinitialize the variables if the game is to be restarted
      state = 1;
      hp = 6;
      bullet_num = 60;
      score = 0;
      enemies_destroyed = 0;
      hit = 0;
      total = 0;
      time = 0;
      last_time = 0;
      player = new Player();
      life = new Life_Icon();
      bul = new Bullet_Icon();
      my_bullets = new ArrayList<Bullet>();
      bullets = new ArrayList<Bullet>();
      enemies = new ArrayList<Enemy>();
    } else {  //pause or resume the game during the game
      pause = !pause;
    }
  }
}
