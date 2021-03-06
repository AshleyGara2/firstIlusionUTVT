//Modulo EnemyData 
//elaborado por: Ashley Galicia Ramirez
//fecha de creación: 26 de noviembre de 2021 
//fecha de ultima modificación: 06 de diciembre de 2021 
//comentario: Carga los datos del enemmigo que estan en el archivo enemydata.json

class EnemyData{
  JSONArray data;  //Datos del enemigo
  JSONObject enemy;//Datos JSON
  
  EnemyData(){
    data=loadJSONArray("enemydata.json");
  }
  
  void loadEnemyData(int i){
    enemy=data.getJSONObject(i);
  }
  
  int getAtk(){
    return enemy.getInt("atk");
  }
  
  int getDef(){
    return enemy.getInt("def");
  }
  
  int getHpp(){
    return enemy.getInt("hpp");
  }
  
  int getExp(){
    return enemy.getInt("exp");
  }
  
  int getLvl(){
    return enemy.getInt("lvl");
  }
  
  int getCdt(){
    return enemy.getInt("cdt");
  }
  
  int getTerr(){
    return enemy.getInt("terr");
  }
  
  int getCash(){
    return enemy.getInt("cash");
  }
  
  int getItem(){
    return enemy.getInt("itm");
  }
  
  PImage getSprite(){
    return loadImage("sprite/enemy/"+enemy.getString("sprite")+".png");
  }
  
  String getEnemyName(){
    return enemy.getString("sprite");
  }
  
  String getSfxInt(){
    return enemy.getString("sfxint");
  }
  
  String getSfxAtk(){
    return enemy.getString("sfxatk");
  }
  
  String getSfxDed(){
    return enemy.getString("sfxded");
  }
}
