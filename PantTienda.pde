//PantTienda
//Elaborado por: Ashley Galicia Ramirez
//Fecha de creación: 20 de septiembre de 2021
//fecha de ultima modificación: 28 de noviembre de 2021
/*Comentario: Muestra una pantalla donde estan los botones de comprar y vender
dependiendo de cual se seleccione hace una funcion diferente. Se pueden compara y
vender pociones y el dinero va cambiando su valor
*/

class PantTienda{
  Boton btncomp;        //Boton comprar
  Boton btnvend;        //boton vender
  Boton btncont;        //Boton continuar
  ClickItem citpotn;    //Item pocion
  ClickItem citfpot;    //Item pocion
  ClickItem cittonic;   //Item tonico
  PImage tienda;        //Imagen de fondo
  PImage imgtrademode;  //Imagen flecha
  boolean trademode;    //modo de comercio
  
  PantTienda(){
    btncomp=new Boton(200,550,200,85,24);
    btnvend=new Boton(500,550,200,85,25);
    btncont=new Boton(350,650,200,85,5);
    btncomp.activate();
    btnvend.activate();
    btncont.activate();
    citpotn=new ClickItem(250,150,cf.sp,cf.sp,ITPTN);
    citfpot=new ClickItem(350,150,cf.sp,cf.sp,ITFPT);
    cittonic=new ClickItem(450,150,cf.sp,cf.sp,ITTNC);
    citpotn.toggleActive();
    citfpot.toggleActive();
    cittonic.toggleActive();
    tienda=loadImage("sprite/backgr/store_ok.png");
    imgtrademode=loadImage("sprite/items/trademode.png");
    trademode=TMBUY;
    btncomp.toggleMarked();
  }
  
  void display(){
    music();
    background(tienda);
    fill(255);
    text(lf.showString(16),350,50);
    citpotn.display();
    citfpot.display();
    cittonic.display();
    btncomp.display();
    btnvend.display();
    btncont.display();
    pers.drawTradeData();
    if(trademode)
      flipYImage(imgtrademode,350,300);
    else
      image(imgtrademode,350,300);
    text("$"+(trademode?cf.potnv:cf.potnc),250,180);
    text("$"+(trademode?cf.fpotv:cf.fpotc),350,180);
    text("$"+(trademode?cf.tonicv:cf.tonicc),450,180);
  }
  
  void toggleTM(){
    trademode=!trademode;
    btncomp.toggleMarked();
    btnvend.toggleMarked();
  }
  
  void flipYImage(PImage i,int x,int y){
    pushMatrix();
    scale(1,-1);
    image(i,x,-y);
    popMatrix();
  }
  
  void mouseProcess(int x,int y,int b){
    if(btncomp.isClicked(x,y) && b==LEFT){
      btncomp.toggleMarked();
      btnvend.toggleMarked();
      trademode=TMBUY;
    }  
    if(btnvend.isClicked(x,y) && b==LEFT){
      btncomp.toggleMarked();
      btnvend.toggleMarked();
      trademode=TMSELL;  
    }  
    if(btncont.isClicked(x,y) && b==LEFT)
      exitStore(); 
    if(citpotn.isClicked(x,y) && b==LEFT)
      trade(ITPTN);
    if(citfpot.isClicked(x,y) && b==LEFT)
      trade(ITFPT);
    if(cittonic.isClicked(x,y) && b==LEFT)
      trade(ITTNC);
  }
  
  void keyProcess(char k){
    switch(k){
      case '1':   //compra/venta de poción
                  trade(ITPTN);
                  break;
      case '2':   //compra/venta de poción llena
                  trade(ITFPT);
                  break;
      case '3':   //compra/venta de tónico
                  trade(ITTNC);
                  break;
      case ' ':   //cambio de modo de comercio
                  toggleTM();
                  break;
      case 'x':            
      case 'X': //salir de la pantalla
                  exitStore();
    }
  }
  
  void trade(int i){
    if(trademode)
      buyItem(i);
    else
      sellItem(i);
  }
  //Este método escribe datos en la bitácora
  void buyItem(int i){
    if(pers.cash>=getItemVCost(i)){
      pers.cash-=getItemVCost(i);
      pers.updateInv(i,trademode);
      bitacora.agregaDatosLn(generaDatosCompra(i));
      sfxcash.trigger();
    }
  }
  //Este método escribe datos en la bitácora
  void sellItem(int i){
    if(pers.getItemInv(i)>0){
      pers.cash+=getItemCCost(i);
      pers.updateInv(i,trademode);
      bitacora.agregaDatosLn(generaDatosVenta(i));
      sfxcash.trigger();
    }
  }
  
  int getItemVCost(int i){
    return (i==ITPTN?cf.potnv:(i==ITFPT?cf.fpotv:cf.tonicv));
  }
  
  int getItemCCost(int i){
    return (i==ITPTN?cf.potnc:(i==ITFPT?cf.fpotc:cf.tonicc));
  }
  
  void exitStore(){
    gc.musicManager(MSCOFF,false);
    gc.setPantAct(PNMAP);  
  }
  
  //estos son métodos para generar cadenas específicas de datos a grabar en la
  //bitácora.
  
  String generaDatosCompra(int i){
    String s="";
    s="Compra:"+indicaItem(i)+", saldo: "+pers.cash;
    return s;
  }
  
  String generaDatosVenta(int i){
    String s="";
    s="Venta:"+indicaItem(i)+", saldo: "+pers.cash;
    return s;
  }
  
  String indicaItem(int i){
    return i==ITPTN?"Pocion":i==ITFPT?"Pocion llena":"Tonico";
  }
}
