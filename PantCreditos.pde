//PantCreditos
//Elaborado por: Ashley Galicia Ramirez
//Fecha de creación: 20 de septiembre de 2021
//fecha de ultima modificación: 27 de noviembre de 2021
//comentario: Este modulo muestra un video al cargar la pantalla

class PantCreditos{ 
  boolean movieactive;  //video
  Boton btnback;        //Boton de regresar
  
  PantCreditos(){
    movieactive=false;
    btnback=new Boton(600,600,200,100,5);
    btnback.activate();
  }
  
  void display(){
    if(!movieactive){
      credits.loop();
      movieactive=true;
    }
    //music();
    background(0);
    image(credits,350,350);
    btnback.display();
  }
  
  void mouseProcess(int x,int y,int b){
    if(btnback.isClicked(x,y) && b==LEFT){
      credits.stop();
      movieactive=false;
      gc.musicManager(MSCOFF,false);
      gc.setPantAct(PNINT);
    } 
  }  
}
