//https://www.n2yo.com/rest/v1/satellite/positions/25544/41.702/-76.014/0/2/&apiKey=STDH68-MXH7MF-EC5QEV-4KH4

float angle;

JSONObject json;
float r = 150;

PImage earth;
PShape globe;

void setup() {
  size(1000, 1000, P3D);
  earth = loadImage("EarthPicture.jpg");

  json = loadJSONObject("https://www.n2yo.com/rest/v1/satellite/positions/25544/41.702/-76.014/0/2/&apiKey=STDH68-MXH7MF-EC5QEV-4KH4");
  noStroke();
  globe = createShape(SPHERE, r);
  globe.setTexture(earth);
}

void draw() {
  background(51);
  translate(width*0.5, height*0.5);

  //rotateY(angle);
  //angle += 0.01;

  //lights();
  //fill(200);
  //noStroke();
  //shape(globe);

  for (int i = 0; i < json.size(); i++) {
    JSONArray pos = json.getJSONArray("positions");
    JSONObject val = pos.getJSONObject(i);
    float lat = val.getFloat("satlatitude");
    float lon = val.getFloat("satlongitude");
    float alt = val.getFloat("sataltitude");
    float time = val.getFloat("timestamp");

    float theta = radians(lat);
    float phi = radians(lon) + PI;

    float x = (r+alt) * cos(theta) * cos(phi);
    float y = ((-r+alt)) * sin(theta);
    float z = (-(r+alt)) * cos(theta) * sin(phi);

    println(" alt = " + alt + " lat = " + lat + "  lon = " + lon);
    println("x = " + x + " y = " + y + " z = " + z);

    pushMatrix();
    rotateY(angle);
    angle += 0.003;
    translate(x, y, z);
    //rotate(angleb, raxis.x, raxis.y, raxis.z);
    fill(255);
    box(10);
    popMatrix();

    lights();
    fill(200);
    noStroke();
    shape(globe);
    
    //text("timestamp: " + time, 50, 0, 350);
  }
}
