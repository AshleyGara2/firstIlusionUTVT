//Modulo MapLoader
//elaborado por: Ashley Galicia Ramirez
//fecha de creación: 24 de noviembre de 2021
//fecha de ultima modificación: 3 de diciembre de 2021
//comentario: Permite cargar los datos de los archivos de mapa, texturas y bordes para pintarlos en pantalla
class MapLoader{
  String file[]; //archivo
  int map[][];  //mapa
  int tile[][]; //lozeta
  char bord[][]; //borde
  int r;    //renglon
  int c;     //columna
  
  MapLoader(){ //lo que hacen los for es recorrer las matrices de los diferentes archivos para pintar los valores en la pantalla
    file=loadStrings("worldmap.dat"); //Carga el archivo 
    r=int(split(file[0],'='))[1];
    c=int(split(file[1],'='))[1];
    map=new int[r][c];
    for(int i=0;i<r;i++)
      for(int j=0;j<c;j++)
        map[i][j]=(file[i+2].charAt(j))-'0';
    file=loadStrings("maptextures.dat"); //carga el archivo
    r=int(split(file[0],'='))[1];
    c=int(split(file[1],'='))[1];
    tile=new int[r][c];
    for(int i=0;i<r;i++)
      for(int j=0;j<c;j++)
        tile[i][j]=(file[i+2].charAt(j))-'0'; 
    file=loadStrings("mapborders.dat"); //Carga el archivo
    r=int(split(file[0],'='))[1];
    c=int(split(file[1],'='))[1];
    bord=new char[r][c];
    for(int i=0;i<r;i++)
      for(int j=0;j<c;j++)
        bord[i][j]=(file[i+2].charAt(j));
  }
  
  int[][] getMap(){ //obtinene el valor del mapa
    return map;
  }
  
  int[][] getTileMap(){ //Obtiene el valor de las lozetas
    return tile;
  }
  
  char[][] getBordMap(){ //Obtinene el valor de los bordes
    return bord;
  }
  
  int getTile(int x,int y){
    return tile[y][x];
  }
  
  char getBord(int x,int y){
    return bord[y][x];
  }
  
  int getRows(){
    return r;
  }
  
  int getCols(){
    return c;
  }
  
  int getBordIndex(char c){
    int i=0;
    i=(isNumber(c))?c-'0':(isAlpha(c)?10+c-'A':36+c-'a');
    return i;
  }
  
  boolean isNumber(char c){
    return c>='0' && c<='9';
  }
  
  boolean isAlpha(char c){
    return c>='A' && c<='Z';
  }
  
  int getSymbol(char c){
    int i=0;
    switch(c){
      case '+': i=37; break;
      case '-': i=38; break;
      case '#': i=39; break;
      case '$': i=40; break;
      case '%': i=41; break;
      case '&': i=42; break;
      case '(': i=43; break;
      case ')': i=44; break;
      case '=': i=45; 
    }
    return i;
  }
  
  void printMap(){ //pinta los valores dentro del mapa
    for(int i=0;i<r;i++){
      for(int j=0;j<c;j++)
        print(map[i][j]);
      println();  
    }  
  }
  
  void printTileMap(){ //pinta los valores dentro del mapa
    for(int i=0;i<r;i++){
      for(int j=0;j<c;j++)
        print(tile[i][j]);
      println();  
    }  
  }
  
  void printBordMap(){ //pinta los valores dentro del mapa
    for(int i=0;i<r;i++){
      for(int j=0;j<c;j++)
        print(bord[i][j]);
      println();  
    }  
  }
}
