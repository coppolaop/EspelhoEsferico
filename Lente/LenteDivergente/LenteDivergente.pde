void setup() {
  size(1280, 360);
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
  Integer vObjeto = this.height/2 - mouseY;//altura e largura do Objeto
  PVector pObjeto = new PVector(mouseX, this.height/2 - vObjeto);//posição do topo do objeto
  
  PVector pImagem = new PVector(mouseX, this.height/2 - vObjeto);//posição do topo do objeto
  float vImagem = 0;//altura e largura do Objeto
  
  float raio = this.width/4;//valor do raio do espelho com valor de acordo com o fundo
  PVector pCentro = new PVector(this.width/2 - raio, this.height/2);//posição do centro do lado esquerdo
  PVector pCentro2 = new PVector(this.width/2 + raio, this.height/2);//posição do centro do lado direito
  float vCentro = raio;//valor numérico do centro
  PVector pFoco = new PVector(pCentro.x + vCentro/2, this.height/2);//posição do foco do lado esquerdo
  PVector pFoco2 = new PVector(pCentro2.x - vCentro/2, this.height/2);//posição do foco do lado direito
  float vFoco = vCentro/2;//valor numérico de foco
  
  float pitagoras = (float) Math.sqrt(((raio*raio)-(vObjeto*vObjeto)));//distancia entre o centro do espelho e o ponto1
  
  float alturaMaxima = pitagoras * 0.1763269807;//valor da base * tangente de 10° para impedir que a imagem e o objeto sejam maiores que o espelho
  boolean tamanhoCerto = true;//Variavel que determina se o objeto e a imagem são menores que o espelho
  
  background(0);//plano de fundo preto

  if (mouseX < this.width/2) {//Objeto do lado esquerdo
  
  }else{//Objeto do lado direito
    if(mouseY < this.height/2){//Imagem na parte de cima
      
      pImagem.x = this.width/2 + equacaoGauss(vFoco, this.width/2 - pObjeto.x);
      vImagem = aumentoLinear(this.width/2 - pImagem.x,this.width/2 - pObjeto.x) * vObjeto;
      pImagem.y = this.height/2 - Math.abs(vImagem);
      
      //Inicio Objeto
      stroke(255, 0, 0);//cor das linhas de reflexo
      line(pObjeto.x, pObjeto.y, pObjeto.x , this.height/2);
      line(pObjeto.x, pObjeto.y, pObjeto.x - 5, pObjeto.y + 5);
      line(pObjeto.x, pObjeto.y, pObjeto.x + 5, pObjeto.y + 5);
      //Fim Objeto
        
      if(alturaMaxima>vObjeto){
        
        stroke(0, 255, 0);//cor das linhas de reflexão
        line(pObjeto.x, pObjeto.y, this.width/2, pObjeto.y);//topo do objeto ate espelho
        line(pObjeto.x, pObjeto.y, this.width/2, this.height/2);//topo do objeto até o meio do espelho
        
        stroke(0, 255, 255);//cor das linhas do outro lado do espelho
        line(this.width/2, pObjeto.y, pFoco2.x, pFoco2.y);//Reflexão do espelho ao foco
        
        //Inicio Imagem
        stroke(255, 0, 0);//cor da Imagem
        line(pImagem.x, pImagem.y, pImagem.x , this.height/2);
        line(pImagem.x, pImagem.y, pImagem.x - 5, pImagem.y + 5);
        line(pImagem.x, pImagem.y, pImagem.x + 5, pImagem.y + 5);
         //Fim Imagem
        
        text("Imagem: Virtual, Direita e Menor", this.width/1.30, 65);
      }else{
        tamanhoCerto = false;
        text("Objeto Maior que o espelho", this.width/1.30, 65);
        stroke(0, 255, 0);//cor das linhas de reflexão
        line(pObjeto.x, pObjeto.y, 0, equacaoRetaY(pObjeto.x, pObjeto.y,this.width/2, this.height/2, 0));//topo do objeto ate espelho
        line(pObjeto.x, pObjeto.y, 0, equacaoRetaY(pObjeto.x, pObjeto.y, this.width/2, pObjeto.y, 0));//topo do objeto ate o canto
      }
    }else{//imagem na parte de baixo
      pImagem.x = this.width/2 + equacaoGauss(vFoco, this.width/2 - pObjeto.x);
      vImagem = aumentoLinear(this.width/2 - pImagem.x,this.width/2 - pObjeto.x) * vObjeto;
      pImagem.y = this.height/2 + Math.abs(vImagem);
      
      //Inicio Objeto
      stroke(255, 0, 0);//cor do Objeto
      line(pObjeto.x, pObjeto.y, pObjeto.x , this.height/2);
      line(pObjeto.x, pObjeto.y, pObjeto.x + 5, pObjeto.y - 5);
      line(pObjeto.x, pObjeto.y, pObjeto.x - 5, pObjeto.y - 5);
      //Fim Objeto
        
      if(alturaMaxima>-vObjeto){
        
        stroke(0, 255, 0);//cor das linhas de reflexo
        line(pObjeto.x, pObjeto.y, this.width/2, pObjeto.y);//topo do objeto ate espelho
        line(pObjeto.x, pObjeto.y, this.width/2, this.height/2);//topo do objeto ate o meio do espelho
        
        stroke(0, 255, 255);//cor das linhas do outro lado do espelho
        line(this.width/2, pObjeto.y, pFoco2.x, pFoco2.y);//Reflexão do espelho ao foco
        
        //Inicio Imagem
        stroke(255, 0, 0);//cor da Imagem
        line(pImagem.x, pImagem.y, pImagem.x , this.height/2);
        line(pImagem.x, pImagem.y, pImagem.x + 5, pImagem.y - 5);
        line(pImagem.x, pImagem.y, pImagem.x - 5, pImagem.y - 5);
         //Fim Imagem
        
        text("Imagem: Virtual, Direita e Menor", this.width/1.30, 65);
      }else{
        tamanhoCerto = false;
        text("Objeto Maior que o espelho", this.width/1.30, 65);
        stroke(0, 255, 0);//cor das linhas de reflexo
        line(pObjeto.x, pObjeto.y, 0, equacaoRetaY(pObjeto.x, pObjeto.y,this.width/2, this.height/2, 0));//topo do objeto ate o canto
        line(pObjeto.x, pObjeto.y, 0, equacaoRetaY(pObjeto.x, pObjeto.y, this.width/2, pObjeto.y, 0));//topo do objeto ate o canto
      }
    }
  }
  
  if(tamanhoCerto){
    //centimetros = pixels
    text("Distancia entre o objeto e a lente: " + Math.abs(this.width/2 -pObjeto.x) + " cm", this.width/1.30, 35);
    text("Distancia entre a imagem e a lente: " + Math.abs(this.width/2 -pImagem.x) + " cm", this.width/1.30, 50);
    text("Tamanho do Objeto: " + Math.abs(vObjeto) + " cm", this.width/1.30, 80);
    text("Tamanho da Imagem: " + Math.abs(vImagem) + " cm", this.width/1.30, 95);
  }
  stroke(255, 255, 255);//cor da linha
  //Linha Horizontal
  line(0, this.height/2, this.width, this.height/2);
  
  //Centro esquerda
  line(pCentro.x, this.height/2 - 2, pCentro.x , this.height/2 + 2);
  //Foco esquerda
  line(pFoco.x, this.height/2 - 2, pFoco.x , this.height/2 + 2);
  
  //Centro direita
  line(pCentro2.x, this.height/2 - 2, pCentro2.x, this.height/2 + 2);
  //Foco direita
  line(pFoco2.x, this.height/2 - 2, pFoco2.x, this.height/2 + 2);
  
  //Inicio Espelho
  noFill();//preenchimento interior do arco
  stroke(204, 102, 0);//cor do arco
  arc(this.width/2 - raio, this.height/2, raio*2, raio*2, -HALF_PI/9, HALF_PI/9);//arco(lente) formando no máximo 10 Graus com o centro
  line(this.width/2 , this.height/2- vCentro*0.1763269807, this.width/2, this.height/2+ vCentro*0.1763269807);
  arc(this.width/2 + raio, this.height/2, raio*2, raio*2, -HALF_PI/9-PI, HALF_PI/9-PI);//arco(lente) formando no máximo 10 Graus com o centro
  //Fim Espelho
  
  //-- Regras de Nitidez do Espelho
  //http://alunosonline.uol.com.br/fisica/condicoes-gauss-para-espelhos-esfericos.html
  //http://papofisico.tumblr.com/post/35741884495/condi%C3%A7%C3%A3o-de-nitidez-de-gauss
}