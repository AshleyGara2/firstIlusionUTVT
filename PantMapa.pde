//PantMapa
//Elaborado por: Ashley Galicia Ramirez
//Fecha de creación: 20 de septiembre de 2021
//fecha de ultima modificación: 3 de diciembre de 2021
/*En esta función se crea el mapa, se colocan las imágenes de agua,
bosque, pasto y tierra, se le añade la animación de las nubes y el blur,
en esto también se agregan los contadores de la poción, full poción, puntos de vida,
barra de vida, etc y también se crean funciones para el tipo de mapa que se visualizara y
las funciones que tendrá el personaje en el mapa y en la tienda con el uso de las teclas del compuador.
*/
class PantMapa{
  int mapa[][];  //la variable mapa hace referencia al arreglo en donde se colocaran las imagenes que formaran el mapa
  int tile[][];  //lozetas
  char bord[][]; //borde
  int mx=10; //variable para la longitud del mapa en el eje x
  int my=10; //variable para la longitud del mapa en el eje y
  PImage imgsky; // imagen del cielo
  PImage imgcloud; //imagen de las nubes 
  PImage imgblur; //imagen blur 
  PImage imgtree3D;//Imagen alrbol
  PImage imgcact3D;//imagen cactus
  PImage imgflwr3D;//imagen flor
  ClickItem citpotn; // se coloca el item de la pocion
  ClickItem citfpot; //item de la ful pocion
  int clouds[][]; //variable para colocar las nubes
  boolean blur; // variable para el blurr
  boolean map=false; //variable map en false
  
  //Variables para las imagenes 
  SpriteSet ssfw;
  SpriteSet ssfp;
  SpriteSet ssfd;
  SpriteSet ssbw;
  SpriteSet ssbp;
  SpriteSet ssbd;
  SpriteSet ssba;
  int xi;
  int yi;
  
  PantMapa(){
    mapa=ml.getMap();
    tile=ml.getTileMap();
    bord=ml.getBordMap();
    mx=ml.getCols()-10;
    my=ml.getRows()-10;
    imgsky=loadImage("sprite/sky.jpg");
    imgcloud=loadImage("sprite/cloud with shadow.png");
    imgblur=loadImage("sprite/backgr/blur.jpg");
    imgtree3D=loadImage("sprite/terreno/tree3D.png");
    imgcact3D=loadImage("sprite/terreno/cact3D.png");
    imgflwr3D=loadImage("sprite/terreno/flwr3D.png");
    ssfw=new SpriteSet("sprite/terreno/flora/woods/","tree3D",".png",4,0,false,0);
    ssfp=new SpriteSet("sprite/terreno/flora/prairie/","flwr3D",".png",4,0,false,0);
    ssfd=new SpriteSet("sprite/terreno/flora/desert/","cact3D",".png",4,0,false,0);
    ssbw=new SpriteSet("sprite/terreno/bords/woods/","bosque",".png",46,0,false,0);
    ssbp=new SpriteSet("sprite/terreno/bords/prairie/","prairie",".png",46,0,false,0);
    ssbd=new SpriteSet("sprite/terreno/bords/desert/","desert",".png",46,0,false,0);
    ssba=new SpriteSet("sprite/terreno/bords/water/","agua",".png",46,0,false,0);
    citpotn=new ClickItem(580,640,cf.sp,cf.sp,ITPTN); //se pone el item de la posion, con su posicion en la pantalla
    citfpot=new ClickItem(630,640,cf.sp,cf.sp,ITFPT);  //se pone el item de la posion, con su posicion en la pantalla
    citpotn.toggleActive();
    citfpot.toggleActive();
    blur=false;
    clouds=new int[5][3];
    for(int i=0;i<5;i++){ //se hace un ciclo for para que las nubes vayan apareciendo en diferentes partes del mapa 
      clouds[i][0]=-160-int(random(1,300));
      clouds[i][1]=int(random(40,700));
      clouds[i][2]=int(random(2,5));
    }
  }
  
  void display(){
    music(); //funcion de musica que se encuentra en el archivo principal
    background(0);
    fill(255);
    textAlign(CENTER,CENTER);
    text(lf.showString(14),350,100);
    rectMode(CENTER);
    imageMode(CENTER);
    xi=(pers.px<=4)?0:(pers.px<ml.getCols()-5)?pers.px-5:mx;
    yi=(pers.py<=4)?0:(pers.py<ml.getRows()-5)?pers.py-5:my;
    displayPlanoMapa();
    displayPlanoPers();
    displayPlanoSky();
    displayPlanoHUD();
  }
  
  void displayPlanoMapa(){
    for(int i=0;i<10;i++)
      for(int j=0;j<10;j++)
        if(gmode){
          if(mapa[yi+j][xi+i]==CLTND)
            image(terreno[mapa[yi+j][xi+i]],cf.hs+i*cf.ss,cf.hs+j*cf.ss);
          else  
            image(getBord(mapa[yi+j][xi+i],ml.getBordIndex(bord[yi+j][xi+i])),cf.hs+i*cf.ss,cf.hs+j*cf.ss);
        }  
        else{
          setFillStroke(paleta[mapa[yi+j][xi+i]]);
          rect(cf.hs+i*cf.ss,cf.hs+j*cf.ss,cf.ss,cf.ss);
        }
  }
  
  PImage getBord(int t, int b){
    PImage i=null;
    switch(t){
            case CLBSQ: i=ssbw.getSprite(b); break;
            case CLPST: i=ssbp.getSprite(b); break;
            case CLAWA: i=ssba.getSprite(b); break;
            case CLTRR: i=ssbd.getSprite(b);
          }
    return i;
  }
  
  void displayPlanoPers(){
    efecto3D(PRE);
    pers.display(); // hace referencia a la funcion display que esta en personaje
    efecto3D(POST);
  }
  
  void efecto3D(boolean e){
    int ir=pers.yr*10+pers.xr;
    int xl;
    int yl;
    int p=(e?0:ir+1);
    if(gmode)
      while(p<(e?ir:100)){
        xl=p%10;
        yl=p/10;
        if(mapa[yi+yl][xi+xl]!=CLAWA && mapa[yi+yl][xi+xl]!=CLTND){
          switch(mapa[yi+yl][xi+xl]){
            case CLBSQ: image(ssfw.getSprite(tile[yi+yl][xi+xl]),cf.hs+xl*cf.ss,cf.hs+yl*cf.ss); break;
            case CLPST: image(ssfp.getSprite(tile[yi+yl][xi+xl]),cf.hs+xl*cf.ss,cf.hs+yl*cf.ss); break;
            case CLTRR: image(ssfd.getSprite(tile[yi+yl][xi+xl]),cf.hs+xl*cf.ss,cf.hs+yl*cf.ss);
          }
        }
        p++;
      }
  }
  
  void displayPlanoSky(){// se dibuja el plano del cielo dependiendo el modo de juego
    if(gmode){
      tint(255,64);
      image(imgsky,350,350);
      noTint();
      displayClouds();
    }  
  }
  
  void displayPlanoHUD(){ //funcion para colocar lo que se tiene en cuanto a dinero, pociones, defenda, ataque, y puntos de vida
    image(imgcash,50,640);
    image(imgatk,130,640);
    image(imgdef,210,640);
    image(imghpm,290,640);
    citpotn.display();
    citfpot.display();
    image(imgtonic,680,640);
    fill(255);
    text("$"+pers.cash,50,680);
    text(pers.atk,130,680);
    text(pers.def,210,680);
    text(pers.potn,580,680);
    text(pers.fpot,630,680);
    text(pers.tonic,680,680);
    textAlign(LEFT,CENTER);
    text(pers.hp+"/"+pers.hpp,315,640);
    text("XP:"+pers.exp,440,640);
    text("LVL:"+pers.lvl,440,680);
    pers.drawLifeBar(265,668,true);
    textAlign(CENTER,CENTER);
  }
  
  void displayClouds(){ //se hace el ciclo for para poder colocar nubes de forma aleatoria en diferentes lugares de la pantalla
    for(int i=0;i<5;i++){
      image(imgcloud,clouds[i][0],clouds[i][1]);
      clouds[i][0]+=clouds[i][2];
      if(clouds[i][0]>900){
        clouds[i][0]=-160-int(random(1,300));
        clouds[i][1]=int(random(40,700));
        clouds[i][2]=int(random(2,5));
      }
    }
  }
  
  void mouseProcess(int x,int y,int b){ // funcion para utilizar las pociones 
    if(citpotn.isClicked(x,y) && b==LEFT)
      drinkItem(ITPTN);
    if(citfpot.isClicked(x,y) && b==LEFT)
      drinkItem(ITFPT);
  }
  
  void keyProcess(char k){
    switch(k){ // sistema de seleccion con las teclas de la computadora 
      case 'e':
      case 'E': drinkItem(ITPTN); //si se preciona la letra e (mayuscula o minuscula) se consume una pocion
                break;
      case 'r':
      case 'R': drinkItem(ITFPT); //si se preciona la letra r (mayuscula o minuscula) se consume una full pocion
                break;          
      case 'g':
      case 'G': gmode=!gmode; //si se preciona la letra g (mayuscula o minuscula) cambia el modo de juego
                break;
      case 'w':
      case 'W': if(revisaRestringido(pers,UP)) //el personaje sube en el mapa
                  move(UP);
                break;
      case 'a':
      case 'A': if(revisaRestringido(pers,LEFT)) //el personaje se mueve a la izquierda
                  move(LEFT);
                break;
      case 's':
      case 'S': if(revisaRestringido(pers,DOWN))  //el personaje se mueve hacia abajo
                  move(DOWN);
                break;
      case 'd':
      case 'D': if(revisaRestringido(pers,RIGHT))  //el personaje se mueve a la derecha
                  move(RIGHT);
                break;
      case 'q':
      case 'Q': toggleBlur();
                tint(255,128);
                image(imgblur,350,350);
                noTint();
                gc.setPantAct(PNPAU);
                break;
      case ' ': if(mapa[pers.py][pers.px]==CLTND){ //si se presiona la barra de espacio te envia a la tienda, siempre y cuando estes en ubicado en la tienda
                  gc.musicManager(MSCOFF,false);
                  gc.setPantAct(PNTND);
                }  
    }
  } 
  
  void drinkItem(int i){ //funcion para consumir los item cuando sean mayor a 0
    if((i==ITPTN?pers.potn:pers.fpot)>0)
      pers.consumeItem((i==ITPTN?ITPTN:ITFPT));
      sfxdrink.trigger();
  }
  
  boolean revisaRestringido(Personaje p,int d){ //funcion para que el personaje no revase los limites del mapa en diferentes posiciones, en este caso si equivale a agua
    boolean r=false;
    switch(d){
      case UP:    r=mapa[p.py-1][p.px]!=CLAWA;
                  break;
      case DOWN:  r=mapa[p.py+1][p.px]!=CLAWA;
                  break;
      case LEFT:  r=mapa[p.py][p.px-1]!=CLAWA;
                  break;
      case RIGHT: r=mapa[p.py][p.px+1]!=CLAWA;
                  break;         
    }
    return r;
  }
  
  void move(int d){ // si se mueve dentro del mapa se tomara el tipo de terreno dependiendo del lugar en el que este ubicari, ya sea bosque o desierto, se hace un compate
    pers.move(d);
    pers.setTerrain(mapa[pers.py][pers.px]);
    if(generaCombate()){
      sfxfight.trigger();
      gc.musicManager(MSCOFF,false);
      gc.setPantAct(PNCBT);
    }  
  }
  
  boolean generaCombate(){
    boolean r=false;
    if(pers.cbtc==0){
      switch(pers.terr){
        case CLBSQ: r=random(1,100)<cf.bsqodd;
                    break;
        case CLPST: r=random(1,100)<cf.pstodd;
                    break;
        case CLTRR: r=random(1,100)<cf.trrodd;
      }
      pers.cbtc=cf.cbtcool;
    }  
    return r;
  }
  
  void toggleBlur(){
    blur=!blur;
  }
}
