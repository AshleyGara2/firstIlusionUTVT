//Pantalla nivel
//Elaborado por: Ashley Galicia Ramirez
//Fecha de creación: 20 de septiembre de 2021
//fecha de ultima modificación: 28 de noviembre de 2021
/*Comentario: Muestra una pantalla de subir nivel con los items de ataque,
defensa y puntos de vida. Al dar click en cualquier item cambia a la oantalla
de mapa o de fin de juego
*/

class PantLvlUp{
  ClickItem citatk;  //Item ataque
  ClickItem citdef;  //Item defensa
  ClickItem cithpm;  //Item puntos de vida
  PImage imglvlup;   //Imagen de fondo
  
  PantLvlUp(){
    citatk=new ClickItem(150,270,cf.sp*2,cf.sp*2,ITATK);
    citdef=new ClickItem(350,270,cf.sp*2,cf.sp*2,ITDEF);
    cithpm=new ClickItem(550,270,cf.sp*2,cf.sp*2,ITHPP);
    citatk.toggleActive();
    citdef.toggleActive();
    cithpm.toggleActive();
    imglvlup=loadImage("sprite/backgr/creation.png");
  }
  
  void display(){
    music();
    background(imglvlup);
    fill(255);
    text(lf.showString(13),350,50);
    citatk.display();
    citdef.display();
    cithpm.display();
    textAlign(CENTER,CENTER);
    text(pers.atk,150,335);
    text(pers.def,350,335);
    text(pers.hpm,550,335);
  }
  
  void mouseProcess(int x,int y, int b){
    if(citatk.isClicked(x,y) && b==LEFT){
      addAttr(ATATK);
    }  
    if(citdef.isClicked(x,y) && b==LEFT){
      addAttr(ATDEF);
    }
    if(cithpm.isClicked(x,y) && b==LEFT){
      addAttr(ATHPM); 
    }  
  }
  
  void addAttr(int a){
    pers.addAttr(a);
    sfxheal.trigger();
    gameresult=pers.lvl==cf.lvlfin;
    gc.musicManager(MSCOFF,gameresult);
    gc.setPantAct(!gameresult?PNMAP:PNFIN);
  }
}
