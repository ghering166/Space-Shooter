PImage GanhouFundo;
PImage PerdeuFundo;
PImage NeutroFundo;

void CriaCenario(){
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
}
