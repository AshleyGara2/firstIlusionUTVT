//Boton
//Elaborado por: Ashley Galicia Ramirez
//Fecha de creación: 27 de septiembre de 2021
//fecha de ultima modificación: 29 de noviembre de 2021
//comentario:En este modulo se pasan las propiedades que tendran los botones
//como por ejemplo la posicion en la pantalla, ancho y alto, si esta activo y/o marcado

class Boton{
  int cx;    //posicion en x
  int cy;    //posicion en y
  int an;    //ancho del boton
  int al;    //alto del boton
  int t;     //texto
  int ra;    //radio de las esquinas del boton
  boolean active; //true=visible false=invisible
  boolean marked; //Si el boton esta marcado(true o false)
    
  Boton(int x,int y,int b, int a, int s){
    cx=x;
    cy=y;
    an=b;
    al=a;
    t=s;
    ra=15;
    active=false;
    marked=false;
  }
  
  void display(){
    if(active){
      rectMode(CENTER);
      if(cbtn.actColor==CLBTNT)
        setFillStroke(COLBTNFACE,COLBTNBRDR);
      else
        setFillStroke(COLBTNFACF,0);
      rect(cx,cy,an,al,ra);
      fill(255);
      textAlign(CENTER,CENTER);
      text(lf.showString(t),cx,cy);
      if(marked){
        noFill();
        stroke(COLMKGRN);
        strokeWeight(10);
        rect(cx,cy,an,al);
        strokeWeight(1);
      }
    }
  }
  void activate(){
    active=true;  
  }
  
  void deactive(){
    active=false;
  }
  
  void toggle(){
    active=!active;
  }
  
  void toggleMarked(){
    marked=!marked;
  }
  
  boolean isClicked(int x,int y){
    boolean r=(active && (((x>=cx-(an/2))&&(x<=cx+(an/2))) && ((y>=cy-(al/2))&&(y<=cy+(al/2)))));
    if(r)
      sfxclick.trigger();
    return r;    
  } 
  
  
}
