//PantCombate
//Elaborado por: Ashley Galicia Ramirez
//Fecha de creación: 20 de septiembre de 2021
//fecha de ultima modificación: 4 de diciembre de 2021
/*comentario: En este modulo se programa las acciones del personaje y el enemigo
  dentro del combate, controla en que fase esta la batalla y activar o desactuvar botones
*/

class PantCombate{
  PImage pasto;          //Imagen terreno pasto
  PImage desrt;          //Imagen terreno decierto
  PImage woods;          //Imagen terreno bosque          
  Boton btnback;         //Boton regresar
  Boton btnatk;          //Boton ataque
  Boton btndef;          //Boton defensa
  Boton btnitem;         //Boton item
  
  //Bloque de las pociones
  ClickItem citpotn;
  ClickItem citfptn;
  ClickItem citfpot;
  ClickItem cittonic;
  
  int fasebatalla;       //fase en la que esta la pantalla
  boolean battleactive;  //Batalla activa
  boolean actionactive;  //Acccion activa
  boolean combatactive;  //Combate activo
  boolean playrlocked;   //jugador bloqueado
  boolean enemylocked;   //enemigo bloqueado
  Enemigo enemy;         //Clase Enemigo
  CoolDownTimer cdt;     //Tiempo de espera
  CoolDownTimer cdte;    //Tiempo de espera del enemigo
  CoolDownTimer cdtp;    //Tiempo de espera del personaje 
 
  boolean turn;          //Turno del personaje
  boolean result;        //Resultado
  boolean intro;         //Intro 
  boolean onesc;
  boolean enemydead;    //Enemigo muerto o no
  boolean critic;       //La tirada es critica
  
  int decay;            //Disminuir el tinte
  int action;           //Accion de los personajes
  int cost;             //Costo
  PImage escimg;        //Imagen
  SpriteSet sscrit;     //Sprite en tirada critica
    
  boolean mensaje;       //Mensaje dependiendo la tirada
  int tirada;            //Valor de la tirada
  int i=0;              //Numero de muertos
  int cash;
      
  PantCombate(){
    pasto=loadImage("sprite/backgr/pasto_ok.png");
    desrt=loadImage("sprite/backgr/desierto_ok.png");
    woods=loadImage("sprite/backgr/bosque_ok.png");
    btnback=new Boton(350,600,200,90,23);
    btnatk=new Boton(150,500,150,80,30);
    btndef=new Boton(350,550,150,80,31);
    btnitem=new Boton(550,500,150,80,32);
    citpotn=new ClickItem(500,625,cf.sp,cf.sp,ITPTN);
    citfptn=new ClickItem(550,625,cf.sp,cf.sp,ITFPT);
    cittonic=new ClickItem(600,625,cf.sp,cf.sp,ITTNC);
    //btnback.activate();
    battleactive=BATTLEOFF;
    actionactive=ACTOFF;
    combatactive=false;
    intro=false;
    onesc=false;
    enemydead=false;
    decay=0;
    critic=false;
    mensaje=false;
    cdt=new CoolDownTimer(180);
    cdte=new CoolDownTimer(120);
    cdtp=new CoolDownTimer(120);
    sscrit=new SpriteSet("sprite/critic/","critic",".png",3,10,true,0);
  }
    
  void display(){
    music();
    startBattle();
    selectBackgr(pers.terr);
    //fill(255);
    //text(lf.showString(7),400,100);
    controlCombate();
    displayPlanoControl();
    displayPlanoBatalla();
    displayPlanoHUD();
    if(actionactive && turn){
      cdtp.coolingDown();
    }
    if(actionactive && cdtp.isOff()){
      cdtp.deactivate();
      endAction();
    }
    if(actionactive && !turn){
      cdte.coolingDown();
    }
    if(actionactive && cdte.isOff()){
      cdte.deactivate();
      enemyEndAction();
    }
  }
  
  void selectBackgr(int t){
    switch(t){
      case CLBSQ: background(woods);
                  break;
      case CLPST: background(pasto);
                  break;
      case CLTRR: background(desrt);
                  break;            
    }
  }
  
  void startBattle(){ //inicio de batalla
    if(!battleactive){
      fasebatalla=FBINTRO;
      battleactive=BATTLEON;
      pers.setBPos(700,350);
      createEnemies();
    }  
  }
  
  void displayCritic(){ //Si la tirada es mayor a 12 pinta un sprite critico
    sscrit.display(enemy.cx,enemy.cy-enemy.sprite.height-60,200,100);
  }  
  
  //Se agrego el mensaje dependiendo del valor de la tirada del personaje
  void mensajeHerida(){
    if(tirada<=6){
      fill(255);
      text(lf.showString(37),200,250);
    }
    if(tirada>6 && tirada<=11){
      fill(255);
      text(lf.showString(36),200,250);
    }
  }
  
  void displayPlanoBatalla(){
    pers.battleDisplay();
    if(mensaje)
      mensajeHerida();
    if(critic)
      displayCritic();
    displayEnemies();
  }
  
  void displayPlanoHUD(){
    if(onesc){
      fill(255);
      text("-"+cost,350,100);
      image(escimg,350,60);
    }
  }
  
  void displayPlanoControl(){
    btnback.display();
    btnatk.display();
    btndef.display();
    btnitem.display();
    citpotn.display();
    citfptn.display();
    cittonic.display();
  }
  
  void displayEnemies(){ //Pinta el personaje, si muero lo difumina
    if(enemydead){
      tint(255,255-decay);
      decay+=3;
      enemy.display();
      noTint();
    }
    else
      enemy.display();
    
  }
  
  void mouseProcess(int x,int y,int b){ //acciones dependiendo el boton que se de click
    if(btnback.isClicked(x,y) && b==LEFT){
      loseLoot();
      fasebatalla=FBESC;
    }
    if(actionactive && btnatk.isClicked(x,y) && b==LEFT){
      btnatk.toggleMarked();
      combatAction(ACATK);
      iniciaAccion();
    }
    if(actionactive && btndef.isClicked(x,y) && b==LEFT){
      btndef.toggleMarked();
      combatAction(ACDEF);
      iniciaAccion();
    }
    if(actionactive && btnitem.isClicked(x,y) && b==LEFT && pers.hasItems()){
      btnitem.toggleMarked();
      if(pers.potn>0)
        citpotn.toggleActive();
      if(pers.fpot>0)  
        citfptn.toggleActive();
      if(pers.tonic>0)  
        cittonic.toggleActive();
      combatAction(ACITM);
    }
    if(actionactive && citpotn.isClicked(x,y) && b==LEFT)
      accionConsumo(ITPTN);
    if(actionactive && citfptn.isClicked(x,y) && b==LEFT)
      accionConsumo(ITFPT);
    if(actionactive && cittonic.isClicked(x,y) && b==LEFT)
      accionConsumo(ITTNC);
  }
  
  void accionConsumo(int i){ //Consume las pociones
    pers.consumeItem(i);
    bitacora.agregaDatosLn(registraConsumoItem(pers,i));
    iniciaAccion();
  }
  
  void controlCombate(){ //Permite saber en que fase se encuentra la batalla y dependiendo realiza diferentes acciones
    switch(fasebatalla){
      case FBINTRO: controlEspera();
                    enemy.move(RIGHT);
                    pers.moveB(LEFT);
                    enemySnd();
                    break;
      case FBCOMBT: iniciaBatalla();
                    controlAcciones();
                    //timeBattle(true);
                    break;
      case FBEND:   if(!enemy.isAlive() && !enemydead)
                      enemydead=true;
                    controlEspera();
                    //timeBattle(false);
                    break;
      case FBEXIT:  resetBattle();
                    cambiaPantalla();
                    break;
      case FBESC:   controlEspera();
    }
  }
  
  void combatAction(int a){ //Combate dependiendo el boton que se de click,el de ataque tiene mas acciones
    int atkp;
    int defe;
    //int tirada;
    action=a;
    switch(action){
      case ACATK: tirada=td.tira2D6();
                  //println("mensaje tirada->"+tirada);
                  critic=td.isHiCritic();
                  mensaje=true;
                  atkp=pers.getAtkDamage()+tirada+(critic?cf.critdmg:0);
                  defe=enemy.getDefDamage();
                  if(atkp>defe){
                    enemy.herida(atkp-defe);
                    bitacora.agregaDatosLn(registraAccionCombate(enemy,pers,tirada,TURNP));
                    sfxsword.trigger();
                    if(!enemy.isAlive()){
                      enemy.playSfx(ENFXDED);
                      resultVictory();                      
                    }
                  }
                  else
                    bitacora.agregaDatosLn(registraAccionCombate(enemy,pers,tirada,TURNP));
                  break;
      case ACDEF: pers.toggleDefense();
    }
    cdt.activate();
  }
  
  void createEnemies(){
    enemy=new Enemigo(pers.terr,dcbt); 
    enemy.setPos(0,350);
  }
  
  void toggleAction(){
    actionactive=!actionactive;
  }
  
  void iniciaAccion(){
    if(!cdtp.isActive()){
      cdtp.activate();
      setTurn(TURNP);
    }  
  }
  
  void controlEspera(){
    if(!cdt.isActive()){
      cdt.activate();
    }
    if(cdt.isActive()){
      cdt.coolingDown();
    }  
    if(cdt.isOff()){
      
      cdt.deactivate();
      if(critic)
        critic=false;
      if(mensaje)
        mensaje=false;
      if(fasebatalla==FBESC){
        resetBattle();
        gc.musicManager(MSCOFF,false);
        gc.setPantAct(PNMAP);
      }
      else
        fasebatalla=nextFB();
    }  
  }
 
  void iniciaBatalla(){
    
    if(!combatactive){
      combatactive=true;
      turn=TURNP;
      pers.activateCombat();
      enemy.activateCombat();
      playrlocked=false;
      enemylocked=false;
      
      bitacora.agregaDatosLn(registraInicioCombate(enemy,pers));
    }

  }
  //Se intento agregar el tiempo de batalla sin exito :(
  void timeBattle(boolean t){
    if(t){
      int m;
      m=0;
      m=millis();
      fill(0);
      text(m/1000,350,100);
      println("tiempo->"+m/1000);
    }
  }
  
  void controlAcciones(){
    if(pers.cdtturn.isActive()){
      pers.cdtturn.coolingDown();
    }  
    if(pers.cdtturn.isOff() && !enemylocked){
      enemy.cdtturn.togglePause();
      pers.cdtturn.deactivate();
      toggleEnemyLocked();
      btnatk.activate();
      btndef.activate();
      btnitem.activate();
      toggleAction();
    }
    if(enemy.cdtturn.isActive()){
      enemy.cdtturn.coolingDown();
    }  
    if(enemy.cdtturn.isOff() && !playrlocked){
      pers.cdtturn.togglePause();
      enemy.cdtturn.deactivate();
      togglePlayrLocked();
      toggleAction();
      iniciaEnemyAction();
    }
  }
  
  int nextFB(){
    return fasebatalla==FBINTRO?FBCOMBT:fasebatalla==FBCOMBT?FBEND:FBEXIT;
  }
  
  void cambiaPantalla(){
    gc.musicManager(MSCOFF,result);
    gc.setPantAct(result?(pers.exp>=pers.explimit?PNLVL:PNMAP):PNFIN);
  }
  
  void toggleEnemyLocked(){
    enemylocked=!enemylocked;
  }
  
  void togglePlayrLocked(){
    playrlocked=!playrlocked;
  }
  
  void iniciaEnemyAction(){
    if(!cdte.isActive()){
      cdte.activate();
      setTurn(TURNE);
      enemyAction();
    }
  }
  
  void enemyAction(){
    int tirada=td.tira2D6();
    int atke=enemy.getAtkDamage()+tirada;
    int defp=pers.getDefDamage();
    if(atke>defp){
      pers.herida(atke-defp);
      enemy.playSfx(ENFXATK);
      if(!pers.isAlive()){
        resultDefeat();
        sfxdeath.trigger();
      }
      else
        if(pers.hp*1.0/pers.hpp<cf.lowhealth){
          btnback.activate();
        }
    }
    else
      sfxshild.trigger();
    bitacora.agregaDatosLn(registraAccionCombate(enemy,pers,tirada,TURNE));  
    if(pers.defactive)
      pers.toggleDefense();
  }
  
  void endAction(){
    btnatk.deactive();
    btndef.deactive();
    btnitem.deactive();
    toggleMarks();
    pers.cdtturn.activate();
    toggleAction();
    enemy.cdtturn.togglePause();
    toggleEnemyLocked();
    if(critic)
      critic=false;
    if(mensaje)
      mensaje=false;
    if(pers.tonicd>0)
      pers.coolTonic();
  }
  
  void enemyEndAction(){
    enemy.cdtturn.activate();
    pers.cdtturn.togglePause();
    togglePlayrLocked();
    if(critic)
      critic=false;
    if(mensaje)  
      mensaje=false;
    toggleAction();
  }
  
  void setTurn(boolean t){
    turn=t;
  }
  
  void toggleMarks(){ //Marca o desmarca los diferentes botones
    switch(action){
      case ACATK: btnatk.toggleMarked(); break;
      case ACDEF: btndef.toggleMarked(); break;
      case ACITM: btnitem.toggleMarked();
                  if(citpotn.active) citpotn.toggleActive();
                  if(citfptn.active) citfptn.toggleActive();
                  if(cittonic.active) cittonic.toggleActive();
    }
  }
   
  void resetBattle(){ //Al finalizar la batalla ya sea ganando o perdiendo, regresa todas la propiedades a sus valores iniciales
    pers.cdtturn.deactivate();
    enemy.cdtturn.deactivate();
    pers.tonicd=0;
    cdt.deactivate();
    cdtp.deactivate();
    cdte.deactivate();
    btnback.deactive();
    btnatk.deactive();
    btndef.deactive();
    btnitem.deactive();
    battleactive=BATTLEOFF;
    combatactive=false;
    playrlocked=false;
    enemylocked=false;
    actionactive=ACTOFF;
    fasebatalla=FBINTRO;
    setTurn(TURNP);
    intro=false;
    onesc=false;
    enemydead=false;
    decay=0;
  }
  
  void resultVictory(){
    fasebatalla=FBEND;
    getLoot();
    result=RSVCT;
    btnback.deactive();
    gc.musicManager(MSCOFF,false);
    gc.musicManager(MSCON,true);
    bitacora.agregaDatosLn(registraFinCombate(enemy,pers,result));
    nextFB();
  }
  
  void resultDefeat(){
    fasebatalla=FBEND;
    result=RSDFT;
    btnback.deactive();
    bitacora.agregaDatosLn(registraFinCombate(enemy,pers,result));
    nextFB();
  }
  
  void enemySnd(){
    if(!intro){
      enemy.playSfx(ENFXINT);
      intro=true;
    }  
  }
  
  void getLoot(){
    pers.exp+=enemy.exp;
    pers.cash+=enemy.cash;
    pers.updateInv(enemy.item,TMBUY);
    //beginWinMessage(enemy.item);
  }
  
  void loseLoot(){
    int c;
    if(pers.cash>=100){
      c=int(pers.cash*0.2);
      c+=(c%10==0)?0:10-c%10;
      pers.cash-=c;
      beginLoseMessage(c,ITCASH);
    }  
    else
      if(pers.hp>12){
        c=td.tira2D6();
        pers.herida(c);
        beginLoseMessage(c,ITHPP);
      }
  }
  
  void beginLoseMessage(int c,int i){
    escimg=(i==ITHPP?imghpm:imgcash);
    cost=c;
    onesc=true;
    controlEspera();
  }
  
  void beginWinMessage(int c,int i){
    escimg=(i==ITHPP?imghpm:imgcash);
    cost=c;
    onesc=true;
    controlEspera();
  }
  
  //comandos de bitácora
  String registraInicioCombate(Enemigo e, Personaje p){
    String s="Inicio combate\n";
    String time=hour()+":"+minute()+":"+second();  //Hora que inicia el combate
    s=s+"Hora inicio="+time+"\n";
    s=s+"versus "+e.name+"\n";
    s=s+"lvle="+e.lvl+",lvlp="+p.lvl+"\n";
    s=s+"atke="+e.atk+",atkp="+p.atk+"\n";
    s=s+"defe="+e.def+",defp="+p.def+"\n";
    s=s+"cashe="+e.cash+"\n";
    s=s+"Fin registro\n";
    return s;
  }
  
  String registraAccionCombate(Enemigo e, Personaje p,int ti,boolean t){
    int a;
    int d;
    String s="Accion combate\n";
    s=s+"tirada="+ti+"\n";
    
    //Se agregan las siguientes lienas para ver el mensaje en la bitacora
    if(ti<=6)
      s=s+"mensaje"+lf.showString(37)+"\n";
    if(ti>6 && ti<=11)
      s=s+"mensaje"+lf.showString(36)+"\n";
      
    if(t){
      a=p.getAtkDamage()+ti;
      d=e.getDefDamage();
      s=s+"AtkBaseP="+p.getAtkDamage()+",DefTE="+d+"\n";
      s=s+"Resultado="+((a>d)?"EXITO":"FALLO")+"\n";
    }
    else{
      a=e.getAtkDamage()+ti;
      d=p.getDefDamage();
      s=s+"AtkBaseE="+e.getAtkDamage()+",DefTP="+d+"\n";
      s=s+"Resultado="+((a>d)?"EXITO":"FALLO")+"\n";
    }
    s=s+"Fin de registro\n";
    return s;
  }
  
  String registraConsumoItem(Personaje p,int i){
    String s="Cosumo de item\n";
    s=s+(i==ITPTN?"Pocion":(i==ITFPT?"Pocion llena":"Tonico"))+" utilizado"+"\n";
    s=s+"Efecto: "+(i==ITTNC?(p.tonicd+"turnos restantes"):"Curacion")+"\n"; 
    s=s+"Fin de registro\n";
    return s;
  }
  
  String registraFinCombate(Enemigo e, Personaje p,boolean v){
    String s="Fin de combate\n";
    String time=hour()+":"+minute()+":"+second();
    s=s+"Hora Termino="+time+"\n";    //hora en que finaliza el combate
    if(v){
      s=s+"Victoria"+"\n";
      s=s+"hp="+p.hp+"\n";
    }
    else{
      s=s+"Derrota, fin de juego\n";
    }
    i=i+1;
    cash=cash+e.cash;
    s=s+"Dinero ganado: "+cash+"\n";    //Guarda el total de dinero ganado
    s=s+"Rivales muertos: "+i+"\n";     //Total de enemigos muertos
    s=s+"Fin de registro\n";
    return s;
  }
}
