//PantCreacion
//Elaborado por: Ashley Galicia Ramirez
//Fecha de creación: 20 de septiembre de 2021
//fecha de ultima modificación: 28 de noviembre de 2021
//comentario:En este modulo se muestran los botones para aumentar o disminuir
//los valores de ataque, defensa, puntos de vida, las pociones cada uno con su 
//sprite correspondiente

class PantCreacion{
  Boton btnatkp;    //Boton de ataque plus
  Boton btndefp;    //Boton de defensa plus
  Boton btnhpmp;    //Boton de puntos de vida plus
  Boton btnatkm;    //Boton de ataque menos
  Boton btndefm;    //Boton de defensa menos
  Boton btnhpmm;    //Boton de puntos de vida menos
  Boton btnexit;    //Boton de 
  Boton btnplay;    //Boton de jugar
  ClickItem citpotn;  //imagen de poción
  ClickItem citfpot;  //imagen de poción
  ClickItem cittonic; //imagen de tonico
  
  PImage imgcreat;  //Imagen de fondo de la pantalla
  int itemsleft;    //Items por elegir
  int ppa;          //puntos por asignar
  int minatr;     //valor minimo de atributos
  int maxatr;     //valor maximo de atributos
  boolean rst;    //variable para reiniciar la pantalla
  int atk;        //puntos de ataque
  int def;        //puntos de defensa
  int hpm;        //puntos de vida
    
  PantCreacion(ConfigFile cf){
    btnatkp=new Boton(630,250,cf.sp,cf.sp,17);
    btnatkm=new Boton(200,250,cf.sp,cf.sp,18);   
    btndefp=new Boton(630,310,cf.sp,cf.sp,17);
    btndefm=new Boton(200,310,cf.sp,cf.sp,18);
    btnhpmp=new Boton(630,370,cf.sp,cf.sp,17);
    btnhpmm=new Boton(200,370,cf.sp,cf.sp,18);
    btnexit=new Boton(200,600,200,100,5);
    btnplay=new Boton(500,600,200,100,2);
    btnatkp.activate();
    btnatkm.activate();
    btndefp.activate();
    btndefm.activate();
    btnhpmp.activate();
    btnhpmm.activate();
    btnexit.activate();
    citpotn=new ClickItem(250,440,cf.sp,cf.sp,ITPTN);
    citfpot=new ClickItem(350,440,cf.sp,cf.sp,ITFPT);
    cittonic=new ClickItem(450,440,cf.sp,cf.sp,ITTNC);
    citpotn.toggleActive();
    citfpot.toggleActive();
    cittonic.toggleActive();
    imgcreat=loadImage("sprite/backgr/creation.png");
    ppa=cf.ppa;
    itemsleft=2;
    atk=def=hpm=minatr=cf.minatr;
    maxatr=cf.maxatr;
    rst=false;
  }
  
  void display(){
    music();
    if(rst){
      resetAttr();
      rst=false;
    }
    background(imgcreat);
    fill(255);
    btnatkp.display();
    btnatkm.display();
    btndefp.display();
    btndefm.display();
    btnhpmp.display();
    btnhpmm.display();
    btnexit.display();
    btnplay.display();
    citpotn.display();
    citfpot.display();
    cittonic.display();
    textAlign(CENTER,CENTER);
    text(lf.showString(9),350,100);
    text(lf.showString(22)+ppa,350,500);
    text(lf.showString(33)+itemsleft,350,530);
    textAlign(LEFT,CENTER);
    text(lf.showString(19),50,250);
    text(lf.showString(20),50,310);
    text(lf.showString(21),50,370);
    imageMode(CENTER);
    for(int i=0;i<atk;i++)
      image(imgatk,260+50*i,250);
    for(int i=0;i<def;i++)
      image(imgdef,260+50*i,310);
    for(int i=0;i<hpm;i++)
      image(imghpm,260+50*i,370);
  }
  
  void mouseProcess(int x,int y, int b){
    if(btnatkp.isClicked(x,y) && b==LEFT)
      addPoint(ATATK);
    if(btnatkm.isClicked(x,y) && b==LEFT)
      subPoint(ATATK);
    if(btndefp.isClicked(x,y) && b==LEFT)
      addPoint(ATDEF);
    if(btndefm.isClicked(x,y) && b==LEFT)
      subPoint(ATDEF);
    if(btnhpmp.isClicked(x,y) && b==LEFT)
      addPoint(ATHPM);
    if(btnhpmm.isClicked(x,y) && b==LEFT)
      subPoint(ATHPM);
    if(citpotn.isClicked(x,y) && b==LEFT && (itemsleft>0 ||(citpotn.marked && itemsleft==0))){
      citpotn.toggleMarked();
      sfxclick.trigger();
      itemsleft+=citpotn.marked?-1:1;
      playGoes();
    }
    if(citfpot.isClicked(x,y) && b==LEFT && (itemsleft>0 ||(citfpot.marked && itemsleft==0))){
      citfpot.toggleMarked();
      sfxclick.trigger();
      itemsleft+=citfpot.marked?-1:1;
      playGoes();  
    }
    if(cittonic.isClicked(x,y) && b==LEFT && (itemsleft>0 ||(cittonic.marked && itemsleft==0))){
      cittonic.toggleMarked();
      sfxclick.trigger();
      itemsleft+=cittonic.marked?-1:1;
      playGoes();
    }
    if(btnexit.isClicked(x,y) && b==LEFT){
      rst=true;
      gc.musicManager(MSCOFF,false);
      gc.setPantAct(PNINT);
    }
    if(btnplay.isClicked(x,y) && b==LEFT){
      pers=new Personaje(atk,def,hpm,cf.cash,cf.stx,cf.sty);
      if(citpotn.marked) pers.potn++;
      if(citfpot.marked) pers.fpot++;
      if(cittonic.marked) pers.tonic++;
      rst=true;
      gc.musicManager(MSCOFF,false);
      gc.setPantAct(PNMAP);
    }
  } 
    
  void addPoint(int a){
    if(ppa>0 && getAttr(a)<maxatr){
      modAttr(a,ATUP);
      ppa--;
    }
    playGoes();
  }
    
  void subPoint(int a){
    if(getAttr(a)>minatr){
      modAttr(a,ATDN);
      ppa++;
    }
    playGoes();
  }
  
  int getAttr(int a){
    return (a==ATATK)?atk:(a==ATDEF)?def:hpm;
  }
  
  void modAttr(int a, boolean e){
    switch(a){
      case ATATK: atk+=(e)?1:-1;
                  break;
      case ATDEF: def+=(e)?1:-1;
                  break;
      case ATHPM: hpm+=(e)?1:-1;
                  break;
    }
  }
  
  void playGoes(){
    if(ppa==0 && itemsleft==0)
      btnplay.activate();
    else
      btnplay.deactive();
  }
  
  void resetAttr(){
    btnplay.deactive();
    ppa=cf.ppa;
    itemsleft=2;
    atk=def=hpm=minatr;
    if(citpotn.marked)citpotn.toggleMarked();
    if(citfpot.marked)citfpot.toggleMarked();
    if(cittonic.marked)cittonic.toggleMarked();
  }
}
