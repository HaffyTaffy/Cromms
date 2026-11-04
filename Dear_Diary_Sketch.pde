Table data;

void setup() {
  size(900, 750);
  data = loadTable("messages.csv", "header");
  noLoop();
}


void draw() {
  background(250, 247, 250);
  fill(75, 60, 90);
  textSize(23);
  text("Dear Diary", 30, 40);

  fill(120, 105, 130);
  textSize(12);
  text("Data Visuals ii", 30, 62);

  if (data == null) {
    text("Error loading messages.csv", 30, 100);
    return;
  }

  int totalDays = data.getRowCount();
  println("Rows loaded: " + totalDays);

  float maxSent = 1;
  float maxReceived = 1;
  float maxPeople = 1;
  // float maxMinutes = 1;

  for (TableRow r : data.rows()) {
    maxSent = max(maxSent, r.getInt("Messages Sent"));
    maxReceived = max(maxReceived, r.getInt("Messages Received"));
    maxPeople = max(maxPeople, r.getInt("People Contacted"));
    //  maxMinutes = max(maxMinutes, r.getInt("Minutes Used"));
  }

  int cols = 10;
  float cellW = 84;
  float cellH = 85;

  for (int i = 0; i < totalDays; i++) {
    TableRow r = data.getRow(i);

    int sent = r.getInt("Messages Sent");
    int received = r.getInt("Messages Received");
    int people = r.getInt("People Contacted");
    int minutes = r.getInt("Minutes Used");

    println("Day " + (i + 1)
      + " Sent: " + sent
      + " Received: " + received
      + " People: " + people
      + " Minutes: " + minutes);

    int col = i % cols;
    int row = i/cols;

    float x = 60 + col * cellW;
    float y = 120 + row * cellH;

    // More people, wider shape
    float w = map(people, 0, maxPeople, 12, 34);

    // More messages, taller shape
    float hSent = map(sent, 0, maxSent, 8, 30);
    float hReceived = map(received, 0, maxReceived, 8, 30);

    // More minutes, pinker colour
    float amount = constrain(minutes / 400.0, 0, 1);

    color blue = color(105, 165, 225);
    color purple = color(170, 115, 215);
    color pink = color(235, 105, 170);

    color shade;
    if (amount < 0.5) {
      shade = lerpColor(blue, purple, amount * 2);
    } else {
      shade = lerpColor(purple, pink, (amount - 0.5) * 2);
    }


    // Sets triangle colours
    noStroke();
    fill(shade);

    // Upper triangle, messages sent
    triangle(
      x, y - hSent,
      x - w / 2, y,
      x + w / 2, y);

    // Lower triangle. messages received
    triangle(
      x - w / 2, y,
      x + w / 2, y,
      x, y + hReceived);

    // Day number
    fill(85, 70, 100);
    textSize(10);
    textAlign(CENTER, TOP);
    text(i + 1, x, y + 35);
  }

  fill(100, 85, 115);
  textSize(12);
  text("Day number shown below each shape", 125, 600);
}
