PImage img;

void setup() {
  size(640, 360);  
  img = loadImage("papaleguas.png");
}

float EquacaoRetaY(float x1, float y1, float x2, float y2, float x) { //calcula a altura do ponto na reta de acordo com a largura
  float coeficiente = (y2 - y1)/(x2 - x1);
  float y = (coeficiente * (x - x1)) + y1;
  return y;
}

float EquacaoRetaX(float x1, float y1, float x2, float y2, float y) {//calcula a largura do ponto na reta de acordo com a altura
  float coeficiente = (y2 - y1)/(x2 - x1);
  float x = ((y-y1)/coeficiente)+x1;
  return x;
}

void draw() {
  Integer objeto = 50;//altura e largura do Objeto
  int imagem = objeto;
  Integer raio = this.height/2;//raio do espelho com valor de acordo com o fundo
  //Integer raio = 60;//raio do espelho com valor numerico
  Integer centro = this.width/2 - raio;
  Integer foco = centro + raio/2;
  
  double pitagoras = Math.sqrt(((raio*raio)-(objeto*objeto)));//distancia entre o centro do espelho e o ponto
  float ponto1 = (float)((this.width/2) - raio + pitagoras);//ponto do espelho onde o topo do objeto é refletido
  
  
  background(0);

  if (mouseX < this.width/2 - objeto/2) {//Espelho Concavo
    if(mouseY < this.height/2){//Imagem na parte de cima
      img.resize(objeto, objeto);
      //imagem do cursor
      image(img, mouseX-img.width/2, this.height/2 - img.height);
      //imagem refletida
      pushMatrix();
      translate(img.width, 0);
      scale(-1, 1); // You had it right!
      image(img, (-640 + (mouseX+img.width/2)), this.height/2-img.height);
      popMatrix();
      //centimetros = pixels
      text("Distancia entre o centro do objeto e o centro do espelho: " + (320 -(mouseX)) + " cm", 330, objeto);
      text("Imagem: Real", 330, 65);
      
      stroke(0, 255, 0);//cor das linhas de reflexo
      line(mouseX-img.width/2, this.height/2 - objeto, ponto1, this.height/2 - objeto);
      line(ponto1, this.height/2 - objeto, foco, this.height/2);
      line(mouseX-img.width/2, this.height/2 - objeto, foco, this.height/2);
      line(foco, this.height/2, EquacaoRetaX(ponto1, this.height/2 - objeto, foco, this.height/2, this.height), this.height);
      
    }else{//imagem na parte de baixo
      img.resize(objeto, objeto);
      //imagem do cursor
      image(img, mouseX-img.width/2, this.height/2);
      
      //imagem refletida
      pushMatrix();
      translate(img.width, 0);
      scale(-1, 1); // You had it right!
      image(img, (-640 + (mouseX+img.width/2)), this.height/2);
      popMatrix();
      //centimetros = pixels
      text("Distancia entre o centro do objeto e o centro do espelho: " + (320 -(mouseX)) + " cm", 330, objeto);
      text("Imagem: Real", 330, 65);
    }
  }else{//Espelho convexo
    if(mouseY < this.height/2){//Imagem na parte de cima
      img.resize(objeto, objeto);
      //imagem do cursor
      image(img, mouseX-img.width/2, this.height/2 - img.height);
      
      
      if(imagem > 0){
        img.resize(objeto,imagem);
      }else{
        
      }
      //imagem refletida
      pushMatrix();
      translate(img.width, 0);
      scale(-1, 1); // You had it right!
      //(-640 + (mouseX+img.width/2))
      //image(img, -this.width/2 + (distanciaImagem) , this.height/2-img.height);
      popMatrix();
      //centimetros = pixels
      text("Distancia entre o centro da imagem e o espelho: " + (320 -(mouseX)) + " cm", 330, 50);
      text("Imagem: Real", 330, 65);
      
    }else{//imagem na parte de baixo
      img.resize(objeto, objeto);
      //imagem do cursor
      image(img, mouseX-img.width/2, this.height/2);
    }
  }
  stroke(255, 255, 255);//cor da linha
  //Linha Horizontal
  line(0, this.height/2, this.width, this.height/2);
  
  //Centro
  line(centro, this.height/2 - 2, centro , this.height/2 + 2);
  //Foco
  line(foco, this.height/2 - 2, foco , this.height/2 + 2);
  
  stroke(20, 20, 20);//cor do arco
  //Linha Vertical
  line(this.width/2, 0, this.width/2, this.height);

  //Espelho
  noFill();//preenchimento interior do arco
  stroke(204, 102, 0);//cor do arco
  arc(this.width/2 - raio, this.height/2, raio*2, raio*2, -QUARTER_PI, QUARTER_PI);//arco(Espelho)

  stroke(255);
}