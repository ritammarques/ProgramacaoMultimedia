class Botoes {
  //desenho dos botoes
  float largBotao=150;
  float altBotao=70;
  float xi=600;
  float yi=70;

  void desenhar() {
    //desenha primeiro botão
    rectMode(CENTER);
    fill(255, 255, 255);
    noStroke();
    rect(xi, yi, largBotao, altBotao, 7);
    //escreve nome do botão
    textSize(30);
    textAlign(CENTER);
    fill(0, 82, 0);
    text("Inicial", xi, yi+10);

    //desenha segundo botão
    fill(255, 255, 255);
    rect(xi, yi+2*altBotao, largBotao, altBotao, 7);
    //escreve nome do botão
    fill(0, 82, 0);
    text("Jogar", xi, yi-10+2*altBotao);
    text("Nível: "+nivel, xi, yi+30+2*altBotao);
  }
  void desenharContador(int movimentos, int movMax) {
    //desenha contador de movimentos
    rectMode(CENTER);
    fill(255);
    noStroke();
    rect(xi, yi+7*altBotao, largBotao-40, altBotao-20, 7);
    //escreve número de movimentos feitos e número de movimentos máximos
    textSize(30);
    textAlign(CENTER);
    fill(0, 82, 0);
    text(movimentos+"/"+movMax, xi, yi+10+7*altBotao);
    //print(movimentos+"/"+movMax+" ");
  }

  //saber se o rato está dentro do desenho do botão1
  //controla distância entre a posição do mouse e as coordenadas do botão
  boolean opcaoBotao1() {
    if (abs(xi-mouseX)<largBotao/2 && abs(yi-mouseY)<altBotao/2 && mousePressed==true) {
      return true;
    } else {
      return false;
    }
  }
  //saber se o rato está dentro do desenho do botão2
  //controla distância entre a posição do mouse e as coordenadas do botão
  boolean opcaoBotao2() {
    if (abs(xi-mouseX)<largBotao/2 && abs(yi+2*altBotao-mouseY)<altBotao/2 && mousePressed==true) {
      return true;
    } else {
      return false;
    }
  }
}