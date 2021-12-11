//GameControl
//Elaborado por: Ashley Galicia Ramirez
//Fecha de creación: 20 de septiembre de 2021
//fecha de ultima modificación: 3 de diciembre de 2021
/*Comentario: GameControl se utiliza para poder controlar las pantallas y
la música que se va a colocar en el videojuego, con esto podemos hacer una
selección de la pantalla que se valla colocando haciendo el cambio al presionar
las teclas de la computadora
*/
class GameControl{  
  PantCarga pncrg; //variable que hace referencia a la clase de Pantalla de carga
  PantCombate pncbt;  //variable que hace referencia a la clase de Pantalla de combate
  PantConfig pncfg;  //variable que hace referencia a la clase de Pantalla de configuracion
  PantCreacion pncre;  //variable que hace referencia a la clase de Pantalla de creacion
  PantCreditos pncrd;  //variable que hace referencia a la clase de Pantalla de creditos
  PantFinJgo pnfin;  //variable que hace referencia a la clase de Pantalla de fin del juego
  PantIntro pnint;  //variable que hace referencia a la clase de Pantalla de intro
  PantLvlUp pnlvl;  //variable que hace referencia a la clase de Pantalla de level up
  PantMapa pnmap;  //variable que hace referencia a la clase de Pantalla de mapa
  PantPausa pnpau;  //variable que hace referencia a la clase de Pantalla de pausa
  PantTienda pntnd;  //variable que hace referencia a la clase de Pantalla de tienda
  int pantact; // variable para saber en que pantalla estas 
  boolean musicon; // musica activa o no
  
  GameControl(){
    pncrg=new PantCarga();
    pncbt=new PantCombate();
    pncfg=new PantConfig();
    pncre=new PantCreacion(cf);
    pncrd=new PantCreditos();
    pnfin=new PantFinJgo();
    pnint=new PantIntro();
    pnlvl=new PantLvlUp();
    pnmap=new PantMapa();
    pnpau=new PantPausa();
    pntnd=new PantTienda();
    pantact=PNCRG; // se inicia con la pantalla de carga
    musicon=MSCOFF; // la musica esta apagada 
  }
  
  void display(){
    switch(pantact){ // se hara un switch atravez de las pantallas, con la variable de pantalla activa, se ira haciendo el cambio
      case PNCRG: pncrg.display(); //pantalla de carga
                  break;
      case PNCBT: pncbt.display(); //pantalla de combate
                  break;
      case PNCFG: pncfg.display();//pantalla de configuracion
                  break;
      case PNCRE: pncre.display();//pantalla de creacion
                  break;
      case PNCRD: pncrd.display(); //pantalla de creditos
                  break;
      case PNFIN: pnfin.display(); //pantalla de fin
                  break;
      case PNINT: pnint.display(); //pantalla de intro
                  break; 
      case PNLVL: pnlvl.display(); //pantalla de level up
                  break; 
      case PNMAP: pnmap.display(); //pantalla de mapa
                  break;
      case PNPAU: pnpau.display(); //pantalla de pausa
                  break;
      case PNTND: pntnd.display(); //pantalla de tienda
                  break;
    }
  }
  
  void sigPant(){ //funcion para ir avanzando de pantalla
    pantact++;
    if(pantact==12) // si el numero de pantalla llega a 12, entonces la pantalla activa valdra 1 que es la pantalla de intro
      pantact=1;
  }
 
  void antPant(){  //funcion para poder regresar de pantalla 
    pantact--;
    if(pantact==0) // si la pantalla es igual a 0 te direcciona a la equivalente a 11
      pantact=11; // pantalla activa = patalla de tienda
  }
  
  void setPantAct(int p){
    pantact=p;
  }
  
  void mouseProcess(int x,int y, int b){
    switch(pantact){ // se hace un mecanismo de seleccion dependiendo de la tecla que se oprima
      case PNCBT: pncbt.mouseProcess(x,y,b);
                  break;
      case PNCFG: pncfg.mouseProcess(x,y,b);
                  break;            
      case PNCRD: pncrd.mouseProcess(x,y,b);
                  break;  
      case PNCRE: pncre.mouseProcess(x,y,b);
                  break;
      case PNFIN: pnfin.mouseProcess(x,y,b);
                  break;            
      case PNINT: pnint.mouseProcess(x,y,b);
                  break;
      case PNLVL: pnlvl.mouseProcess(x,y,b);
                  break;            
      case PNMAP: pnmap.mouseProcess(x,y,b);
                  break;            
      case PNPAU: pnpau.mouseProcess(x,y,b);
                  break;
      case PNTND: pntnd.mouseProcess(x,y,b);
                  break;            
      default:    if(b==LEFT) // si se presiona la tecla de la izquierda se ejecutara la funcion para avanzar de pantalla
                    sigPant();
                  if(b==RIGHT) // si se presiona la tecla de la derecha se ejecutara la funcion para avanzar de pantalla
                    antPant();
    }  
  }
  
  void keyProcess(char k){
    switch(pantact){ // se hace un mecanismo de seleccion con la pantalla activa
      case PNMAP: pnmap.keyProcess(k); //pantalla de mapa
                  break;
      case PNTND: pntnd.keyProcess(k); //pantalla de tienda
                  break;            
    }
  }
   
   void musicManager(boolean s,boolean v){ // se crea la funcion para colocar la musica 
    musicon=s;
    playTrack((musicon?pantact:0),v);
  }
  
  void playTrack(int t,boolean v){
    if(t==PNCBT)/*msccombt.loop();else{msccombt.pause();msccombt.rewind();}*/
      if(!v)
        msccombt.loop();
      else
        mscfanfr.loop();
    else{
      msccombt.pause();
      msccombt.rewind();
      mscfanfr.pause();
      mscfanfr.rewind();
    }
    if(t==PNCRD)msccreds.loop();else{msccreds.pause();msccreds.rewind();}
    if(t==PNCRE)msccrea.loop();else{msccrea.pause();msccrea.rewind();}
    if(t==PNFIN)
      if(v)
        mscvctry.loop();
      else
        mscdefet.loop();
    else{    
      mscvctry.pause();
      mscvctry.rewind();
      mscdefet.pause();
      mscdefet.rewind();
    } 
    if(t==PNINT)mscintro.loop();else{mscintro.pause();mscintro.rewind();}
    if(t==PNLVL)msclvlup.loop();else{msclvlup.pause();msclvlup.rewind();}
    if(t==PNMAP)mscmundo.loop();else{mscmundo.pause();mscmundo.rewind();}
    if(t==PNTND)mscstore.loop();else{mscstore.pause();mscstore.rewind();}
  }
  
  boolean getMusicStatus(){ // depende del boolean true or false  se activa la musica 
    return musicon;
  }
}
