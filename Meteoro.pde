class meteoro{
  float posx;
  float posy;
  boolean ativo;
  
  public meteoro(float valX,float valY){
    posx = valX;
    posy = valY;
    ativo = true;
  }
  
  public void toggleAtivo(){
    ativo = !ativo;
  }
  
}
