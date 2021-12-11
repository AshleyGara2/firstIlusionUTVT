//PantPausa
//Elaborado por: Ashley Galicia Ramirez
//Fecha de creación: 20 de septiembre de 2021
//fecha de ultima modificación: 22 de noviembre de 2021
/*Comentario: Al abrir la pantalla de pausa se muestra dos botones,
uno es de salir el otro de continuar
*/

class PantPausa{
  Boton btnexit;  //Boton de salir
  Boton btncont;  //Boton de continuar o regresar
  
  PantPausa(){
    btnexit=new Boton(200,600,200,90,23);
    btncont=new Boton(500,600,200,90,5);
    btnexit.activate();
    btncont.activate();
  }
  
  void display(){
    fill(255);
    text(lf.showString(15),350,100);
    btnexit.display();
    btncont.display();
  }
  
  void mouseProcess(int x,int y,int b){
    if(btnexit.isClicked(x,y) && b==LEFT){
      gc.musicManager(MSCOFF,false);
      gc.setPantAct(PNINT);
    }
    if(btncont.isClicked(x,y) && b==LEFT){
      gc.pnmap.toggleBlur();
      gc.setPantAct(PNMAP); 
    }  
  }
}
