//Bitacora
//Elaborado por: Ashley Galicia Ramirez
//fecha de creación: 24 de noviembre de 2021
//fecha de ultima modificación: 29 de noviembre de 2021
//comentario: Permite guardar informacion en un archivo llamado test
//la iformacion que lleva el archivo de pruebas vienen de otros modulos

class Bitacora{
  PrintWriter output; //salida de texto
  boolean active;    //true o false
  
  Bitacora(boolean a){
    active=a;
    if(active){
      String s="data/testing/test ";
      s=s+agregaFechaHora();
      s=s+".log";
      output=createWriter(s);
    }
  }
  
  //Agrega la fecha y hora al final del archivo
  String agregaFechaHora(){
    return ""+month()+"-"+day()+"-"+year()+" "+hour()+" con "+minute();
  }
  
  //Agrega datos
  void agregaDatosLn(String s){
    if(active){
      output.println(s);
      output.flush();
    }  
  }
  
  void agregaDatos(String s){
    if(active){
      output.print(s);
      output.flush();
    }  
  }
  
  void toggleActive(){
    active=!active;
  }
  
  void cierraBitacora(){
    if(active){
      String s="fin de test ";
      s=s+agregaFechaHora();
      output.println(s);
      output.flush();
      output.close();
    }  
  }
}
