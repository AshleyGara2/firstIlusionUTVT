//Modulo EnemyTeam  
//elaborado por: Ashley Galicia Ramirez
//fecha de creación: 3 de diciembre de 2021 
//fecha de ultima modificación: 3 de diciembre de 2021 
//comentario:
class EnemyTeam{
  ArrayList <Enemigo> troop;
  int troopsize;
  
  EnemyTeam(){
    troopsize=int(random(1,3));
    troop=new ArrayList<Enemigo>();
    for(int i=0;i<troopsize;i++)
      troop.add(new Enemigo(pers.terr,dcbt));
    placeTroops();
  }
  
  void createTroops(){
    for(int i=0;i<troopsize;i++)
      troop.add(new Enemigo(pers.terr,dcbt));
    placeTroops();
  }
  
  void placeTroops(){
    int cy=350-(troopsize-1)*(100);
    int i=0;
    for(Enemigo e:troop){
      e.setPos(0,cy+(i*100));
    }
  }
  
  void display(){
    for(Enemigo e:troop)
      e.display();
  }
  
  void moveTroops(){
    for(Enemigo e:troop)
      e.move(RIGHT);
  }
  
  void controlTroop(){
  
  }
  
  void clearTroops(){
    troop=null;
  }
}
