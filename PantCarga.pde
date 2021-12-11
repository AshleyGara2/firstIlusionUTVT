//PantCarga
//Elaborado por: Ashley Galicia Ramirez
//Fecha de creación: 20 de septiembre de 2021
//fecha de ultima modificación: 28 de noviembre de 2021
//comentario: Es la primer pantalla que se va a mostrar, cuenta con mensaje 
//y un sprite en forma de pila que simula que esta cargando

class PantCarga{ 
  boolean loading;    //cargando
  CoolDownTimer cdt;  //Clase CoolDownTimer
  SpriteSet cristal;  //El sprite 
  String message;     //Mensaje mostrar en la pantalla
  PImage carga;      //Imagen de fondo
  
  PantCarga(){
    loading=true;
    cdt=new CoolDownTimer(120);
    carga=loadImage("sprite/backgr/carga.png");
    cristal=new SpriteSet("sprite/pila/","cristal",".png",5,20,true,0);
    message=lf.showString(26);
  }
  
  void display(){
    background(carga);
    fill(255);
    imageMode(CENTER);
    cristal.display(350,250,cf.sp,cf.sp);
    textAlign(CENTER,CENTER);
    text(lf.showString(6),350,350);
    text(message,350,400);
    if(!loading && !cdt.isActive())
      cdt.activate();
    if(cdt.isActive())
      cdt.coolingDown();
    if(cdt.isOff())
      gc.setPantAct(PNINT);
  }
}
