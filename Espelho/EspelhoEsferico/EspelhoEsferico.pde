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
  PVector pCentro = new PVector(this.width/2 - raio, this.height/2);//posição do centro do espelho
  float vCentro = raio;//valor numérico do centro
  PVector pFoco = new PVector(pCentro.x + vCentro/2, this.height/2);//posição do foco do espelho
  float vFoco = vCentro/2;//valor numérico de foco
  
  float pitagoras = (float) Math.sqrt(((raio*raio)-(vObjeto*vObjeto)));//distancia entre o centro do espelho e o ponto1
  PVector ponto1 = new PVector((pCentro.x + pitagoras),pObjeto.y);//ponto do espelho onde o topo do objeto é refletido
  
  float alturaMaxima = pitagoras * 0.1763269807;//valor da base * tangente de 10° para impedir que a imagem e o objeto sejam maiores que o espelho
  boolean tamanhoCerto = true;//Variavel que determina se o objeto e a imagem são menores que o espelho
  
  background(0);//plano de fundo preto

  if (mouseX < this.width/2) {//Espelho Concavo
    if(mouseY < this.height/2){//Imagem na parte de cima
      
      //Inicio Objeto
      stroke(255, 0, 0);//cor do Objeto
      line(pObjeto.x, pObjeto.y, pObjeto.x , this.height/2);
      line(pObjeto.x, pObjeto.y, pObjeto.x - 5, pObjeto.y + 5);
      line(pObjeto.x, pObjeto.y, pObjeto.x + 5, pObjeto.y + 5);
      //Fim Objeto
      
      pImagem.x = this.width/2 - equacaoGauss(vFoco, this.width/2 - pObjeto.x);
      vImagem = aumentoLinear(this.width/2 - pImagem.x,this.width/2 - pObjeto.x) * vObjeto;
      pImagem.y = this.height/2 + Math.abs(vImagem);
      
      pitagoras = (float) Math.sqrt(((raio*raio)-(vImagem*vImagem)));//distancia entre o centro do espelho e o ponto2
      PVector ponto2 = new PVector((pCentro.x+ pitagoras),this.height/2 - vImagem);//ponto do espelho onde o topo passa pelo foco e é refletido
      
      if(pObjeto.x<pFoco.x){//imagem antes do foco
        if(alturaMaxima>vObjeto){
          stroke(0, 255, 0);//cor das linhas de reflexão
          line(pObjeto.x, pObjeto.y, ponto1.x, ponto1.y);//topo do objeto ate espelho
          stroke(0, 255, 255);//cor das linhas de refletidas
          line(ponto1.x, ponto1.y, equacaoRetaX(ponto1.x, ponto1.y, pImagem.x, pImagem.y, this.height), this.height);
        }else{
          tamanhoCerto = false;
          text("Objeto Maior que o espelho", this.width/1.30, 65);
          stroke(0, 255, 0);//cor das linhas de reflexão
          line(pObjeto.x, pObjeto.y, this.width, equacaoRetaY(pObjeto.x, pObjeto.y, ponto1.x, ponto1.y, this.width));//topo do objeto ate espelho
        }
        
        if(alturaMaxima>-vImagem){
          stroke(0, 255, 0);//cor das linhas de reflexão
          line(pObjeto.x, pObjeto.y, equacaoRetaX(pObjeto.x, pObjeto.y, pFoco.x, pFoco.y, ponto2.y), ponto2.y);
          stroke(0, 255, 255);//cor das linhas de refletidas
          line(ponto2.x, ponto2.y, 0, equacaoRetaY(ponto2.x, ponto2.y, pImagem.x, pImagem.y, 0));//ponto 2 do espelho ate o canto
        }else{
          tamanhoCerto = false;
          text("Imagem Maior que o espelho", this.width/1.30, 80);
          stroke(0, 255, 0);//cor das linhas de reflexão
          line(pObjeto.x, pObjeto.y, equacaoRetaX(pObjeto.x, pObjeto.y, pFoco.x, pFoco.y, this.height), this.height);
        }
        
        if(tamanhoCerto){
          //Inicio Imagem
          stroke(255, 0, 0);//cor da Imagem
          line(pImagem.x, pImagem.y, pImagem.x , this.height/2);
          line(pImagem.x, pImagem.y, pImagem.x + 5, pImagem.y - 5);
          line(pImagem.x, pImagem.y, pImagem.x - 5, pImagem.y - 5);
          //Fim Imagem
          
          if(pImagem.x < pCentro.x){
            text("Imagem: virtual, Invertida e Maior", this.width/1.30, 65);
          }else if(pImagem.x >pCentro.x){
            text("Imagem: Virtual, Invertida e Menor", this.width/1.30, 65);
          }else{
            text("Imagem: Virtual, Invertida e Igual", this.width/1.30, 65);
          }
        }
        
      }else if(pObjeto.x > pFoco.x){//imagem depois do foco
        pImagem.y -= 2*vImagem;
        
        if(alturaMaxima>vObjeto){
          //Inicio Imagem
          stroke(255, 0, 0);//cor da Imagem
          line(pImagem.x, pImagem.y, pImagem.x , this.height/2);
          line(pImagem.x, pImagem.y, pImagem.x - 5, pImagem.y + 5);
          line(pImagem.x, pImagem.y, pImagem.x + 5, pImagem.y + 5);
          //Fim Imagem
            
          text("Imagem: Real, Direita e Maior", this.width/1.30, 65);
          
          stroke(0, 255, 0);//cor das linhas de reflexão
          line(pObjeto.x, pObjeto.y, ponto1.x, ponto1.y);//topo do objeto ate o ponto 1 do espelho
          line(ponto1.x, ponto1.y, pFoco.x, pFoco.y);//ponto 1 do espelho ate foco
          line(pObjeto.x, pObjeto.y, this.width/2, this.height/2);//topo do objeto ate o centro da imagem
          line(this.width/2, this.height/2, equacaoRetaX(pObjeto.x, pObjeto.y + 2*vObjeto, this.width/2, this.height/2, this.height), this.height);//centro da imagem até o canto
          
          stroke(0, 0, 255);//cor das linhas do outro lado do espelho
          line(ponto1.x, ponto1.y, pImagem.x, pImagem.y);//Ponto 1 do espelho até o topo da imagem
          line(this.width/2, this.height/2, pImagem.x, pImagem.y);//centro do espelho ate o topo da imagem
        }else{
          tamanhoCerto = false;
          stroke(0, 255, 0);//cor das linhas de reflexão
          text("Objeto Maior que o espelho", this.width/1.30, 65);
          line(pObjeto.x, pObjeto.y, this.width, equacaoRetaY(pObjeto.x, pObjeto.y, ponto1.x, ponto1.y, this.width));//topo do objeto ate o canto
          line(pObjeto.x, pObjeto.y, this.width/2, this.height/2);//topo do objeto ate o centro da imagem
          line(this.width/2, this.height/2, equacaoRetaX(pObjeto.x, pObjeto.y + 2*vObjeto, this.width/2, this.height/2, this.height), this.height);//centro da imagem até o infinito
        }
        
      }else{//Objeto em cima do foco
        if(alturaMaxima>vObjeto){
          tamanhoCerto = true;
          text("Imagem: Imprópria", this.width/1.30, 65);
          stroke(0, 255, 0);//cor das linhas de reflexo
          line(pObjeto.x, pObjeto.y, ponto1.x, ponto1.y);//topo do objeto ate o ponto 1 do espelho
          line(ponto1.x, ponto1.y, equacaoRetaX(ponto1.x, ponto1.y, pFoco.x, pFoco.y, this.height), this.height);//espelho ate o infinito
          line(pObjeto.x, pObjeto.y, this.width/2, this.height/2);//Topo do objeto ao centro da imagem
          line(this.width/2, this.height/2, equacaoRetaX(ponto1.x, ponto1.y, pFoco.x, pFoco.y, this.height)+vFoco, this.height);//centro do espelho até o infinito
        }else{
          tamanhoCerto = false;
          stroke(0, 255, 0);//cor das linhas de reflexo
          text("Objeto Maior que o espelho", this.width/1.30, 65);
          text("Ainda bem que já não ia ter imagem mesmo kk", this.width/1.30, 80);
          line(pObjeto.x, pObjeto.y, this.width, equacaoRetaY(pObjeto.x, pObjeto.y, ponto1.x, ponto1.y, this.width));//topo do objeto ate o ponto 1 do espelho
          line(pObjeto.x, pObjeto.y, this.width/2, this.height/2);//topo do objeto ate o centro da imagem
          line(this.width/2, this.height/2, equacaoRetaX(pObjeto.x, pObjeto.y + 2*vObjeto, this.width/2, this.height/2, this.height), this.height);//centro da imagem até o canto
        }
      }
      
    }else{//imagem na parte de baixo
      //Inicio Objeto
      stroke(255, 0, 0);//cor do Objeto
      line(pObjeto.x, pObjeto.y, pObjeto.x , this.height/2);
      line(pObjeto.x, pObjeto.y, pObjeto.x + 5, pObjeto.y - 5);
      line(pObjeto.x, pObjeto.y, pObjeto.x - 5, pObjeto.y - 5);
      //Fim Objeto
      
      pImagem.x = this.width/2 - equacaoGauss(vFoco, this.width/2 - pObjeto.x);
      vImagem = aumentoLinear(this.width/2 - pImagem.x,this.width/2 - pObjeto.x) * vObjeto;
      pImagem.y = this.height/2 - Math.abs(vImagem);
      
      pitagoras = (float) Math.sqrt(((raio*raio)-(vImagem*vImagem)));//distancia entre o centro do espelho e o ponto 2
      PVector ponto2 = new PVector((pCentro.x+ pitagoras),this.height/2 - vImagem);//ponto do espelho onde o topo passa pelo foco e é refletido
      
      if(pObjeto.x<pFoco.x){//imagem antes do foco
        if(alturaMaxima>-vObjeto){
          stroke(0, 255, 0);//cor das linhas de reflexão
          line(pObjeto.x, pObjeto.y, ponto1.x, ponto1.y);//topo do objeto ate espelho
          stroke(0, 255, 255);//cor das linhas de refletidas
          line(ponto1.x, ponto1.y, equacaoRetaX(ponto1.x, ponto1.y, pImagem.x, pImagem.y, 0), 0);
        }else{
          tamanhoCerto = false;
          text("Objeto Maior que o espelho", this.width/1.30, 65);
          stroke(0, 255, 0);//cor das linhas de reflexão
          line(pObjeto.x, pObjeto.y, this.width, equacaoRetaY(pObjeto.x, pObjeto.y, ponto1.x, ponto1.y, this.width));//topo do objeto ate espelho
        }
        
        if(alturaMaxima>vImagem){
          stroke(0, 255, 0);//cor das linhas de reflexão
          line(pObjeto.x, pObjeto.y, equacaoRetaX(pObjeto.x, pObjeto.y, pFoco.x, pFoco.y, ponto2.y), ponto2.y);
          stroke(0, 255, 255);//cor das linhas de refletidas
          line(ponto2.x, ponto2.y, 0, equacaoRetaY(ponto2.x, ponto2.y, pImagem.x, pImagem.y, 0));//ponto 2 do espelho ate imagem
        }else{
          tamanhoCerto = false;
          text("Imagem Maior que o espelho", this.width/1.30, 80);
          stroke(0, 255, 0);//cor das linhas de reflexão
          line(pObjeto.x, pObjeto.y, equacaoRetaX(pObjeto.x, pObjeto.y, pFoco.x, pFoco.y, 0), 0);
        }
        
        if(tamanhoCerto){
          //Inicio Imagem
          stroke(255, 0, 0);//cor da Imagem
          line(pImagem.x, pImagem.y, pImagem.x , this.height/2);
          line(pImagem.x, pImagem.y, pImagem.x - 5, pImagem.y + 5);
          line(pImagem.x, pImagem.y, pImagem.x + 5, pImagem.y + 5);
          //Fim Imagem
          
          if(pImagem.x < pCentro.x){
            text("Imagem: Virtual, Invertida e Maior", this.width/1.30, 65);
          }else if(pImagem.x >pCentro.x){
            text("Imagem: Virtual, Invertida e Menor", this.width/1.30, 65);
          }else{
            text("Imagem: Virtual, Invertida e Igual", this.width/1.30, 65);
          }
        }
        
      }else if(pObjeto.x > pFoco.x){//imagem depois do foco
        pImagem.y -= 2*vImagem;
        
        if(alturaMaxima>-vObjeto){
          //Inicio Imagem
          stroke(255, 0, 0);//cor da Imagem
          line(pImagem.x, pImagem.y, pImagem.x , this.height/2);
          line(pImagem.x, pImagem.y, pImagem.x + 5, pImagem.y - 5);
          line(pImagem.x, pImagem.y, pImagem.x - 5, pImagem.y - 5);
          //Fim Imagem
            
          text("Imagem: Real, Direita e Maior", this.width/1.30, 65);
          
          stroke(0, 255, 0);//cor das linhas de refletidas
          line(pObjeto.x, pObjeto.y, ponto1.x, ponto1.y);//topo do objeto ate o ponto 1 do espelho
          line(ponto1.x, ponto1.y, pFoco.x, pFoco.y);//espelho ate foco
          line(pObjeto.x, pObjeto.y, this.width/2, this.height/2);//topo do objeto ate o centro da imagem
          line(this.width/2, this.height/2, equacaoRetaX(pObjeto.x, pObjeto.y + 2*vObjeto, this.width/2, this.height/2, 0), 0);//centro da imagem até o canto
          
          stroke(0, 0, 255);//cor das linhas do outro lado do espelho
          line(ponto1.x, ponto1.y, pImagem.x, pImagem.y);//Ponto do espelho até o topo da imagem
          line(this.width/2, this.height/2, pImagem.x, pImagem.y);//centro do espelho ate o topo da imagem
        }else{
          tamanhoCerto = false;
          stroke(0, 255, 0);//cor das linhas de reflexão
          text("Objeto Maior que o espelho", this.width/1.30, 65);
          line(pObjeto.x, pObjeto.y, this.width, equacaoRetaY(pObjeto.x, pObjeto.y, ponto1.x, ponto1.y, this.width));//topo do objeto ate o ponto 1 do espelho
          line(pObjeto.x, pObjeto.y, this.width/2, this.height/2);//topo do objeto ate o centro da imagem
          line(this.width/2, this.height/2, equacaoRetaX(pObjeto.x, pObjeto.y + 2*vObjeto, this.width/2, this.height/2, 0), 0);//centro da imagem até o canto
        }
        
      }else{//Objeto em cima do foco
        if(alturaMaxima>-vObjeto){
          tamanhoCerto = true;
          text("Imagem: Imprópria", this.width/1.30, 65);
          stroke(0, 255, 0);//cor das linhas de reflexo
          line(pObjeto.x, pObjeto.y, ponto1.x, ponto1.y);//topo do objeto ate o ponto 1 do espelho
          line(ponto1.x, ponto1.y, equacaoRetaX(ponto1.x, ponto1.y, pFoco.x, pFoco.y, 0), 0);//espelho ate o infinito
          line(pObjeto.x, pObjeto.y, this.width/2, this.height/2);//Topo do objeto ao centro da imagem
          line(this.width/2, this.height/2, equacaoRetaX(ponto1.x, ponto1.y, pFoco.x, pFoco.y, 0)+vFoco, 0);//centro do espelho até o infinito
        }else{
          tamanhoCerto = false;
          stroke(0, 255, 0);//cor das linhas de reflexo
          text("Objeto Maior que o espelho", this.width/1.30, 65);
          line(pObjeto.x, pObjeto.y, this.width, equacaoRetaY(pObjeto.x, pObjeto.y, ponto1.x, ponto1.y, this.width));//topo do objeto ate espelho
          line(pObjeto.x, pObjeto.y, this.width/2, this.height/2);//topo do objeto ate o centro da imagem
          line(this.width/2, this.height/2, equacaoRetaX(pObjeto.x, pObjeto.y + 2*vObjeto, this.width/2, this.height/2, this.height), this.height);//centro da imagem até o canto
        }
      }
    }
  }else{//Espelho convexo
    if(mouseY < this.height/2){//Imagem na parte de cima
      
      pImagem.x = this.width/2 - equacaoGauss(vFoco, this.width/2 - pObjeto.x);
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
        line(pObjeto.x, pObjeto.y, ponto1.x, ponto1.y);//topo do objeto ate espelho
        line(pObjeto.x, pObjeto.y, this.width/2, this.height/2);//topo do objeto ate o centro do espelho
        line(this.width/2, this.height/2, this.width, equacaoRetaY(pObjeto.x, pObjeto.y + 2*vObjeto, this.width/2, this.height/2, this.width));//Reflexão do centro do espelho
        line(ponto1.x, ponto1.y, this.width, equacaoRetaY(ponto1.x, ponto1.y, pFoco.x, pFoco.y, this.width));
        
        stroke(0, 0, 255);//cor das linhas do outro lado do espelho
        line(ponto1.x, ponto1.y, pFoco.x, pFoco.y);
        line(this.width/2, this.height/2, pImagem.x, pImagem.y);
        
        //Inicio Imagem
        stroke(255, 0, 0);//cor da Imagem
        line(pImagem.x, pImagem.y, pImagem.x , this.height/2);
        line(pImagem.x, pImagem.y, pImagem.x - 5, pImagem.y + 5);
        line(pImagem.x, pImagem.y, pImagem.x + 5, pImagem.y + 5);
         //Fim Imagem
        
        text("Imagem: Real, Direita e Menor", this.width/1.30, 65);
      }else{
        tamanhoCerto = false;
        text("Objeto Maior que o espelho", this.width/1.30, 65);
        stroke(0, 255, 0);//cor das linhas de reflexão
        line(pObjeto.x, pObjeto.y, 0, equacaoRetaY(pObjeto.x, pObjeto.y,ponto1.x, ponto1.y, 0));//topo do objeto ate espelho
        line(pObjeto.x, pObjeto.y, this.width/2, this.height/2);//topo do objeto ate o centro do espelho
        line(this.width/2, this.height/2, this.width, equacaoRetaY(pObjeto.x, pObjeto.y + 2*vObjeto, this.width/2, this.height/2, this.width));//Reflexão do centro
      }
    }else{//imagem na parte de baixo
      pImagem.x = this.width/2 - equacaoGauss(vFoco, this.width/2 - pObjeto.x);
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
        line(pObjeto.x, pObjeto.y, ponto1.x, ponto1.y);//topo do objeto ate espelho
        line(pObjeto.x, pObjeto.y, this.width/2, this.height/2);//topo do objeto ate o centro do espelho
        line(this.width/2, this.height/2, this.width, equacaoRetaY(pObjeto.x, pObjeto.y + 2*vObjeto, this.width/2, this.height/2, this.width));//Reflexão do centro
        line(ponto1.x, ponto1.y, this.width, equacaoRetaY(ponto1.x, ponto1.y, pFoco.x, pFoco.y, this.width));
        
        stroke(0, 0, 255);//cor das linhas do outro lado do espelho
        line(ponto1.x, ponto1.y, pFoco.x, pFoco.y);
        line(this.width/2, this.height/2, pImagem.x, pImagem.y);
        
        //Inicio Imagem
        stroke(255, 0, 0);//cor da Imagem
        line(pImagem.x, pImagem.y, pImagem.x , this.height/2);
        line(pImagem.x, pImagem.y, pImagem.x + 5, pImagem.y - 5);
        line(pImagem.x, pImagem.y, pImagem.x - 5, pImagem.y - 5);
         //Fim Imagem
        
        text("Imagem: Real, Direita e Menor", this.width/1.30, 65);
      }else{
        tamanhoCerto = false;
        text("Objeto Maior que o espelho", this.width/1.30, 65);
        stroke(0, 255, 0);//cor das linhas de reflexo
        line(pObjeto.x, pObjeto.y, 0, equacaoRetaY(pObjeto.x, pObjeto.y,ponto1.x, ponto1.y, 0));//topo do objeto ate o canto
        line(pObjeto.x, pObjeto.y, this.width/2, this.height/2);//topo do objeto ate o centro do espelho
        line(this.width/2, this.height/2, this.width, equacaoRetaY(pObjeto.x, pObjeto.y + 2*vObjeto, this.width/2, this.height/2, this.width));//Reflexão do centro do espelho
      }
    }
  }
  
  if(tamanhoCerto){
    //centimetros = pixels
    text("Distancia entre o objeto e o espelho: " + Math.abs(this.width/2 -pObjeto.x) + " cm", this.width/1.30, 35);
    text("Distancia entre a imagem e o espelho: " + Math.abs(this.width/2 -pImagem.x) + " cm", this.width/1.30, 50);
    text("Tamanho do Objeto: " + Math.abs(vObjeto) + " cm", this.width/1.30, 80);
    text("Tamanho da Imagem: " + Math.abs(vImagem) + " cm", this.width/1.30, 95);
  }
  stroke(255, 255, 255);//cor da linha
  //Linha Horizontal
  line(0, this.height/2, this.width, this.height/2);
  
  //Centro
  line(pCentro.x, this.height/2 - 2, pCentro.x , this.height/2 + 2);
  //Foco
  line(pFoco.x, this.height/2 - 2, pFoco.x , this.height/2 + 2);
  
  //Inicio Espelho
  noFill();//preenchimento interior do arco
  stroke(204, 102, 0);//cor do arco
  arc(this.width/2 - raio, this.height/2, raio*2, raio*2, -HALF_PI/9, HALF_PI/9);//arco(Espelho) formando no máximo 10 Graus com o centro
  //Fim Espelho
  
  text("github.com/coppolaop", 5, this.height - 15);//Autor
  
  //-- Regras de Nitidez do Espelho
  //http://alunosonline.uol.com.br/fisica/condicoes-gauss-para-espelhos-esfericos.html
  //http://papofisico.tumblr.com/post/35741884495/condi%C3%A7%C3%A3o-de-nitidez-de-gauss
}