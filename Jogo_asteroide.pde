PImage asteroide;
PImage nave;
PImage missel;
PImage GanhouFundo;
PImage PerdeuFundo;
PImage NeutroFundo;
PFont Fonte;
//definição das imagens e fontes

int num = 2; //Quantidade de asteroides
float [] x=new float[num];
float [] y=new float[num];



int quant = 6;// Quantidade máxima de misséis que podem ter na tela
float [] x1=new float[quant];
float [] y1=new float[quant];


boolean [] tiro=new boolean[quant];
// booleanos que mantem conta dos tiros que estão ativos

boolean [] criado=new boolean[num];
// booleanos que mantem conta dos meteoros que estão ativos
boolean perdeu = false;
boolean ganhou = false;
boolean neutro = true; //jogo ainda não acabou
int cont=20; // número de asteroides destruidos
float acelerador = 1.5; // velocidade do asteroide
int dificuldade = 1;
void setup(){
  background(255,255,255);
  noCursor();
  size(900,550);
  nave = loadImage("diferente_nave.png");
  asteroide = loadImage("novo_asteroide.png");
  missel = loadImage("diferente_missel.png");
  Fonte = loadFont("Impact-48.vlw");
  NeutroFundo = loadImage("espaço.png");
  PerdeuFundo = loadImage("Impacto.png");
  GanhouFundo = loadImage("atmosfera.png");
  
  for(int i=0;i<num;i++)
  {criado[i]=false; 
  }
  
  tiro[0]=tiro[1]=tiro[2]=false;
  textFont(Fonte);
  
}

void draw(){
  if(ganhou) // Geração da tela de vitória
  {
    GanhouFundo.resize(width,height);
    image(GanhouFundo,0,0);
    textSize(36);
    text("VOCÊ SALVOU O PLANETA !!!",width/2-190,height/2-160);

  }
  else if(perdeu) //Geração da tela de derrota
  {
    PerdeuFundo.resize(width,height);
    image(PerdeuFundo,0,0);
    textSize(36);
    text("O PLANETA FOI DESTRUIDO !!!",width/2-195,height/2+160);
  }
  else //A tela de jogabilidade
  {
   NeutroFundo.resize(width,height);
   image(NeutroFundo,0,0);
    fill(255,255,255);
   text(cont,10,50);
  }
 for(int i=0;i<num;i++)
 {
   if(!criado[i] && !ganhou && !perdeu && cont!=1)
   {
    x[i]=random(20,520);
    y[i]=0;
    asteroide.resize(60,60);
    image(asteroide,x[i],y[i]);
    criado[i] = true;
   }
 }
 for(int i=0;i<num;i++)
 {
   if(criado[i])
   {
     y[i]+=acelerador;
     asteroide.resize(60,60);
    image(asteroide,x[i],y[i]);
   }
 }
 
 //Cria a nave
 if(neutro)
 {
   CriaNave();
 }
 //Checa se os tiros atingiram o limite da tela
   for(int i = 0;i<quant;i++)
   {
     if(y1[i]<=-20)
       tiro[i] = false;
   }
   
 //Atualiza a posição dos tiros feitos
 for(int i = 0;i<quant;i++)
 {
  MoveTiro(i);
 }
 //Checagem de colisão dos tiros com os asteroides
 
  ChecaImpacto();
 
 //Checagem de vitória 
 if(cont==0  )
 {
   ganhou=true;
   neutro = false;
   for(int k = 0;k<quant;k++)
        {
          tiro[k]=false;
        }
   for(int i=0;i<num;i++)
    {
      criado[i]=false;
    }
 }
 //Aumenta velocidade do asteroide depois que alguns são destruidos
 if(cont==14 && dificuldade == 1)
 {
   acelerador+=0.4;
   dificuldade++;
 }
 else if(cont==9 && dificuldade == 2)
 {
   acelerador+=0.3;
   dificuldade++;
 }
 //Checa derrota caso o asteroide chegue ao limite da tela
 for(int i = 0;i<num;i++)
 {
   if( ( (y[i]+40)>=height) && !ganhou )
   {
     println(i);
      perdeu = true; 
      neutro = false;
      for(int k = 0;k<quant;k++)
        {
          tiro[k]=false;
        }
      for(int j=0;j<num;j++)
        {
            criado[j]=false;
        }
      break;
    
   }
 }
 
 
}

void ChecaImpacto() 
{
  for(int i = 0;i<quant;i++)
 {
     for(int j = 0;j<num;j++)
     {
      if(y1[i]<=(y[j]+60) && y1[i]>=y[j] && x1[i]<=(x[j]+60) && x1[i]>=(x[j]-59))
       {
        tiro[i]=false;
        criado[j]=false;
        cont--;
       }
     }
 }
}

void MoveTiro(int T) // Atualiza posição do míssel
{
  if(tiro[T])
   {
    y1[T]-= 4.0;
    missel.resize(20,20);
    image(missel,x1[T],y1[T]);
   }
}

void mouseClicked(){
  if(neutro)
  {
    ChecaTiro(quant);
  }
}

void ChecaTiro(int ind) // Verifica se existe um míssel que ainda não foi disparado e o renderiza
{
 for(int i=0;i<ind;i++)
 {
  if(!tiro[i])
    {
     x1[i] = (mouseX-10);
     y1[i] = mouseY-20;
     missel.resize(20,20);
     image(missel,x1[i],y1[i]);
     tiro[i] = true;
     break;
    }
 }
}

void keyPressed(){
 if (keyCode == ENTER && neutro!=true){ 
   ganhou = false;
   perdeu = false;
   neutro = true;
   cont = 20;
   
   delay(2000);
 }
}

void CriaNave() // renderização da nave utlilizando as coordenadas do ponteiro
{
  if(mouseX<=40 || mouseX>=(width-40))
 {
   if(mouseX<=40)
   {nave.resize(80,80);
   image(nave,0,mouseY);
   }
   else
   {nave.resize(80,80);
   image(nave,width-80,mouseY);
   }
 }
 
 else
 {
   nave.resize(80,80);
   image(nave,mouseX-40,mouseY);
 }
}
