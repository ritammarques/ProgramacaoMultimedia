class Acessorios extends Botoes {
  int s=0; // segundos iniciais
  int m=0; // minutos iniciais
  int ms=0; //milissegundos iniciais
  String sString = "00"; //desenha dois digitos para segundos
  String mString = "00"; //desenha dois digitos para minutos
String tempo;

  void desenhaRelogio(int iniciar) {
    //desenho do relogio
    if (iniciar==1) { // se inciar=1 desenha botão
      rectMode(CENTER);
      fill(255);
      noStroke();
      rect(xi, yi+6*altBotao, largBotao-40, altBotao-20, 7);
      textSize(30);
      textAlign(CENTER);
      fill(0, 82, 0);
    }
  }
  
void reiniciar(){
  ms=-1;
  m=-1;
  s=-1;
  println(mString+":"+sString);
}// reinicia a contagem

String tempo(){
 
 return( mString+":"+sString);
}

  void contar(int iniciar) {
    if (iniciar==1) { // iniciar=1 começa a contar
      ms=ms+1; //soma milissegundos
      if (ms==59) { //quando ms==59 acrescenta segundo
        s=s+1;
        ms=0;
        if (s<10) { //desenho de dois digitos quando segundo <10 desenha (0,s)
          sString ="0" + str(s);
        } else {
          sString =str(s);
        }
      }
      if (s==59) { // quando s==59 acrescenta minuto
        s=0;
        m=m+1;
        if (m<10) {
          mString ="0" + str(m); //desenho de dois digitos quando s«minuto <10 desenha (0,m)
        } else {
          mString =str(m);
        }
      }
      text(mString + ":" + sString, xi, yi+10+6*altBotao); //escreve tempo
    }
  }
}