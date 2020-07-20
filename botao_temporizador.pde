class Temporizador extends Botoes{
  int p=0;
  int n=0;
  Botoes b= new Botoes();
  void desenhar(int p){
    rectMode(CENTER);
    noStroke();
    if((b.opcaoBotao1()||b.opcaoBotao2())==true){
      n++;
    }
    if(n>0){
    if(p%2!=0){
    fill(255);
  
    rect(xi,height-40,largBotao/2,altBotao/2,7);
    textAlign(CENTER);
    textSize(10);
    fill(255,0,0);
      text("desligado", xi,height-40);
      
    }
       if(p%2==0){
    fill(255,0,0);
  
    rect(xi,height-40,largBotao/2,altBotao/2,7);
    textAlign(CENTER);
    textSize(10);
    fill(255);
    text("ligado", xi,height-40);
      
    
  }
  textSize(15);
  fill(255);
  text("temporizador",xi, height-65);
  }
  
  }
  boolean desligado(int p){
    
    
    
    if(p%2!=0){
      return false;}
      else{ return true;
      }
    
}
 boolean opcaoBotao3() {
   
    if (abs(xi-mouseX)<largBotao/4 && abs((height-40)-mouseY)<altBotao/4&& mousePressed==true) {
      return true;
    } else {
      return false;
    }
  }

}