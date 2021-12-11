//ConfigFile
//Elaborado por: Ashley Galicia Ramirez
//Fecha de creación: 04 de octubre de 2021
//fecha de ultima modificación: 4 de diciembre de 2021
//comentario:

class ConfigFile{
  String file[];  //
  String save;    //gua
  int lang;       //languaje del juego
  int ns;         //numero de mensajes en el archivo
  int ppa;        //puntos por asignar
  int minatr;     //valor minimo de atributos
  int maxatr;     //valor maximo de atributos
  int bsqodd;     //valor
  int pstodd;
  int trrodd;
  int cash;       //dinero disponible
  int potnv;      //costo de venta la pocion 
  int fpotv;      //costo de ventala pocion
  int tonicv;     //costo de venta del tonico
  int potnc;      //costo de compra de la pocion
  int fpotc;      //costo de compra de la pocion
  int tonicc;     //costo de compra del tonico
  int cdtenemy;   //tiempo den enemigo
  int cdtplayr;   //tiempo den jugador
  int heal;       //curacion
  int patkf;      //ataque del personaje
  int eatkf;      //ataque del enemigo
  int pdeff;      //defensa del personaje
  int edeff;      //defensa del enemigo
  int explup;     //experiencia alto
  int expinc;     //experiencia
  int tonicd;     //tonico defensa
  int hp;         //puntos de vida
  int tonicb;     //tinico
  int stx;        //inicio en x
  int sty;        //inicio en y
  int lvlini;     //nivel inicial
  int lvlfin;     //nivel final
  int lvlesy;     //nivel facil
  int lvlmed;     //nivel medio
  int ss;          
  int hs;
  int sp;
  int critdmg;
  int cbtcool;
  boolean logact;
  float lowhealth;
  
  ConfigFile(){
    file=loadStrings("config.dat");
    loadConfig();
  }
  
  void loadConfig(){ //varga los valores del archivo config.dat dependiendo de la posicion que corresponda
    int i;
    
    for(i=0;i<file.length;i++){ //recorre el archivo config.dar
      if(isData("language",i)) lang=loadData(i);
      if(isData("langstr",i))  ns=loadData(i);
      if(isData("ppa",i))      ppa=loadData(i);
      if(isData("minatr",i))   minatr=loadData(i);
      if(isData("maxatr",i))   maxatr=loadData(i); 
      if(isData("bsqodd",i))   bsqodd=loadData(i);
      if(isData("pstodd",i))   pstodd=loadData(i);
      if(isData("trrodd",i))   trrodd=loadData(i);
      if(isData("cash",i))     cash=loadData(i);
      if(isData("potnv",i))    potnv=loadData(i);
      if(isData("fpotv",i))    fpotv=loadData(i);
      if(isData("tonicv",i))   tonicv=loadData(i);
      if(isData("potnc",i))    potnc=loadData(i);
      if(isData("fpotc",i))    fpotc=loadData(i);
      if(isData("tonicc",i))   tonicc=loadData(i);
      if(isData("cdtenemy",i)) cdtenemy=loadData(i);
      if(isData("cdtplayr",i)) cdtplayr=loadData(i);
      if(isData("heal",i))     heal=loadData(i);
      if(isData("patkf",i))    patkf=loadData(i);
      if(isData("eatkf",i))    eatkf=loadData(i);
      if(isData("pdeff",i))    pdeff=loadData(i);
      if(isData("edeff",i))    edeff=loadData(i);
      if(isData("explup",i))   explup=loadData(i);
      if(isData("expinc",i))   expinc=loadData(i);
      if(isData("tonicd",i))   tonicd=loadData(i);
      if(isData("hp",i))       hp=loadData(i);
      if(isData("tonicb",i))   tonicb=loadData(i);
      if(isData("startx",i))   stx=loadData(i);
      if(isData("starty",i))   sty=loadData(i);
      if(isData("lvlini",i))   lvlini=loadData(i);
      if(isData("lvlfin",i))   lvlfin=loadData(i);
      if(isData("lvlesy",i))   lvlesy=loadData(i);
      if(isData("lvlmed",i))   lvlmed=loadData(i);
      if(isData("ss",i))       ss=loadData(i);
      if(isData("hs",i))       hs=loadData(i);
      if(isData("sp",i))       sp=loadData(i);
      if(isData("logact",i))   logact=loadBoolData(i);
      if(isData("lowhealth",i))lowhealth=loadFloatData(i);
      if(isData("critdmg",i))  critdmg=loadData(i);
      if(isData("cbtcool",i))  cbtcool=loadData(i);
    }
  }
  
  boolean isData(String s, int i){
    return (split(file[i],'=')[0].equals("#"+s));
  }
  
  int loadData(int i){
    return (int(split(file[i],'=')[1]));
  }
  
  boolean loadBoolData(int i){
    return (split(file[i],'=')[1]).equals("ON");
  }
  
  float loadFloatData(int i){
    return float(split(file[i],'=')[1]);
  }
  
  void saveConfig(LangFiles lf){ //guarda las configuraciones en el archivo config.dat
    lang=lf.getLang();
    save="";
    addSave("language",lang);
    addSave("langstr",ns);
    addSave("ppa",ppa);
    addSave("minatr",minatr);
    addSave("maxatr",maxatr);
    addSave("bsqodd",bsqodd);
    addSave("pstodd",pstodd);
    addSave("trrodd",trrodd);
    addSave("cash",cash);
    addSave("potnv",potnv);
    addSave("fpotv",fpotv);
    addSave("tonicv",tonicv);
    addSave("potnc",potnc);
    addSave("fpotc",fpotc);
    addSave("tonicc",tonicc);
    addSave("cdtenemy",cdtenemy);
    addSave("cdtplayr",cdtplayr);
    addSave("heal",heal);
    addSave("patkf",patkf);
    addSave("eatkf",eatkf);
    addSave("pdeff",pdeff);
    addSave("edeff",edeff);
    addSave("explup",explup);
    addSave("expinc",expinc);
    addSave("tonicd",tonicd);
    addSave("hp",hp);
    addSave("tonicb",tonicb);
    addSave("startx",stx);
    addSave("starty",sty);
    addSave("lvlini",lvlini);
    addSave("lvlfin",lvlfin);
    addSave("lvlesy",lvlesy);
    addSave("lvlmed",lvlmed);
    addSave("ss",ss);
    addSave("hs",hs);
    addSave("sp",sp);
    addSave("logact",logact);
    addSave("critdmg",critdmg);
    addSave("cbtcool",cbtcool);
    file=split(save,';');
    saveStrings("data/config.dat",file);
  }
  
  void addSave(String s,int v){
    save=save+"#"+s+"="+v+";";
  }
  
  void addSave(String s,boolean v){
    save=save+"#"+s+"="+(v?"ON":"OFF")+";";
  }
}
