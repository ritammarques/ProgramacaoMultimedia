class Sobre extends Botoes{
  String []sobre;
  void desenha(){
    sobre= loadStrings("sobre.txt");
  size(700, 670);  //inicial 720(+200 do menu)x960 -> inicial 504(+200 do menu)x672
  background(0);
  fill(0, 0, 255);
  rectMode(CORNER);
  rect(0,0, 500, 670); 
  textAlign(CORNER);
  textSize(15);
  fill(255);
  for(int i=0;i<sobre.length; i++){
  text(sobre[i],100, yi+i*20);
  }
  }
  void botao(){
    fill(255);
    textAlign(CENTER);
    textSize(30);
    text("SOBRE", xi-200, yi);
  }
   boolean opcaoBotao4() {
    if (abs((xi-200)-mouseX)<largBotao/2 && abs(yi-mouseY)<altBotao/2 && mousePressed==true) {
      return true;
    } else {
      return false;
    }
  }
}