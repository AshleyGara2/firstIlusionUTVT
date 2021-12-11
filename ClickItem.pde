//modulo ClickItem
//Elaborado por: Ashley Galicia Ramirez
//Fecha de creación: 08 de noviembre de 2021
//fecha de ultima modificación: 27 de noviembre de 2021
//comentario:Se crea para poder colocar los ítems que se venderán
//o compraran en la tienda, las pociones y tónicos. 

class ClickItem{
  int cx; // variable para eje x
  int cy; // variable para eje y 
  int an; // Ancho
  int al; // alto
  int t;  //texto
  boolean active; // true or false para saber si esta activo el item
  boolean marked; // true or false para saber si lo marcaron
    
  ClickItem(int x,int y,int b, int a, int s){
    cx=x;
    cy=y;
    an=b;
    al=a;
    t=s;
    active=false;
    marked=false;
  }
  
  void display(){
    textAlign(CENTER,CENTER);
    if(active)
      image(getItemImage(t),cx,cy,an,al); //se coloca la imagen del item con su texto  
      if(marked){
        noFill(); // transparente
        stroke(color(0,250,0)); // se especifica el color 
        strokeWeight(6); // espesor de las lineas 
        rect(cx,cy,an,al); //se dibuja un rectangulo
        strokeWeight(1); // espesor de la linea 
      }
  }
  
  PImage getItemImage(int i){
    PImage p=null;
    switch(i){
      case ITPTN: p=imgpotn; break;
      case ITFPT: p=imgfpot; break;
      case ITTNC: p=imgtonic; break;
      case ITATK: p=imgatk; break;
      case ITDEF: p=imgdef; break;
      case ITHPP: p=imghpm;
    }
    return p;
  }
  
  void toggleActive(){
    active=!active;
  }
  
  void toggleMarked(){
    marked=!marked;
  }
  
  boolean isClicked(int x,int y){
    boolean r=active && ((x>=cx-(an/2))&&(x<=cx+(an/2))) && ((y>=cy-(al/2))&&(y<=cy+(al/2))); // se realiza para colocar los botones en su posicion 
    return r;    
  }
}
