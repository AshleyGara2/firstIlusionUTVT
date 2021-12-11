//color boton
//Elaborado por: Ashley Galicia Ramirez
//Fecha de creación: 07 de diciembre de 2021
//fecha de ultima modificación: 08 de diciembre de 2021
//comentario: Permite a los botones cambiar de color
class ColorBoton{
  int actColor; //colorActivo
  int colorC;   //Cambio color
  
 ColorBoton(){
   actColor=CLBTNF;
   loadColorBoton(CLBTNF);
   loadColorBoton(CLBTNT);
 }
 
 void loadColorBoton(int c){
    colorC=(c==CLBTNF)?CLBTNF:CLBTNT;    
  }
  
  //Hace la accion de cambiar el color actual
  void toggleColor(){
    actColor=(actColor==CLBTNF)?CLBTNT:CLBTNF;
  }
  
}
