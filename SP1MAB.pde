//defining variables. The 3 variables are made first since i know i would use them in my system.
int target1;
int target2;
int guess;
int timer = 6000;
int timerSTARTVALUE = timer;
String guess_str = "";
boolean easyMode = false;
boolean gameState2 = false;
boolean gameWin = false;

// arguments for the random numbers
int x = 10;
int y = 100;

//void setup because i know im gonna use draw and keypressed.
void setup() {
  size(600, 600);
  if (easyMode) {
    target1 = (int)random(x, y);
  } else if (!easyMode) {
    target1 = (int)random(x, y+100);
  }
}

//here i made sure i had a window that would show the number im typing. This is further developed using keypressed at the end and showing win/lose screen.
void draw() {
  background (255);
  if (gameState2) background (0, 255, 0, 50);
  if (timer <= timerSTARTVALUE/2) background (220, 0, 0, 5);
  fill(0);
  textSize(100);
  text(guess_str, 200, 200);
  textSize(30);
  if (easyMode)
    text(("Guess a number between "+ x+ " and " +y), 50, 500);
  if (!easyMode) {
    timer = timer - 2;
    textSize(100);
    text(timer, 500, 500);
    textSize(30);
    text(("Guess a number between "+ x+ " and " +(y+100)), 50, 400);
    if (timer <= timerSTARTVALUE/2) {
      text("hurry up, no time left!", 150, 550);
    }
    if (timer <= 0) {
      background(255);
      textSize(100);
      text("You lost", 150, 300);
    }
  }
  if (gameWin) {
    background(255);
    textSize(30);
    text("CONGRATZ! You won... Surprisngly..", 60, 300);
  }
}

//this is how keypressed is used and i basically programmed ENTER to initiate a guess and check if my guess is correct or relative to the answer.
//I could have simplified it using functions - but i chose to keep it the way it is

void keyPressed() {
  if (!gameState2) {
    if (keyCode == ENTER) {
      if (int(guess_str) > target1) {
        println("lower than that");
      } else if (int(guess_str) < target1) {
        println("higher than that");
      } else if (target1 == int(guess_str)) {
        if (easyMode)
        println("yay you won! Now try hardmode by settings easyMode to false!");
        if (!easyMode) {
          gameState2 = true;
          target2 = (int)random(200, 300);
          text("Now guess a number between 200 and 300...", 150, 100);
        }
      }
      guess = int(guess_str);
      println("you guessed: "+guess);
      guess_str = "";
    } else if (keyCode != BACKSPACE) {
      guess_str += key;
      println(guess_str);
    }
  } else {
    if (keyCode == ENTER) {
      if (int(guess_str) > target2) {
        println("lower than that");
      } else if (int(guess_str) < target2) {
        println("higher than that");
      } else if (target2 == int(guess_str)) {
        text("Yoooo, this guy/gal just beat the game on hardmode!", 100, 100);
        gameWin = true;
      }
      guess = int(guess_str);
      println("you guessed: "+guess);
      guess_str = "";
    } else if (keyCode != BACKSPACE) {
      guess_str += key;
      println(guess_str);
    }
  }
  if (key == BACKSPACE) {
    if (guess_str.length() != 0)
      guess_str = guess_str.replace(guess_str.charAt(guess_str.length()-1), ' ').replaceAll(" ", "");
  }
}
