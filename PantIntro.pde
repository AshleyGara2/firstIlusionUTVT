//PantIntro
//Elaborado por: Ashley Galicia Ramirez
//Fecha de creación: 20 de septiembre de 2021
//fecha de ultima modificación: 26 de noviembre de 2021
/*Comentario: Este modulo permite visualizar cuatro botones los cuales
son el de creditos, configurar, jugar y salir, estos botones permiten 
realizar diferentes acciones
*/

class PantIntro{
  Boton btncred;  //Boton creditos
  Boton btnconf;  //Boton configuración
  Boton btnplay;  //Boton jugar
  Boton btnexit;  //Boton salir
    
  PantIntro(){
    btncred=new Boton(350, 150, 200, 90, 0);
    btnconf=new Boton(350, 300, 200, 90, 1);
    btnplay=new Boton(350, 450, 200, 90, 2);
    btnexit=new Boton(350, 600, 200, 90, 23);
    btncred.activate();
    btnconf.activate();
    btnplay.activate();
    btnexit.activate();
  }
  
  void display(){
    music();
    background(imgbackgr);
    fill(255);
    text(lf.showString(12),350,50);
    btncred.display();
    btnconf.display();
    btnplay.display();
    btnexit.display();
  }
  
  void mouseProcess(int x,int y,int b){
    if(btncred.isClicked(x,y) && b==LEFT){
      gc.musicManager(MSCOFF,false);
      gc.setPantAct(PNCRD);
    }  
    if(btnconf.isClicked(x,y) && b==LEFT)
      gc.setPantAct(PNCFG);
    if(btnplay.isClicked(x,y) && b==LEFT){
      gc.musicManager(MSCOFF,false);
      gc.setPantAct(PNCRE);
    }  
    if(btnexit.isClicked(x,y) && b==LEFT){
      bitacora.cierraBitacora();
      exit();
    }  
  }
}
