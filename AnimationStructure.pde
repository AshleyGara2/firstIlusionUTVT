//AnimationStructure
//Elaborado por: Ashley Galicia Ramirez
//Fecha de creación: 04 de diciembre de 2021
//fecha de ultima modificación: 05 de diciembre de 2021
//comentario:
class AnimationStructure{
  ArrayList <SpriteSet> seqs;
  int activesprset;
  boolean activeanimation;
  
  AnimationStructure(){
    seqs=new ArrayList <SpriteSet>();
    activesprset=0;
    activeanimation=true;
  }
  
  void addSpriteSet(SpriteSet ss){
    seqs.add(ss);
  }
  
  void display(int x,int y,int w,int h){
    if(activeanimation && seqs.size()>0){
      seqs.get(activesprset).display(x,y,w,h);
    }
  }
  
  PImage[]getSprites(){
    return seqs.get(activesprset).sprt;
  }
  
  void setActiveSpriteSet(int n){
    activesprset=n;
  }
  
  void nextSpriteSet(){
    if(activesprset<seqs.size())
      activesprset++;
    else
      activesprset=0;
  }
  
  void prevSpriteSet(){
    if(activesprset>0)
      activesprset--;
    else
      activesprset=seqs.size();
  }
  
  void toggleActiveAnimation(){
    activeanimation=!activeanimation;
  } 
}
