class Branch {
  PVector start0, start;
  Branch[] forks;
  PVector node;
  int[] kinkLoc;
  int[] kinkDir;
  float[] kinkLength;

  Branch(float x0, float y0, int dir, float len, int branches) {
    start0 = new PVector(x0,y0);
    float x = x0 + len*sqrt(2);
    float y = y0 + dir*len*sqrt(2);
    start = new PVector(x, y);
    node = new PVector(random(min(50, width-branches*100-x), width-branches*100-x), y);
    int n = max(0, round(random(node.x*6/width)-1));
    if (n==0) {
      kinkLoc = null;
      kinkDir = null;
      kinkLength = null;
    } else {
      kinkLoc = new int[n];
      for (int i = 0; i < n; i++) {
        kinkLoc[i] = round(node.x/(n+1)*(i+random(2/3, 4/3)));
      }
      kinkDir = new int[n];
      for (int i = 0; i < n; i++) {
        kinkDir[i] = 2*round(random(1))-1;
      }
      kinkLength = new float[n];
      for (int i = 0; i < n; i++) {
        kinkLength[i] = node.x/(n+1)*random(0.05, 0.1);
        node.y += kinkDir[i]*kinkLength[i]*sqrt(2);
      }
    }
    if (branches > 1) {
      forks = new Branch[2];
      int b0 = round(random(branches-1));
      int d0 = round(random(-1,1));
      forks[0] = new Branch(x+node.x, node.y, d0, 10, b0);
      forks[1] = new Branch(x+node.x, node.y, (abs(d0)-1)*(2*round(random(0,1))-1), 10, branches-1-b0);
    } else {
      forks = null;
    }
  }

  void display() {
    line(start0.x, start0.y, start.x, start.y);
    if (kinkLoc != null) {
      float x = start.x;
      float y = start.y;
      for (int i=0; i < kinkLoc.length; i++) {
        line(x, y, start.x+kinkLoc[i], y);
        x = start.x+kinkLoc[i];
        line(x, y, x+kinkLength[i]*sqrt(2), y+kinkDir[i]*kinkLength[i]*sqrt(2));
        y += kinkDir[i]*kinkLength[i]*sqrt(2);
        x = start.x+kinkLoc[i]+kinkLength[i]*sqrt(2);
      }
      line(x, node.y, start.x+node.x, node.y);
    } else {
      line(start.x, start.y, start.x+node.x, start.y);
    }
    if (forks != null) {
      forks[0].display();
      forks[1].display();
    }
  }

  void circles() {
    if (forks != null) {
      forks[0].circles();
      forks[1].circles();
    } else {
      ellipse(start.x+node.x, node.y, 50, 50);
    }
  }
}