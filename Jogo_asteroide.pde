import processing.serial.*;
import cc.arduino.*;
Arduino arduino;

PImage asteroide;
PImage nave;
PImage missel;
PFont Fonte;
//definição das imagens e fontes

//variaveis utilizadas no modo arduino

float vx,vy; //valores de velocidade usados na movimentação por arduino
int horizontal = 0; // coordenada horizontal do analogico do arduino
int vertical = 0; // coordenada vertical do analogico do arduino


int num = 2; //Quantidade de asteroides
ArrayList<meteoro> meteoros = new ArrayList<meteoro>();
float [] x=new float[num];
float [] y=new float[num];



int quant = 6;// Quantidade máxima de misséis que podem ter na tela
ArrayList<Missel> estoque = new ArrayList<Missel>();
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
  
  /* //Entradas do arduino
  
  arduino = new Arduino(this, Arduino.list()[4], 57600);
  arduino.pinMode(3,Arduino.INPUT);
  horizontal = arduino.analogRead(0);
  vertical = arduino.analogRead(1);
  atira = arduino.digitalRead(3);
  */
  
  nave = loadImage("diferente_nave.png");
  asteroide = loadImage("novo_asteroide.png");
  missel = loadImage("diferente_missel.png");
  Fonte = loadFont("Impact-48.vlw");
  NeutroFundo = loadImage("espaço.png");
  PerdeuFundo = loadImage("Impacto.png");
  GanhouFundo = loadImage("atmosfera.png");
  
  for(int i=0;i<quant;i++){
    estoque.add(new Missel());
  }
  
  for(int i=0;i<num;i++)
  {criado[i]=false; 
  }
  
  tiro[0]=tiro[1]=tiro[2]=false;
  textFont(Fonte);
  
}

void draw(){
 CriaCenario();
 
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
   CriaNaveMouse();
 }
   
 //Atualiza a posição dos tiros feitos
 for(int i = 0;i<quant;i++)
 {
  MoveTiro(i);
 }
 //Checagem de colisão dos tiros com os asteroides
 
  ChecaColisao();
 
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



void MoveTiro(int T) // Atualiza posição do míssel
{
   //Checa se os tiros atingiram o limite da tela
  if(y1[T]<=-20)
       tiro[T] = false;
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
  /* //Uso de stack para guardar misseis ainda nao disparados
  if(estoque.size()!=0){
    int quantidade = estoque.size();
    Missel objeto = estoque.get(quantidade-1);
    objeto.toggleAtivo();
    objeto.posX = mouseX-10;
    objeto.posY = mouseY-20;
    estoque.remove(quantidade-1);
  }
  */
  
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
