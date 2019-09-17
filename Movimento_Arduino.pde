

void ChecaMovimentoArduino(){
 if(horizontal>600 || horizontal<400 )
 {
   if(horizontal>600)
   {
     vx+=1;
     println(vx);
   }
   else
   {
     vx-=1;
   }
 }
 if(vertical >650 || vertical<400)
 {
   if(vertical>650)
     vy-=1;
   else
     vy+=1;
 } 
  
}
