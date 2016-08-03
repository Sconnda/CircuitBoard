int N = 10;
ArrayList<PVector> circles = new ArrayList<PVector>();
Branch [] branches = new Branch[N];

void settings() {
  fullScreen();
}

void setup() {
  initialize();
  test(branches);
  while (badTouch()) {
    initialize();
    test(branches);
  }
}

void draw() {
  background(0);
  for (int i = 0; i < N; i++) {
    stroke(255*(float)i/N,255*(1-(float)i/N),0);
    branches[i].display();
  }
  for (int i = 0; i < N; i++) {
    branches[i].circles();
  }
  fill(0, 255, 0);
  text(mouseX + ", " + mouseY, mouseX, mouseY);
  fill(255);
}

void initialize() {
  circles.clear();
  branches[0] = new Branch(0, 50, 1, 30, 2);
  for (int i = 1; i < N; i++) {
    branches[i] = new Branch(0, branches[i-1].start.y+random(5, 25), 1, 30, 2);
  }
}

void test(Branch[] branches) {
  for (int i = 0; i < branches.length; i++) {
    if (branches[i].forks != null) {
      test(branches[i].forks);
    } else {
      float x = branches[i].start.x+branches[i].node.x;
      float y = branches[i].node.y;
      circles.add(new PVector(x, y));
    }
  }
}

boolean badTouch() {
  for (int i = 0; i < circles.size(); i++) {
    float x = circles.get(i).x;
    float y = circles.get(i).y;
    if (x > width-25 || y < 50 || y > height) {
      return true;
    }
    for (int j = 0; j < circles.size(); j++) {
      float x2 = circles.get(j).x;
      float y2 = circles.get(j).y;
      if (i != j && (dist(x, y, x2, y2) <= 50)) {
        return true;
      }
    }
  }
  return false;
}