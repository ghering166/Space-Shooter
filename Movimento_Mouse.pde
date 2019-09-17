void CriaNaveMouse() // renderização da nave utlilizando as coordenadas do ponteiro
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
