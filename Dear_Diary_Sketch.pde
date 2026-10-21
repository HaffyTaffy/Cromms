Table data;

void setup() {
  size(600, 500);
  data = loadTable("messages.csv", "header");
  println(data.getRowCount());
}

void draw() {
  background(200);
  textSize(20);
  fill(0);
  text("Dear Diary: Messages Data", 30, 40);
  fill(70, 130, 180);
  ellipse(100, 150, 50, 50);
}
