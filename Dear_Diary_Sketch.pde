Table data;

void setup() {
  size(900, 750);
  data = loadTable("messages.csv", "header");
  noLoop();
}


void draw() {
  background(250, 247, 250);

  // Adds title
  fill(75, 60, 90);
  textSize(23);
  text("Dear Diary", 30, 40);

  fill(120, 105, 130);
  textSize(12);
  text("Data Visuals ii", 30, 62);

  // Checks messages.csv is loaded
  if (data == null) {
    text("Error loading messages.csv", 30, 100);
    return;
  }

  int totalDays = data.getRowCount();
  println("Rows loaded: " + totalDays);

  // Finds largest values in data
  float maxSent = 1;
  float maxReceived = 1;
  float maxPeople = 1;
  float maxMinutes = 1;

  for (TableRow r : data.rows()) {
    maxSent = max(maxSent, r.getInt("Messages Sent"));
    maxReceived = max(maxReceived, r.getInt("Messages Received"));
    maxPeople = max(maxPeople, r.getInt("People Contacted"));
    maxMinutes = max(maxMinutes, r.getInt("Minutes Used"));
  }

  // Spacing between days
  int cols = 10;
  float cellW = 84;
  float cellH = 85;

  // Visualising the data for each day
  for (int i = 0; i < totalDays; i++) {
    TableRow r = data.getRow(i);

    int sent = r.getInt("Messages Sent");
    int received = r.getInt("Messages Received");
    int people = r.getInt("People Contacted");
    int minutes = r.getInt("Minutes Used");

    // Data retrieval tester
    println("Day " + (i + 1)
      + " Sent: " + sent
      + " Received: " + received
      + " People: " + people
      + " Minutes: " + minutes);

    // Mapping where each shape goes
    int col = i % cols;
    int row = i/cols;

    float x = 60 + col * cellW;
    float y = 120 + row * cellH;

    // Altering shape size using data
    float w = map(people, 0, maxPeople, 12, 34);
    float hSent = map(sent, 0, maxSent, 8, 30);
    float hReceived = map(received, 0, maxReceived, 8, 30);

    // Colouring the shape
    float amount = constrain(minutes / maxMinutes, 0, 1);

    color blue = color(150, 190, 230);
    color pink = color(230, 165, 200);
    color shade = lerpColor(blue, pink, amount);

    // Drawing upper triangle
    noStroke();
    fill(shade);

    triangle(
      x, y - hSent,
      x - w / 2, y,
      x + w / 2, y);

    // Drawing lower triangle
    triangle(
      x - w / 2, y,
      x + w / 2, y,
      x, y + hReceived);

    // Adding the day number
    fill(85, 70, 100);
    textSize(10);
    textAlign(CENTER, TOP);
    text(i + 1, x, y + 35);
  }
}
