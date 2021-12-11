//Modulo Dado
//Elaborado por: Ashley Galicia Ramirez
//fecha de creación: 03 de dicmebre de 2021
//fecha de ultima modificación: 05 de diciembre de 2021
//Comentario: Crea el valor de los dados dependiendo si es simple o complejo
//asigna un valor alto o bajo segun el valor al azar con la funcion random

class Dado{
  int nc;      //numero de caras
  int t;       //
  int tc;      //total de caras 
  int ca[];    //cara 
  int va[];    //valor
  float pa[];  //longitud
  int lov;     //Valor bajo 
  int hiv;     //Valor alto
  boolean issimple;     //Es simple
  boolean islocritics;  //Es bajo simple
  boolean ishicritics;  //Es alto simple
  boolean islocriticc;  //Es bajo complejo
  boolean ishicriticc;  //Es alto complejo
  
  //Dado sencillo
  Dado(int n){
    nc=n;
    issimple=true;
    islocritics=false;
    ishicritics=false;
  }
  
  //Recibe el numero de caras y el valor
  Dado(int c[],int v[]){
    nc=0;
    ca=c;
    va=v;
    pa=new float[va.length];
    tc=0;
    lov=1000;
    hiv=0;
    for(int i=0;i<ca.length;i++){
      tc+=c[i];
      if(va[i]>hiv) hiv=va[i];
      if(va[i]<lov) lov=va[i];
    } 
    pa[0]=ca[0]*1.0/tc;
    for(int i=1;i<ca.length-1;i++)
      pa[i]=ca[i-1]+ca[i]*1.0/tc;
    issimple=false;
    islocriticc=false;
    ishicriticc=false;
  }
  
  int tiraDado(){
    return issimple?tiraDadoS():tiraDadoC();
  }
  
  int tiraDadoS(){
    t=int(random(1,nc+1));
    islocritics=(t==1);
    ishicritics=(t==nc);
    return t;
  }
  
  boolean isLoCriticS(){
    return islocritics;
  }
  
  boolean isHiCriticS(){
    return ishicritics;
  }
  
  int tiraDadoC(){
    float n=random(1);
    int v=0;
    int i=0;
    while(n<pa[i] && i<pa.length-1)
      i++;
    v=va[i];  
    islocriticc=v==lov;
    ishicriticc=v==hiv;
    return v;
  }
  
  boolean isLoCriticC(){
    return islocriticc;
  }
  
  boolean isHiCriticC(){
    return ishicriticc;
  }
  
  void printDado(){
    if(issimple)
      println("Dado simple de "+nc+" caras");
    else{
      println("Dado complejo");
      print("Caras:  ");
      imprimeVector(ca);
      print("Valores:");
      imprimeVector(va);
      println();
    }
  }
  
  void imprimeVector(int []v){
    print("{");
    for(int i=0;i<v.length;i++)
      print(v[i]+(i<v.length-1?",":""));
    println("}");
  }
}
