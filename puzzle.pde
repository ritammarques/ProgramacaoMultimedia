Sobre sobre= new Sobre();
Temporizador liga= new Temporizador();
PuzzleIni objPuzzle = new PuzzleIni();
Botoes objBotoes = new Botoes();
Acessorios objAcessorio = new Acessorios();
Record records= new Record();
import processing.sound.*;
SoundFile som1;
SoundFile som2;
SoundFile somGanhar;
SoundFile somPerder;
int p=1;
String result="";
int nivel=1; //nível inicial
int iniAcessorio=0; //desenho do relogio e contador para arranque
int n=0;
void setup() {
  //desenho do texto inicial Puzzle
  size(700, 670);  //inicial 720(+200 do menu)x960 -> inicial 504(+200 do menu)x672
  background(0);
  fill(0, 0, 255);
  rect(0,0, 500, 670); 
  textAlign(CENTER);
  textSize(100);
  fill(255);
  text("PUZZLE", 250, 350);
sobre.botao();
  objBotoes.desenhar(); //desenha botoes
  objPuzzle.importarImagens(); //chama procedimento importarImagens
  
  //som de peça certa
 
  som1=new SoundFile (this, "wosh.mp3");
  //som de peça errada
  som2=new SoundFile (this, "mov_imp.mp3");
  //som ganhou
  somGanhar=new SoundFile (this, "ganhar.mp3");
  //som perdeu
  somPerder=new SoundFile (this, "perder.mp3");
  
}

void draw() {
   if(objBotoes.opcaoBotao1()||objBotoes.opcaoBotao2()){
     n++;
   }
   if(n<1){// so mostrar o sobre s nao estiver o puzzle
 
  if(sobre.opcaoBotao4()==true){// botao sobre
    sobre.desenha();// escreve sobre
  }
  }
  if(liga.opcaoBotao3()==true){// botao liga desliga do temporizador
    p++;
    delay(200);
  }
    
   if(objBotoes.opcaoBotao1()||objBotoes.opcaoBotao2()){
    iniAcessorio=1;
    objAcessorio.reiniciar();
   
    print(objAcessorio.tempo());
  }

  if (objBotoes.opcaoBotao1()) { //primeiro botão se clicado
    objPuzzle.desenharImagens(); //desenha puzzle
    delay(200);
    nivel=1;// faz pausa de 0.2 segundos durante o clicar do botão1
   
    //println("-> Iniciar");
  }
   if (objBotoes.opcaoBotao2()) { //segundo botão se clicado
    objPuzzle.jogar(nivel); //desenha jogo já com peça preta
    if(nivel>1){
    records.Record(objAcessorio.tempo(),nivel-1);
    }

 
    iniAcessorio=1; //variavel para inicializar o contador e relogio
    delay(200); // faz pausa de 0.2 segundos durante o clicar do botão1
    //println("-> Jogar");
  }
  
  if(p%2==0){
  objAcessorio.desenhaRelogio(iniAcessorio); // desenha relogio
  objAcessorio.contar(iniAcessorio);
  }// relogio começa a contar
    
  objPuzzle.opcaoImagem(iniAcessorio); // deteta peça pressionada 
  liga.desenhar(p);
}