//Proyecto Fist Ilusion UTVT
//Elaborado por: Ashley Galicia Ramirez
//Fecha de creación: 17 de septiembre de 2021
//fecha de ultima modificación: 05 de diciembre de 2021
//comentario: Es el modulo principal donde se define la dimension de la pantalla, las propiedades
//del programa como las imagenes, sonidos, pantallas que se utilizaran. Cabe mencionar que esta
//funcion solo existe una en todo el proyecto.

import ddf.minim.*;        //Librerias para hacer uso de los efectos de sonido
import processing.video.*; //Libreria para hacer uso de videos

final int PNCRG=1;        //Pantalla de Carga
final int PNCBT=2;        //Pantalla de Combate
final int PNCFG=3;        //Pantalla de Configuración
final int PNCRE=4;        //Pantalla de Creación
final int PNCRD=5;        //Pantalla de Créditos
final int PNFIN=6;        //Pantalla de Fin de Juego
final int PNINT=7;        //Pantalla de Intro
final int PNLVL=8;        //Pantalla de Subir Nivel
final int PNMAP=9;        //Pantalla de Mapa
final int PNPAU=10;       //Pantalla de Pausa
final int PNTND=11;       //Pantalla de Tienda
final int CLBTNT=1;       //Color del boton activo
final int CLBTNF=0;       //color del boton activo
final int LGSPA=0;        //lenguaje español
final int LGENG=1;        //lenguaje ingles
final int ATATK=1;        //Atributo de ataque
final int ATDEF=2;        //Atributo dedefensa
final int ATHPM=3;        //Atributo depuntos de visa
final boolean ATUP=true;  //Atributo arriba
final boolean ATDN=false; //Atributo abajo
final int CLAWA=0;         //Color del agua 
final int CLTRR=1;         //Color tierra
final int CLBSQ=2;         //Color cosque
final int CLPST=3;         //Color pasto
final int CLTND=4;          //Color tienda
final boolean MSCON=true;   //Música encedida
final boolean MSCOFF=false;  //Música apagada
final int ITPTN=0;           //Item pocion
final int ITFPT=1;           //Item pocion 
final int ITTNC=2;           //Item tonico
final int ITATK=3;           //Item ataque
final int ITDEF=4;           //Item defensa
final int ITHPP=5;           //Item puntos de vida
final int ITCASH=6;          //Item dinero
final boolean TMBUY=true;       //modo de compra
final boolean TMSELL=false;     //modo venta
final boolean BATTLEON=true;    //batalla iniciada
final boolean BATTLEOFF=false;  //batalla finalizada
final boolean ACTON=true;       //acción iniciada
final boolean ACTOFF=false;     //acción finalizada
final boolean TURNP=true;       //Turno del personaje
final boolean TURNE=false;      //Turno del enemigo
final int ACATK=0;
final int ACDEF=1;
final int ACITM=3;
final int FBINTRO=0;            //Fase de batalla intro
final int FBCOMBT=1;            //Fase de batalla combate
final int FBEND=2;              //Fase de batalla fin
final int FBEXIT=3;             //Fase de batalla salir
final int FBESC=4;              //Fase de batalla detener
final boolean LIVE=true;        //Vivo
final boolean DEAD=false;       //Muerto
final boolean RSVCT=true;       //Resultado victoria
final boolean RSDFT=false;      //Resultado fallo
final int ENFXINT=0;            //Activa efectos de sonido modo intro
final int ENFXATK=1;            //Activa efectos de sonido modo ataque
final int ENFXDED=2;             //Activa efectos de sonido modo muerte
final color COLBTNFACF=color(220,118,51);  //Color del boton cuando su valor es falso
final color COLBTNFACE=color(0,149,131);   //Color del boton
final color COLBTNBRDR=color(234,239,34);  //Color del borde del boton
final color COLBLOOD=color(250,0,0);       //Color rojo
final color COLMKGRN=color(0,250,0);       //Color cuando esta marcado
final color COLPERS=color(150,150,0);      //Color del personaje cuando modo grafico es false
final color COLENTR=color(170,0,0);        //Color de tierra cuando modo grafico es false
final color COLENBS=color(0,120,0);        //Color del bosque cuando modo grafico es false
final color COLENPS=color(0,200,0);        //Color del pasto cuando modo grafico es false
final int EASY=0;        //Dificultad facil del juego
final int MED=1;         //Dificultad media del juego
final int HARD=2;        //Dificultad dificil del juego
final boolean PRE=true;  //Para darle un efecto al mapa
final boolean POST=false;  //Para darle un efecto al mapa
boolean rectOver = false;

color paleta[];     //Asigna el color al terreno
PImage terreno[];   //Asigna un imagen al terreno
/*Este bloque hace referencia a las imagenes de fondo, ataque, defensa, puntos de vida
posiones, dinero eh iconos que se utilizan*/
PImage imgbackgr;
PImage imgatk;
PImage imgdef;
PImage imghpm;
PImage imgpotn;
PImage imgfpot;
PImage imgtonic;
PImage imgcash;
PImage imgicon;

boolean gmode;      //Modo grafico del juego
boolean gameresult; //resultado del juego

//Este bloque hace referencia a la musica y efectos de sonido
Minim minim;

AudioPlayer mscintro;
AudioPlayer msccrea;
AudioPlayer mscmundo;
AudioPlayer mscstore;
AudioPlayer msccombt;
AudioPlayer msccreds;
AudioPlayer mscdefet;
AudioPlayer mscfanfr;
AudioPlayer mscvctry;
AudioPlayer msclvlup;

AudioSample sfxfight;
AudioSample sfxclick;
AudioSample sfxcash; 
AudioSample sfxdrink;
AudioSample sfxbones;
AudioSample sfxdeath;
AudioSample sfxheal;
AudioSample sfxhit;
AudioSample sfximp;
AudioSample sfxsworm;
AudioSample sfxshild;
AudioSample sfxsword;
AudioSample sfxvnish;
AudioSample sfxknght;
AudioSample sfxshiss;
AudioSample sfxmnstr;
AudioSample sfxgmnst;
AudioSample sfxbbbls;
AudioSample sfxroar;
AudioSample sfxbite;
AudioSample sfxgrito;
AudioSample sfxgrwlf;

Movie credits;  //se asigna el video

//Se llaman las clases que se utilizan en este modulo
GameControl gc;
PFont fbase;
LangFiles lf;
ColorBoton cbtn;
ConfigFile cf;
Personaje pers;
EnemyData ed;
TiraDados td;
DatosDados dcbt;
Bitacora bitacora;
MapLoader ml;

void setup(){
  size(700,700);
  frameRate(60);
  surface.setTitle("First Illusion UTVT");
  imgicon=new PImage();
  imgicon=loadImage("sprite/personaje/worldmove/left/left0.png");
  surface.setIcon(imgicon);
  createPal();
  createTerreno();
  gmode=true;
  fbase=createFont("Arial Black",24);
  imgbackgr=loadImage("sprite/backgr/backgr.png");
  imgatk=loadImage("sprite/icon/icon_atk.png");
  imgdef=loadImage("sprite/icon/icon_def.png");
  imghpm=loadImage("sprite/icon/icon_hpm.png");
  imgpotn=loadImage("sprite/items/potion.png");
  imgfpot=loadImage("sprite/items/full potion.png");
  imgtonic=loadImage("sprite/items/tonic.png");
  imgcash=loadImage("sprite/items/cash.png");
  textFont(fbase);
  cf=new ConfigFile();
  bitacora=new Bitacora(cf.logact);
  lf=new LangFiles(cf.lang,cf.ns);
  ed=new EnemyData();
  td=new TiraDados();
  ml=new MapLoader();
  dcbt=new DatosDados();
  cbtn=new ColorBoton();
  gc=new GameControl();
  minim=new Minim(this);
    
  thread("loadAudio");
}

void draw(){
  gc.display();
}

void mouseReleased(){
  gc.mouseProcess(mouseX,mouseY,mouseButton);
}

void keyReleased(){
  gc.keyProcess(key);
}
  //Crea la paleta de colores
void createPal(){
  paleta=new color[5];
  paleta[CLAWA]=color(164,218,247);
  paleta[CLTRR]=color(150,113, 75);
  paleta[CLBSQ]=color( 88,138, 87);
  paleta[CLPST]=color( 91,244,103);
  paleta[CLTND]=color(105, 37,231);
}

//Carga las imagenes de los terrenos
void createTerreno(){
  terreno=new PImage[5];
  terreno[CLAWA]=loadImage("sprite/terreno/agua_ok.png");
  terreno[CLTRR]=loadImage("sprite/terreno/tierra_ok.png");
  terreno[CLBSQ]=loadImage("sprite/terreno/bosque_ok.png");
  terreno[CLPST]=loadImage("sprite/terreno/pasto_ok.png");
  terreno[CLTND]=loadImage("sprite/terreno/tienda_ok.png");
}

//carga los audios que se usaran
void loadAudio(){
  gc.pncrg.message=lf.showString(27);
  //efectos de uso general
  sfxfight=minim.loadSample("sound/fx/enter battle.mp3",512);
  sfxclick=minim.loadSample("sound/fx/click.mp3",512);
  sfxcash=minim.loadSample("sound/fx/cash.mp3",512);
  sfxdrink=minim.loadSample("sound/fx/drink.mp3",512);
  sfxheal=minim.loadSample("sound/fx/heal.mp3",512);
  sfxfight.setGain(0.15);
  sfxclick.setGain(0.15);
  sfxcash.setGain(0.15);
  sfxdrink.setGain(0.15);
  sfxheal.setGain(0.15);
  //efectos de intro de enemigos
  sfxbones=minim.loadSample("sound/fx/intro/bones.mp3",512);
  sfximp=minim.loadSample("sound/fx/intro/imp.mp3",512);
  sfxsworm=minim.loadSample("sound/fx/intro/sandworm.mp3",512);
  sfxknght=minim.loadSample("sound/fx/intro/knight.mp3",512);
  sfxshiss=minim.loadSample("sound/fx/intro/snakehiss.mp3",512);
  sfxmnstr=minim.loadSample("sound/fx/intro/monster.mp3",512);
  sfxgmnst=minim.loadSample("sound/fx/intro/growl monster.mp3",512);
  sfxbbbls=minim.loadSample("sound/fx/intro/bubbles.mp3",512);
  sfxroar=minim.loadSample("sound/fx/intro/roar.mp3",512);
  sfxgrwlf=minim.loadSample("sound/fx/intro/growl female.mp3",512);
  sfxbones.setGain(0.15);
  sfximp.setGain(0.15);
  sfxsworm.setGain(0.15);
  sfxknght.setGain(0.15);
  sfxshiss.setGain(0.15);
  sfxmnstr.setGain(0.15);
  sfxgmnst.setGain(0.15);
  sfxbbbls.setGain(0.15);
  sfxroar.setGain(0.15);
  sfxgrwlf.setGain(0.15);
  //efectos de ataque de enemigos
  sfxbite=minim.loadSample("sound/fx/atk/bite.mp3",512);
  sfxhit=minim.loadSample("sound/fx/atk/hit.mp3",512);
  sfxshild=minim.loadSample("sound/fx/atk/shield.mp3",512);
  sfxsword=minim.loadSample("sound/fx/atk/sword.mp3",512);
  sfxbite.setGain(0.15);
  sfxhit.setGain(0.15);
  sfxshild.setGain(0.15);
  sfxsword.setGain(0.15);
  //efectos de muerte de enemigos
  sfxvnish=minim.loadSample("sound/fx/death/vanish.mp3",512);
  sfxdeath=minim.loadSample("sound/fx/death/death.mp3",512);
  sfxgrito=minim.loadSample("sound/fx/death/grito.mp3",512);
  sfxvnish.setGain(0.15);
  sfxdeath.setGain(0.15);
  sfxgrito.setGain(0.15);
  gc.pncrg.message=lf.showString(28);
  mscintro=minim.loadFile("sound/music/intro.mp3");
  msccrea=minim.loadFile("sound/music/creation.mp3");
  mscmundo=minim.loadFile("sound/music/mapa.mp3");
  mscstore=minim.loadFile("sound/music/store.mp3");
  msccombt=minim.loadFile("sound/music/combate.mp3");
  msccreds=minim.loadFile("sound/music/credits.mp3");
  mscdefet=minim.loadFile("sound/music/defeat.mp3");
  mscfanfr=minim.loadFile("sound/music/fanfare.mp3");
  mscvctry=minim.loadFile("sound/music/victory.mp3");
  msclvlup=minim.loadFile("sound/music/levelup.mp3");
  mscintro.setGain(0.05);
  msccrea.setGain(0.05);
  mscmundo.setGain(0.05);
  mscstore.setGain(0.05);
  msccombt.setGain(0.05);
  msccreds.setGain(0.05);
  mscdefet.setGain(0.05);
  mscfanfr.setGain(0.05);
  mscvctry.setGain(0.05);
  msclvlup.setGain(0.05);
  gc.pncrg.message=lf.showString(35);
  credits=new Movie(this,"video/creditos.mp4");
  gc.pncrg.message=lf.showString(29);
  gc.pncrg.loading=false;
}

void music(){
  if(!gc.getMusicStatus())
  gc.musicManager(MSCON,false);
}

//Color de los botones
void setFillStroke(color c){
  fill(c);
  stroke(c);
}

void setFillStroke(color f,color s){
    fill(f);
    stroke(s);
}

//Para poder ver el video
void movieEvent(Movie m){
  m.read();
}
