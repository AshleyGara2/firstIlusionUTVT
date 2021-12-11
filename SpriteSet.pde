  //SpriteSet
//Elaborado por: Ashley Galicia Ramirez
//Fecha de creación: 18 de octubre de 2021
//fecha de ultima modificación: 29 de noviembre de 2021
//comentario:
class SpriteSet{
  PImage sprt[]; //imagen del sprite
  String frmt;   //Formato
  String ruta;   //Ruta donde esta alojado
  String nomb;   //Nombre
  int size;      //tamaño
  int frc;       //
  int frl;       //
  int spr;       //
  boolean onan;  //Animacion encedida
  
  SpriteSet(String r,String n,String f,int s,int fl,boolean oa, int sp){
    ruta=r;
    nomb=n;
    frmt=f;
    size=s;
    frc=0;
    frl=fl;
    spr=sp;
    onan=oa;
    sprt=new PImage[size];
    for(int i=0;i<size;i++)
      sprt[i]=loadImage(ruta+nomb+i+frmt);
  }
  
  void controlAnimacion(){
    if(frc==frl){
      if(spr<size-1)
        spr++;
      else
        spr=0;
      frc=0;
    }
    else
      frc++;
  }
  
  void setSprite(int s){
    spr=s;
  }
  
  PImage getSprite(int s){
    return sprt[s];
  }
  
  void display(int x,int y,int w,int h){
    image(sprt[spr],x,y,w,h);
    if(onan)
      controlAnimacion();
  }
  
  void flipDisplay(int x,int y,int w,int h){
    pushMatrix();
    scale(-1,1);
    image(sprt[spr],-x,y,w,h);
    popMatrix();
    if(onan)
      controlAnimacion();
  }
  
  void toggleAnimacion(){
    onan=!onan;
  }
}
