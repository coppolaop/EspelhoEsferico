void setup() {
  size(640, 360);  
}

float equacaoRetaY(float x1, float y1, float x2, float y2, float x) { //calcula a altura do ponto na reta de acordo com a largura
  float coeficiente = (y2 - y1)/(x2 - x1);
  float y = (coeficiente * (x - x1)) + y1;
  return y;
}

float equacaoRetaX(float x1, float y1, float x2, float y2, float y) {//calcula a largura do ponto na reta de acordo com a altura
  float coeficiente = (y2 - y1)/(x2 - x1);
  float x = ((y-y1)/coeficiente)+x1;
  return x;
}

float equacaoGauss(float foco, float P){
  float PLinha = 0.;
  PLinha = (foco*P)/(P-foco);
  return PLinha;
}

float aumentoLinear(float PLinha, float P){
  float aumento = 0.;
  aumento = -PLinha/P;
  return aumento;
}

void draw() {
  Integer vObjeto = 50;//altura e largura do Objeto
  PVector pObjeto = new PVector(mouseX, this.height/2 - vObjeto);//posição do centro do objeto
  
  PVector pImagem = new PVector(mouseX, this.height/2 - vObjeto);
  float vImagem = vObjeto;
  
  float raio = this.height/2;//valor do raio do espelho com valor de acordo com o fundo
  PVector pCentro = new PVector(this.width/2 - raio, this.height/2);
  float vCentro = raio;
  PVector pFoco = new PVector(pCentro.x + vCentro/2, this.height/2);
  float vFoco = vCentro/2;
  
  float pitagoras = (float) Math.sqrt(((raio*raio)-(vObjeto*vObjeto)));//distancia entre o centro do espelho e o ponto
  PVector ponto1 = new PVector((pCentro.x + pitagoras),pObjeto.y);//ponto do espelho onde o topo do objeto é refletido
  
  
  background(0);//plano de fundo preto

  if (mouseX < this.width/2) {//Espelho Concavo
    if(mouseY < this.height/2){//Imagem na parte de cima
          
      //Inicio Objeto
      stroke(255, 0, 0);//cor das linhas de reflexo
      line(pObjeto.x, pObjeto.y, pObjeto.x , this.height/2);
      line(pObjeto.x, pObjeto.y, pObjeto.x - 5, pObjeto.y + 5);
      line(pObjeto.x, pObjeto.y, pObjeto.x + 5, pObjeto.y + 5);
      //Fim Objeto
      
      pImagem.x = this.width/2 - equacaoGauss(vFoco, this.width/2 - pObjeto.x);
      vImagem = aumentoLinear(this.width/2 - pImagem.x,this.width/2 - pObjeto.x) * vObjeto;
      pImagem.y = this.height/2 + Math.abs(vImagem);
      
      //centimetros = pixels
      text("Distancia entre o centro do objeto e o espelho: " + (this.width/2 -pObjeto.x) + " cm", 330, vObjeto);
      
      if(pObjeto.x<pFoco.x){//imagem antes do foco
        stroke(0, 255, 0);//cor das linhas de reflexo
        line(pObjeto.x, pObjeto.y, ponto1.x, ponto1.y);//topo do objeto ate espelho
        line(ponto1.x, ponto1.y, pFoco.x, pFoco.y);//espelho ate foco
        line(pObjeto.x, pObjeto.y, pFoco.x, pFoco.y);//topo do objeto ate foco
        line(pFoco.x, pFoco.y, equacaoRetaX(ponto1.x, ponto1.y, pFoco.x, pFoco.y, this.height), this.height);//linha refletida do foco ate canto
      
        //Inicio Objeto
        stroke(255, 0, 0);//cor das linhas de reflexo
        line(pImagem.x, pImagem.y, pImagem.x , this.height/2);
        line(pImagem.x, pImagem.y, pImagem.x + 5, pImagem.y - 5);
        line(pImagem.x, pImagem.y, pImagem.x - 5, pImagem.y - 5);
        //Fim Objeto
        
        if(pImagem.x < pCentro.x){
          text("Imagem: Real, Invertida e Maior", 330, 65);
        }else if(pImagem.x >pCentro.x){
          text("Imagem: Real, Invertida e Menor", 330, 65);
        }else{
          text("Imagem: Real, Invertida e Igual", 330, 65);
        }
        
        //if(pImagem.x < this.width/2){
        //text("Aumento Linear: "+ aumentoLinear(this.width/2 - pImagem.x,this.width/2 - pObjeto.x), 330, 80);
        //}else{
        //  text("Aumento Linear: "+ aumentoLinear(pImagem.x - this.width/2 ,this.width/2 - pObjeto.x), 330, 80);
        //}
        //text("objetoXFoco: "+ (pFoco.x - pObjeto.x), 330, 95);
        //text("ImagemXEspelho: "+ (pImagem.x - this.width/2), 330, 110);
        //text("vImagem: "+ (vImagem), 330, 125);
        //text("vObjeto: "+ (vObjeto), 330, 140);
        //text("Gauss: "+ (equacaoGauss(vFoco, this.width/2 - pObjeto.x)), 330, 155);
        
        pitagoras = (float) Math.sqrt(((raio*raio)-(vImagem*vImagem)));//distancia entre o centro do espelho e o ponto
        PVector ponto2 = new PVector((pCentro.x+ pitagoras),this.height/2 - vImagem);
        stroke(0, 255, 0);//cor das linhas de reflexo
        line(pFoco.x, pFoco.y, ponto2.x , ponto2.y);
        line(ponto2.x, ponto2.y, pImagem.x, pImagem.y);
      }else if(pObjeto.x > pFoco.x){//imagem depois do foco
        pImagem.y -= 2*vImagem;
        //Inicio Objeto
        stroke(255, 0, 0);//cor das linhas de reflexo
        line(pImagem.x, pImagem.y, pImagem.x , this.height/2);
        line(pImagem.x, pImagem.y, pImagem.x - 5, pImagem.y + 5);
        line(pImagem.x, pImagem.y, pImagem.x + 5, pImagem.y + 5);
        //Fim Objeto
        
        text("Imagem: Virtual, Direita e Maior", 330, 65);
        
        stroke(0, 255, 0);//cor das linhas de reflexo
        line(pObjeto.x, pObjeto.y, ponto1.x, ponto1.y);//topo do objeto ate espelho
        line(ponto1.x, ponto1.y, pFoco.x, pFoco.y);//espelho ate foco
        line(pObjeto.x, pObjeto.y, this.width/2, this.height/2);//topo do objeto ate o centro da imagem
        line(this.width/2, this.height/2, equacaoRetaX(pObjeto.x, pObjeto.y + 2*vObjeto, this.width/2, this.height/2, this.height), this.height);//centro da imagem até o infinito
        
        stroke(0, 0, 255);//cor das linhas do outro lado do espelho
        line(ponto1.x, ponto1.y, pImagem.x, pImagem.y);//Ponto do espelho até o topo da imagem
        line(this.width/2, this.height/2, pImagem.x, pImagem.y);//centro do espelho ate o topo da imagem
        
        
      }else{//imagem em cima do foco
        text("Imagem: Imprópria", 330, 65);
        stroke(0, 255, 0);//cor das linhas de reflexo
        line(pObjeto.x, pObjeto.y, ponto1.x, ponto1.y);//topo do objeto ate espelho
        line(ponto1.x, ponto1.y, equacaoRetaX(ponto1.x, ponto1.y, pFoco.x, pFoco.y, this.height), this.height);//espelho ate o infinito
        line(pObjeto.x, pObjeto.y, this.width/2, this.height/2);//Topo do objeto ao centro da imagem
        line(this.width/2, this.height/2, equacaoRetaX(pObjeto.x, pObjeto.y + 2*vObjeto, this.width/2, this.height/2, this.height), this.height);//centro do espelho até o infinito
      }
      
    }else{//imagem na parte de baixo
      //img.resize(objeto, objeto);
      ////imagem do cursor
      //image(img, mouseX-img.width/2, this.height/2);
      
      ////imagem refletida
      //pushMatrix();
      //translate(img.width, 0);
      //scale(-1, 1); // You had it right!
      //image(img, (-640 + (mouseX+img.width/2)), this.height/2);
      //popMatrix();
      ////centimetros = pixels
      //text("Distancia entre o centro do objeto e o centro do espelho: " + (320 -(mouseX)) + " cm", 330, objeto);
      //text("Imagem: Real", 330, 65);
    }
  }else{//Espelho convexo
    if(mouseY < this.height/2){//Imagem na parte de cima
      //img.resize(objeto, objeto);
      ////imagem do cursor
      //image(img, mouseX-img.width/2, this.height/2 - img.height);
      
      
      //if(imagem > 0){
      //  img.resize(objeto,imagem);
      //}else{
        
      //}
      ////imagem refletida
      //pushMatrix();
      //translate(img.width, 0);
      //scale(-1, 1); // You had it right!
      ////(-640 + (mouseX+img.width/2))
      ////image(img, -this.width/2 + (distanciaImagem) , this.height/2-img.height);
      //popMatrix();
      ////centimetros = pixels
      //text("Distancia entre o centro da imagem e o espelho: " + (320 -(mouseX)) + " cm", 330, 50);
      //text("Imagem: Real", 330, 65);
      
    }else{//imagem na parte de baixo
    
    }
  }
  stroke(255, 255, 255);//cor da linha
  //Linha Horizontal
  line(0, this.height/2, this.width, this.height/2);
  
  //Centro
  line(pCentro.x, this.height/2 - 2, pCentro.x , this.height/2 + 2);
  //Foco
  line(pFoco.x, this.height/2 - 2, pFoco.x , this.height/2 + 2);
  
  stroke(20, 20, 20);//cor do arco
  //Linha Vertical
  line(this.width/2, 0, this.width/2, this.height);

  //Espelho
  noFill();//preenchimento interior do arco
  stroke(204, 102, 0);//cor do arco
  arc(this.width/2 - raio, this.height/2, raio*2, raio*2, -QUARTER_PI, QUARTER_PI);//arco(Espelho)

  stroke(255);
}