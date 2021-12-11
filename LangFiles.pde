//LangFiles
//Elaborado por: Ashley Galicia Ramirez
//Fecha de creación: 20 de septiembre de 2021
//fecha de ultima modificación: 28 de septiembre de 2021
//comentario: El archivo langFile es el que va a determinar en que idioma
//va a estar el videojuego, se crea un archivo que contiene los títulos en ingles
//y otro en español, para que al leer el arreglo se coloque el que 

class LangFiles{
  String langs[][]; //variable que recibe un arreglo de tipo string
  String file[];//variable que recibe un arreglo de tipo string
  int actlang; // variable de tipo int que determina cual lenguaje es el que esta activo 
  int ns;//variable que contiene el numero del titulo
  
  LangFiles(int l,int n){
    actlang=l; // el lenguaje activo es iguala a la variable que recibe, l
    ns=n; // numero es igual a la variable n que recibe 
    langs=new String[ns][2]; // se crea el arreglo que va a utilizar los documentos de ingles o español
    loadLang(LGSPA); // hace referencia a la variable que se encuentra en el archivo principal, equivale a 0
    loadLang(LGENG); // hace referencia a la variable que se encuentra en el archivo principal, equivale a 1
  }
  
  void loadLang(int i){
    int n;
    
    file=loadStrings((i==LGSPA)?"spa.lang":"eng.lang");    
    for(n=0;n<ns;n++)
      langs[n][i]=split(file[n],'=')[1];
      //se crea un ciclo for para poder hacer el cambio de idioma entre los archivos lang 
  }
  
  void setLang(int l){ // esta funcion va a recibir cual es el lenguaje que esta activo
    actlang=l;
  }
  
  int getLang(){  // se obtiene el archivo del lenguaje que esta activo
    return actlang;
  }
  
  String showString(int i){ // se muestran los datos que contiene el archivo activo, ya sea español=0 o inglés=1
    return langs[i][actlang];
  }
}
