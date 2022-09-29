//My code is messy, since i made this a while back and didnt want to rewrite what i spent so much time on.
//below i have defined some variable i use. Most are selfexplainatory; i have two targets because this game has a hardmode where you have to guess TWO numbers within a limited period of time
//You can turn on hardmode by simply turning Bool easyMode to false. There is also a timer i set to 6000 == 60 sec.
int target1;
int target2;
int guess;
int timer = 6000;
int timerSTARTVALUE = timer;
String guess_str = "";
boolean easyMode = true;
boolean gameState2 = false;
boolean gameWin = false;

// arguments for the random numbers. I made these variables, so you can quickly change the values of both easy and hardmode, without having to manually go into each target variable.
int x = 10;
int y = 100;

//void setup because i know im gonna use draw and keypressed.
//easymode picks a number between x(10 and y(100).
//hardmode adds 100 more possible numbers. Try and beat that C:<
void setup() {
  size(600, 600);
  if (easyMode) {
    target1 = (int)random(x, y);
  } else if (!easyMode) {
    target1 = (int)random(x, y+100);
  }
}

//here i made sure i had a window that would show the number im typing. This is further developed using keypressed at the end and showing win/lose screen.
//There isnt much to explain here, the code is fairly obvious in my opinion.
//It is extremely messy, i know - but i wanted to keep it this way because it shows me how much better i am at organizing compared to when i made this project.
void draw() {
  background (255);
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
    text("CONGRATZ! You won... Surprisingly..", 60, 300);
  }
}

//this is how keypressed is used and i basically programmed ENTER to initiate a guess and check if my guess is correct or relative to the answer.
//I could have simplified it using functions - but i chose to keep it the way it is, because trying to lead to the whole thing breaking...
//We have conditions telling us how if we are too high/low compared to targetnumber.
//if easymode is on, you win by guessing target 1- and if it is off, it iniates stage2 and creates target2 which is harder to guess.

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
          println("Now guess a number between 200 and 300...");
        }
      }
      guess = int(guess_str);
      println("you guessed: "+guess);
      guess_str = "";
    } else if (keyCode != BACKSPACE) {
      guess_str += key;
      println(guess_str);
    }
  }

  //below is the same code as above, but made specifically for target2 on hardmode.

  else {
    if (keyCode == ENTER) {
      if (int(guess_str) > target2) {
        println("lower than that");
      } else if (int(guess_str) < target2) {
        println("higher than that");
      } else if (target2 == int(guess_str)) {
        println("Yoooo, this guy/gal just beat the game on hardmode!");
        gameWin = true;
      }
      guess = int(guess_str);
      println("you guessed: "+guess);
      guess_str = "";
    }

    // The below code is needed, since backspace kept initiating a square symbol, and so i had to exclude it from the guess_str.

    else if (keyCode != BACKSPACE) {
      guess_str += key;
      println(guess_str);
    }
  }

  //the below code is what i used to code a backspace, so you can delete a number incase you wrote wrong.
  //Quite handy and i used built-in functions and what i learned about .length to make it

  if (key == BACKSPACE) {
    if (guess_str.length() != 0)
      guess_str = guess_str.replace(guess_str.charAt(guess_str.length()-1), ' ').replaceAll(" ", "");
  }
}
