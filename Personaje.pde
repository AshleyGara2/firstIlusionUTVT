//Modulo de Personaje
//Elaborado por: Ashley Galicia Ramirez
//Fecha de creación: 11 de octubre de 2021
//fecha de ultima modificación: 3 de diciembre de 2021
/*Comentario: Muestra las propiedades del personaje como los puntos de vida
defensa, experiencia, barra de vida. Tambien indica acciones que
realiza durante el combate y al moverse dentro del mapa 
*/

class Personaje{
  int atk;  //puntos de ataque
  int def;  //puntos de defensa
  int hp;   //puntos de vida actuales
  int hpm;  //puntos de vida máximo (nivel)
  int hpp;  //puntos de vida máximo (puntos)
  int wpn;  //arma
  int shl;  //escudo
  int dir;  //hacia donde mira
  int exp;  //experiencia acumulada
  int lvl;  //nivel del personaje
  int px;   //posición x en el mapa
  int py;   //posición y en el mapa
  int xr;   //posición relativa en x
  int yr;   //posición relativa en y
  int cx;   //posición x en combate
  int cy;   //posición y en combate
  int terr; //indica el terreno que pisa el personaje
  int cash; //cuanto dinero tiene el personaje
  boolean alive;  //personaje vive o muere
  boolean defactive;  //Defensa activa
  int explimit;    //Experiencia del nivel
  int tonicd;      //tonico de defensa
  Enemigo enemy;   //clase Enemigo
  CoolDownTimer cdtturn;  //clase CoolDownTimer
  //Clase SpriteSet para cargar los sprite correspondientes
  SpriteSet ssdown;
  SpriteSet ssdownlvl;
  SpriteSet ssleft;
  SpriteSet ssleftlvl;
  SpriteSet ssright;
  SpriteSet ssrightlvl;
  SpriteSet ssup;
  SpriteSet ssuplvl;
  AnimationStructure as;
  //inventario
  int potn;
  int fpot;
  int tonic;
  int mx;
  int my;
  int cbtc;
  
  Personaje(int a,int d,int h,int c,int x,int y){
    mx=ml.getCols()-5;
    my=ml.getRows()-5;
    atk=a;
    def=d;
    hpm=h;
    hp=hpp=cf.hp*hpm;
    exp=0;
    explimit=cf.explup;
    lvl=cf.lvlini;
    dir=DOWN;
    px=x;
    py=y;
    cx=600;
    cy=350;
    terr=CLPST;
    cash=c;
    potn=0;
    fpot=0;
    tonic=0;
    alive=LIVE;
    tonicd=0;
    cbtc=cf.cbtcool;
    defactive=false;
    cdtturn=new CoolDownTimer(cf.cdtplayr);
    ssdown=new SpriteSet("sprite/personaje/worldmove/down/","down",".png",2,10,true,0);
    ssdownlvl=new SpriteSet("sprite/personaje/worldmove/downlvl/","down",".png",2,10,true,0);
    ssleft=new SpriteSet("sprite/personaje/worldmove/left/","left",".png",2,10,true,0);
    ssleftlvl=new SpriteSet("sprite/personaje/worldmove/leftlvl/","left",".png",2,10,true,0); 
    ssright=new SpriteSet("sprite/personaje/worldmove/right/","right",".png",2,10,true,0);
    ssrightlvl=new SpriteSet("sprite/personaje/worldmove/rightlvl/","right",".png",2,10,true,0);
    ssup=new SpriteSet("sprite/personaje/worldmove/up/","up",".png",2,10,true,0);
    ssuplvl=new SpriteSet("sprite/personaje/worldmove/uplvl/","up",".png",2,10,true,0);
    as=new AnimationStructure();
    as.addSpriteSet(new SpriteSet("sprite/personaje/tonico/tonic1/","tonicX",".png",2,6,true,0));
    as.addSpriteSet(new SpriteSet("sprite/personaje/tonico/tonic2/","tonicX",".png",2,6,true,0));
    as.addSpriteSet(new SpriteSet("sprite/personaje/tonico/tonic3/","tonicX",".png",2,6,true,0));
    as.addSpriteSet(new SpriteSet("sprite/personaje/tonico/tonic4/","tonicX",".png",2,6,true,0));
  }
  
  void display(){
    xr=(px<=4)?px:(px<=mx)?5:px%10;
    yr=(py<=4)?py:(py<=my)?5:py%10;
    if(gmode){
      switch(dir){
        case DOWN:
            if(lvl==10)
              ssdown.display(cf.hs+xr*cf.ss,cf.hs+yr*cf.ss,cf.ss,cf.ss);
            else 
              ssdownlvl.display(cf.hs+xr*cf.ss,cf.hs+yr*cf.ss,cf.ss,cf.ss);
            break;
        case UP:    
            if(lvl==10)
              ssup.display(cf.hs+xr*cf.ss,cf.hs+yr*cf.ss,cf.ss,cf.ss); 
            else 
              ssuplvl.display(cf.hs+xr*cf.ss,cf.hs+yr*cf.ss,cf.ss,cf.ss);
            break;
        
        case LEFT:  
            if(lvl==10)
              ssleft.display(cf.hs+xr*cf.ss,cf.hs+yr*cf.ss,cf.ss,cf.ss);
            else 
              ssleftlvl.display(cf.hs+xr*cf.ss,cf.hs+yr*cf.ss,cf.ss,cf.ss);
            break;
        case RIGHT:
            if(lvl==10)
              ssright.display(cf.hs+xr*cf.ss,cf.hs+yr*cf.ss,cf.ss,cf.ss);
            else 
              ssrightlvl.display(cf.hs+xr*cf.ss,cf.hs+yr*cf.ss,cf.ss,cf.ss);
            break;
        
      }  
    }
    else{
      setFillStroke(COLPERS);
      circle(cf.hs+xr*cf.ss,cf.hs+yr*cf.ss,cf.ss);
    }
  }
  
  void battleDisplay(){
    if(gmode){
      ssleft.display(cx,cy,cf.ss,cf.ss);
      if(tonicd>0){
        as.setActiveSpriteSet(tonicd-1);
        as.display(cx,cy,cf.ss,cf.ss);
      }
    }
    else{
      setFillStroke(COLPERS);
      circle(cx,cy,cf.ss);
      if(tonicd>0){
        noFill();
        stroke(COLMKGRN);
        strokeWeight(3*tonicd);
        circle(cx,cy,cf.ss);
        strokeWeight(1);
      }
    }
    //fill(255);
    //text("Ashley personaje",cx,430);
    drawLifeBar(cx-cf.ss,cy+45,false);
    cdtturn.drawTimeBar(cx-cf.ss,cy+60); 
  }
  
  void setBPos(int x,int y){
    cx=x;
    cy=y;
  }
  
  void move(int d){
    dir=d;
    switch(dir){
      case UP:    py--;
                  if(cbtc>0) cbtc--;
                  break;
      case DOWN:  py++;
                  if(cbtc>0) cbtc--;
                  break;
      case LEFT:  px--;
                  if(cbtc>0) cbtc--;
                  break;
      case RIGHT: px++;
                  if(cbtc>0) cbtc--;         
    }
  }
  
  void moveB(int d){
    switch(d){
      case LEFT:  cx--;
                  break;
      case RIGHT:
    }
  }
  
  void setTerrain(int t){
    terr=t;
  }
  
  void drawLifeBar(int x,int y,boolean c){
    rectMode(CORNER);
    setFillStroke(0);
    rect(x,y,160,(c?28:14));
    setFillStroke(COLBLOOD);
    rect(x+(c?2:1),y+(c?2:1),int((hp*1.0/hpp)*156),(c?24:12));
    rectMode(CENTER);
  }
  
  void drawTradeData(){
    image(imgcash,150,420);
    image(imgpotn,250,420);
    image(imgfpot,350,420);
    image(imgtonic,450,420);
    fill(255);
    text("$"+cash,150,450);
    text(potn,250,450);
    text(fpot,350,450);
    text(tonic,450,450);
    textAlign(CENTER,CENTER);
  }
  
  int getItemInv(int i){
    return (i==ITPTN?potn:(i==ITFPT?fpot:tonic));
  }
  
  void updateInv(int i,boolean tm){
    switch(i){
      case ITPTN: potn+=tm?1:-1;break;
      case ITFPT: fpot+=tm?1:-1;break;
      case ITTNC: tonic+=tm?1:-1;break;
    }
  }
  
  void activateCombat(){
    cdtturn.activate();
  }
  
  boolean hasItems(){
    return potn>0 || fpot>0 || tonic>0;
  }
  
  void consumeItem(int i){
    switch(i){
      case ITPTN: potn--;
                  healPers();
                  break;
      case ITFPT: fpot--;
                  fullHealPers();
                  break;
      case ITTNC: tonic--;
                  activateTonic();
                  break;            
    }
    sfxdrink.trigger();
  }
  
  void healPers(){
    hp=(hp+cf.heal<hpp)?hp+cf.heal:hpp;
  }
  
  void fullHealPers(){
    hp=hpp;
  }
  
  void activateTonic(){
    tonicd=cf.tonicd;
    as.setActiveSpriteSet(tonicd);
  }
  
  void herida(int d){
    hp-=hp-d>0?d:hp;
    alive=hp>0;
  }
  
  boolean isAlive(){
    return alive;
  }
  
  int getAtkDamage(){
    return (atk+(tonicd>0?cf.tonicb:0))*cf.patkf;
  }
  
  int getDefDamage(){
    return (def+(tonicd>0?cf.tonicb:0)+(defactive?1:0))*cf.pdeff;
  }
  
  void coolTonic(){
    if(tonicd>0){
      tonicd--;
      as.prevSpriteSet();
    }  
  }
  
  void toggleDefense(){
    defactive=!defactive;
  }
  
  void addAttr(int a){
    switch(a){
      case ATATK: atk++; break;
      case ATDEF: def++; break;
      case ATHPM: hpm++; hp=hpp+=cf.hp;
    }
    exp-=explimit;
    explimit+=cf.expinc;
    lvl++;
  }
}
