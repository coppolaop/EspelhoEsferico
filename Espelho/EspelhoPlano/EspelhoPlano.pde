/**
 * Create Image. 
 * 
 * The createImage() function provides a fresh buffer of pixels to play with.
 * This example creates an image gradient.
 */

PImage img;

void setup() {
  size(640, 360);  
  img = loadImage("papaleguas.png");
  
}

void draw() {
  background(0);
  
  if(mouseX+img.width/2 < 320) {
    img.resize(75, 75);
    //imagem do cursor
    image(img, mouseX-img.width/2, mouseY-img.height/2);
    //imagem refletida
    pushMatrix();
    translate(img.width,0);
    scale(-1,1); // You had it right!
    image(img, (-640 + (mouseX+img.width/2)), mouseY-img.height/2);
    popMatrix();
    //centimetros = pixels
    text("Distancia entre o centro do Objeto e o espelho: " + (this.width/2 -(mouseX)) + " cm", 330, 35);
    text("Distancia entre o centro da Imagem e o espelho: " + (this.width/2 -(mouseX)) + " cm", 330, 50);
    text("Imagem: Real", 330, 65);
  }
  
  line(320, 0, 320, 360);
  stroke(255);
  
}