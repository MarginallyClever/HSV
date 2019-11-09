// HSV color demo (0...1 to rainbow colors)
// 2019-11-09 dan@marginallyclever.com
// CC-BY-NC-SA

float r,g,b;


void clusterColor(int j) {
  float v = (float)(j+1) / (float)width; // (0...1]

  if(false) {
    // naive
    long c = (long)(v*(float)0xffffff);
    r = (c>>16)&0xff;
    g = (c>> 8)&0xff;
    b = (c    )&0xff;
  } else {
    // index as hsv to rgb
    // https://en.wikipedia.org/wiki/HSL_and_HSV#HSV_to_RGB
    // Assume Hue=v/360, saturation=1, value=1.
    float C = 1;// C=V*S
    float H = v*6;
    float X = C * (1-abs((H % 2) - 1));
         if(H<1) { r=C; g=X; b=0; }
    else if(H<2) { r=X; g=C; b=0; }
    else if(H<3) { r=0; g=C; b=X; }
    else if(H<4) { r=0; g=X; b=C; }
    else if(H<5) { r=X; g=0; b=C; }
    else         { r=C; g=0; b=X; }  // H<6
    r*=255;
    g*=255;
    b*=255;
  }
}


void setup() {
  size(800,800);
}

void draw() {
  background(255);
  
  for(int i=0;i<width;++i) {
    clusterColor(i);
    stroke(r,g,b);
    line(i,0,i,height);
  }
}
