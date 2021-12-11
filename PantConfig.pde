//PantConfig
//Elaborado por: Ashley Galicia Ramirez
//Fecha de creación: 20 de septiembre de 2021
//fecha de ultima modificación: 27 de noviembre de 2021
//comentario:

class PantConfig{
  //Botones a mostrar en pantalla
  Boton btnidio;
  Boton btnacep;
  Boton btnback;
  Boton btnccol;  //Este boton se agrego para cambiar de color los botones
  
  PantConfig(){
    btnidio=new Boton(550,250,200,100,3);
    btnacep=new Boton(250,500,200,100,4);
    btnback=new Boton(550,500,200,100,5);
    btnccol=new Boton(250,250,200,100,38); //Se le agrego su mensaje que tendra
    btnidio.activate();
    btnacep.activate();
    btnback.activate();
    btnccol.activate();
  }
  
  void display(){
    background(imgbackgr);
    fill(255);
    text(lf.showString(8),350,100);
    btnidio.display();
    btnacep.display();
    btnback.display();
    btnccol.display();
  }
  
  void mouseProcess(int x,int y,int b){
    if(btnidio.isClicked(x,y) && b==LEFT){
      int newlang=(lf.getLang()==LGSPA)?LGENG:LGSPA;
      lf.setLang(newlang);
    }  
    if(btnacep.isClicked(x,y) && b==LEFT)
      cf.saveConfig(lf);  
    if(btnback.isClicked(x,y) && b==LEFT)
      gc.setPantAct(PNINT);  
      
   //En este if al dar click en el boton hace un cambio de color
    if(btnccol.isClicked(x,y) && b==LEFT){
      cbtn.toggleColor();
    }

  }
}
