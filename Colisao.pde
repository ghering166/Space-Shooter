void ChecaColisao() 
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
