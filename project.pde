import controlP5.*; //<>// //<>// //<>// //<>//

ControlP5 cp5;
int numberButtonWidth = 50;
int numberButtonHeight = 40;

int startTime;
int elapsedTime;
int cookTime = 7000;
String timeWhileEntering = "";

Boolean isIntitiated = false; // indiactes whether the first button click is time cook or something like that
Boolean isInprogress = false; // indicates whether microwave is running (heating)
ArrayList<Integer> timeEntered = new ArrayList<Integer>(); 

void setup()
{
  background(#CDCDD6);
  size(700, 700); // canvas size
  cp5 = new ControlP5(this);
  textSize(32);
  addButonsToScreen(cp5);
}

void draw() {
  fill(30);
  rect(60,30, 315, 270,10); // room for full microwave
  fill(250);
  rect(60, 30, 315, 270, 10); // room for microwave

  if (isIntitiated && isInprogress)
  {
    fill(#E39125);
  } else
  {
    fill(#305538);
  }
  rect(70, 35, 300, 250, 10); // room for food
  fill(120);
  rect(400, 30, 170, 50, 10); // room for time and message display

  if (isIntitiated && isInprogress)
  {    
    elapsedTime = millis() - startTime;
    //println(elapsedTime);
    if (elapsedTime <= cookTime)
    {

      showMessage(getTimeRunning(cookTime-elapsedTime));
    } 
    else
    {
      isIntitiated = false;
      showMessage("end");
      isInprogress = false;
    }
  }
  else if(isIntitiated && !isInprogress)
  { 
   ArrayList<Integer> showTime = new ArrayList<Integer>(); 
   for(int i=0;i<timeEntered.size();i++)
   {
    showTime.add(timeEntered.get(i));     
   }
   
   while(showTime.size() <6)
   {
     showTime.add(0,0);
   }
   
    String timeShow = str(showTime.get(0)) + str(showTime.get(1)) + ":" + str(showTime.get(2)) + str(showTime.get(3)) + ":" + str(showTime.get(4)) + str(showTime.get(5));
    showMessage(timeShow);
  }
  else
  {
    showMessage(getCurrentTime());
  }
}


void addButonsToScreen(ControlP5 cp5)
{
  fill(255);
  cp5.addButton("1").setPosition(400, 100).setSize(numberButtonWidth, numberButtonHeight);
  cp5.addButton("2").setPosition(460, 100).setSize(numberButtonWidth, numberButtonHeight);
  cp5.addButton("3").setPosition(520, 100).setSize(numberButtonWidth, numberButtonHeight);

  cp5.addButton("4").setPosition(400, 150).setSize(numberButtonWidth, numberButtonHeight);
  cp5.addButton("5").setPosition(460, 150).setSize(numberButtonWidth, numberButtonHeight);
  cp5.addButton("6").setPosition(520, 150).setSize(numberButtonWidth, numberButtonHeight);

  cp5.addButton("7").setPosition(400, 200).setSize(numberButtonWidth, numberButtonHeight);
  cp5.addButton("8").setPosition(460, 200).setSize(numberButtonWidth, numberButtonHeight);
  cp5.addButton("9").setPosition(520, 200).setSize(numberButtonWidth, numberButtonHeight);

  cp5.addButton("Start").setPosition(400, 250).setSize(numberButtonWidth, numberButtonHeight);
  cp5.addButton("0").setPosition(460, 250).setSize(numberButtonWidth, numberButtonHeight);
  cp5.addButton("Cancel").setPosition(520, 250).setSize(numberButtonWidth, numberButtonHeight);

  cp5.addButton("Time Cook").setPosition(400, 300).setSize(numberButtonWidth, numberButtonHeight);
}


void mousePressed() {
  if(isIntitiated)
  {
  startTime = millis();
  if ((mouseX >= 400 && mouseX <= 400 + numberButtonWidth) &&
    (mouseY >= 100 && mouseY <= 100 + numberButtonHeight)) {
    timeEntered.add(1); 
    println("Enterted " + 1);
  } else if ((mouseX >= 460 && mouseX <= 460 + numberButtonWidth) &&
    (mouseY >= 100 && mouseY <= 100 + numberButtonHeight)) {
    timeEntered.add(2); 
    println("Enterted " + 2);
  } else if ((mouseX >= 520 && mouseX <= 520 + numberButtonWidth) &&
    (mouseY >= 100 && mouseY <= 100 + numberButtonHeight)) {
    timeEntered.add(3); 
    println("Enterted " + 3);
  } else if ((mouseX >= 400 && mouseX <= 400 + numberButtonWidth) &&
    (mouseY >= 150 && mouseY <= 150 + numberButtonHeight)) {
    timeEntered.add(4); 
    println("Enterted " + 4);
  } else if ((mouseX >= 460 && mouseX <= 460 + numberButtonWidth) &&
    (mouseY >= 150 && mouseY <= 150 + numberButtonHeight)) {
    timeEntered.add(5); 
    println("Enterted " + 5);
  } else if ((mouseX >= 520 && mouseX <= 520 + numberButtonWidth) &&
    (mouseY >= 150 && mouseY <= 150 + numberButtonHeight)) {
    timeEntered.add(6); 
    println("Enterted " + 6);
  } else if ((mouseX >= 400 && mouseX <= 400 + numberButtonWidth) &&
    (mouseY >= 200 && mouseY <= 200 + numberButtonHeight)) {
    timeEntered.add(7); 
    println("Enterted " + 7);
  } else if ((mouseX >= 460 && mouseX <= 460 + numberButtonWidth) &&
    (mouseY >= 200 && mouseY <= 200 + numberButtonHeight)) {
    timeEntered.add(8);
    println("Enterted " + 8);
  } else if ((mouseX >= 520 && mouseX <= 520 + numberButtonWidth) &&
    (mouseY >= 200 && mouseY <= 200 + numberButtonHeight)) {
    timeEntered.add(9); 
    println("Enterted " + 9);
  } else if ((mouseX >= 460 && mouseX <= 460 + numberButtonWidth) &&
    (mouseY >= 250 && mouseY <= 250 + numberButtonHeight)) {
    timeEntered.add(0); 
    println("Enterted " + 0);
  }  
  }
   if ((mouseX >= 400 && mouseX <= 400 + numberButtonWidth) &&
    (mouseY >= 250 && mouseY <= 250 + numberButtonHeight)) {
    startcoocking();
    println("Pressed Start");
  } else if ((mouseX >= 520 && mouseX <= 520 + numberButtonWidth) &&
    (mouseY >= 250 && mouseY <= 250 + numberButtonHeight)) {
    resetValues(); 
    println("Pressed Cancel");
  } else if ((mouseX >= 400 && mouseX <= 400 + numberButtonWidth) &&
    (mouseY >= 300 && mouseY <= 300 + numberButtonHeight)) {
    resetValues();
    isIntitiated = true; 
    println("Pressed timecook");
  }
}

int getTimeEnteredInMilliSeconds(ArrayList<Integer> time)
{
  println("Enterted time as is:" + time);
  int minutes = 0;
  int seconds = 0;
  int hours = 0;

  hours = (time.get(1) * 10) + (time.get(0));
  minutes =   (time.get(2) * 10) + (time.get(3));
  seconds = (time.get(4) * 10) +(time.get(5)) ;

println("previous:");

  println("h:" + hours);
  println("m:" + minutes);
  println("s:" + seconds);
  if (seconds >= 60)
  {
    seconds = seconds - 60;
    minutes = minutes + 1;
  }

  if (minutes >= 60)
  {
    minutes = minutes - 60;
    hours = hours + 1;
  }

  if (hours >=24)
  {
    hours = 24;
  }

  println("h:" + hours);
  println("m:" + minutes);
  println("s:" + seconds);
  return (hours * 60 * 60 * 1000) + (minutes * 60 * 1000) + (seconds * 1000) + 1000;
}
// utility functions below
void showMessage(String message)
{
  fill(#46E31B);
  textSize(32);
  text(message, 410, 65);
}


String getCurrentTime()
{
  int hour = hour();
  String AMorPM = hour < 12 ? "AM" : "PM";
  return formateTime(hour % 12) + ":" + formateTime(minute()) + " " + AMorPM;
}

String formateTime(int time)
{
  return  time < 10 ? ("0" + time) : str(time);
}
/*
void showEnteredTime()
 {
 int hours = (timeEntered.get(4) * 10) + (timeEntered.get(5));
 int minutes =   (timeEntered.get(3) * 10) + (timeEntered.get(2));
 int seconds = (timeEntered.get(0) * 10) +(timeEntered.get(1)) ;
 
 showMessage(getTimeEnteredInMilliSeconds(timeEntered));
 }*/

String getTimeRunning(int milliseconds)
{
   int seconds = (milliseconds / 1000) % 60 ;
  int minutes = (milliseconds / (1000*60)) % 60;
  int hours   = (milliseconds / (1000*60*60)) % 24;
  return formateTime(hours) + ":" + formateTime(minutes) +":" +formateTime(seconds);
}

void resetValues() {
  startTime = 0;
  elapsedTime = 0;
  cookTime = 0;
  isInprogress = false; 
  isIntitiated = false;
  timeEntered = new ArrayList<Integer>();
}

void startcoocking()
{
  // add zeros to start to as we see it in the screen
  while (timeEntered.size() < 6)
  {
    timeEntered.add(0,0);
  }
  
  cookTime = getTimeEnteredInMilliSeconds(timeEntered);
  startTime = millis();
  isInprogress = true;
  println("Entered Time" + timeEntered);
}
