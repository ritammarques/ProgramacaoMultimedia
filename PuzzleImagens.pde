class PuzzleIni {//COLHA DE LIGAR DESLIGAR
  //Variaveis
  Temporizador liga= new Temporizador();
  int mmm=0;
  String nomefich; //variavel do nome do ficheiro
  PImage img; //variavel do nome da imagem
  PImage imgaux;// variavel auxiliar para fazer trocar de imagens
  PImage images[][]; //array para guardar imagens
  PImage imagesAux[][]; // array auxiliar para guardar imagens por ordem inicial
  PImage imgPreta; // imagem que tapa peça removida
  int iPreta; //indice da linha da peça preta
  int jPreta; //indice da coluna da peça preta
  int movimentos; //variavel com numero de movimentos
  int iGanhou; //variavel para controle se ganhou
  String [] linhas; //array das linhas do ficheiro texto

  int col; //nº de colunas
  int lin; //nº de linhas
  int n; // valor multiplicado pelo nivel = numero de vezes a baralhar
  int fator; // fator multiplicação para movimentos maximos

  int moldura = 3; // espessura da moldura
  int larg = 500; //largura do puzzle
  int alt = 670; //altura do puzzle

  float peca; // peça preta inicial
  int numero; //numero da imagem

  IntList numLinha = new IntList(); // guarda sequencialmente o numero da linha da peça movida
  IntList numColuna = new IntList(); // guarda sequencialmente o numero da coluna da peça movida
  IntList numsentido = new IntList(); // guarda sequencialmente o sentido da peça movida

  IntList numLinhaP = new IntList(); // guarda sequencialmente o numero da linha da peça preta movida para posteriormente mostrar solução
  IntList numColunaP = new IntList(); // guarda sequencialmente o numero da coluna da peça preta movida para posteriormente mostrar solução
  IntList numsentidoInv = new IntList(); // guarda sequencialmente o sentido inverso da peça preta movida para posteriormente mostrar solução

  IntList numLinhaPJog = new IntList(); // guarda sequencialmente o numero da linha da peça movida para pelo jogador posteriormente mostrar solução
  IntList numColunaPJog = new IntList(); // guarda sequencialmente o numero da coluna da peça movida para pelo jogador posteriormente mostrar solução
  IntList numsentidoInvJog = new IntList(); // guarda sequencialmente o sentido inverso da peça movida pelo jogador para posteriormente mostrar solução

  IntList ordemJogo = new IntList(); // guarda ordem das peças atualizada em cada jogada
  int auxIndex; //variavel aux para fazer a troca dos indexs no arrayList ordemJogo

  int movAleatorio=0; //variavel dos movimentos começam a zero
  int movAleatorioAux=0; // variavel movimento da peça anterior
  int ciclos; //numero de ciclos
  int movMax; // variavel dos movimentos maximos possiveis para cada nivel
  String sSentido; // nome dos sentidos dos movimentos das peças
  String sSentido2; //nome dos sentidos dos movimentos inversos das peças

  //desenho do contador
  float largBotao=150;
  float altBotao=70;
  float xi=600;
  float yi=70;

  void importarImagens() {

    linhas = loadStrings("texto.txt"); // guarda lista de strings do ficheiro texto

    lin = parseInt(linhas[0]); //linhas
    col = parseInt(linhas[1]); //colunas
    nomefich = linhas[2]; //nome do ficheiro
    n = parseInt(linhas[4]); // importa valor multiplicado pelo nivel = nº de vezes a baralhar
    println(n);
    fator = parseInt(linhas[6]); // importa fator para determinar valor dos movimentos maximos
    
    imgPreta = createImage(larg/col-moldura, alt/lin-moldura, RGB); // desenha imagem preta

    images = new PImage[lin][col]; // array para guardar peças
    imagesAux = new PImage[lin][col]; // array que guarda peças iniciais
    img = loadImage(nomefich); // carregar ficheiro na variavel
    img.resize(500, 670); // redimensiona imagem ao tamanho pedido
    for (int j = 0; j < col; j++) { // ciclo colunas
      for (int i = 0; i < lin; i++) { //ciclo linhas
        images[i][j] = img.get((j+1)*larg/col-moldura-(larg/col-moldura), (i+1)*alt/lin-moldura-(alt/lin-moldura), larg/col-moldura, alt/lin-moldura); // guarda peças para jogar

        //images[i][j] = img.get(j*larg/col-moldura, i*alt/lin-moldura, larg/col-moldura, alt/lin-moldura); // guarda peças para jogar
        imagesAux[i][j] = images[i][j]; //guardar peças pela ordem
      }
    }
    //println(lin);
    //println(col);
    //println(nomefich);
  }

  void desenharImagens() {
    fill(255); //cor branca
    rectMode(CORNER);
    rect(0, 0, 500, 670); // rectangulo como fundo

    for (int j = 0; j < col; j++) {
      for (int i = 0; i < lin; i++) {
        images[i][j] = imagesAux[i][j];
        image(images[i][j], j*larg/col, i*alt/lin); //desenha peças
        img=images[i][j];
        numero = 1+i+j*lin; //determina numero da peça

        //save comentado - guarda as peças do puzzle em ficheiros
        //img.save(numero + ".jpg");
      }
    }
  }
  void jogar(int nivel) {
    ciclos=nivel*n; // numero de peças baralhadas
    movMax=ciclos*fator; //numero de movimentos maximos por nivel
    movimentos=movMax; //numero de movimentos, inicializa em 0
    //desenha retangulo para fundo
    fill(255);
    rectMode(CORNER);
    rect(0, 0, 500, 670); 

    peca = int(random(1, lin*col)); //número da peça aleatória
    //peca=int(lin*col); //peça preta inicial (canto direito inferior)

    //limpa array list (metodo clear() consultado do site processing.org)
    numLinha.clear();
    numColuna.clear();
    numsentido.clear();

    numLinhaP.clear();
    numColunaP.clear();
    numsentidoInv.clear();

    numLinhaPJog.clear();
    numColunaPJog.clear();
    numsentidoInvJog.clear();

    ordemJogo.clear();

    for (int j = 0; j < col; j++) {
      for (int i = 0; i < lin; i++) {
        images[i][j] = imagesAux[i][j];

        numero = i+j*lin; 
        ordemJogo.append(numero); // adiciona numero da peça na arrayList
        //(metodo append() consultado do site processing.org)

        if (peca!= 1+i+j*lin) { // controla o numero da peça para verificar se é peça preta, se não for desenha peça
          image(images[i][j], j*larg/col, i*alt/lin);
        } else { // se for, desenha peça preta
          image(imgPreta, j*larg/col, i*alt/lin);
          images[i][j] = imgPreta;
          iPreta=i;
          jPreta=j;
        }
      }
    }

    int k = 0; // contador de ciclos
    int serve=0; // controla se movimento é valido


    while (k < ciclos) { // enquanto condição se verificar realiza as instruções
      //print(" k="+k);
      movAleatorio = int(random(1, 4)); // ao baralhar pode optar por 4 movimentos
      k = k + 1; // vai somando ciclos

      // evitar movimentos consecutivos de avanço e recuo para o mesmo local
      if (movAleatorio==1 && movAleatorioAux==2) movAleatorio=4; //se for para cima (1) e anteriormente tiver ido para baixo(2), força movimento para a direita (4)
      if (movAleatorio==2 && movAleatorioAux==1) movAleatorio=3;
      if (movAleatorio==3 && movAleatorioAux==4) movAleatorio=2;
      if (movAleatorio==4 && movAleatorioAux==3) movAleatorio=1;


      serve=1; // se servir
      //movimentos da peça preta junto aos limites do puzzle
      if (movAleatorio==1 && iPreta==lin-1) { // se peça preta tiver na ulima linha nao realiza movimento de troca com peça de baixo
        k=k-1; // retira ciclo porque nao serve para baralhar este movimento
        serve=0; // variavel guarda informação que o movimento nao ser
      }
      if (movAleatorio==2 && iPreta==0) {
        k=k-1;
        serve=0;
      }
      if (movAleatorio==3 && jPreta==col-1) {
        k=k-1;
        serve=0;
      }      
      if (movAleatorio==4 && jPreta==0) {
        k=k-1;
        serve=0;
      }

      movAleatorioAux=movAleatorio; //guarda movimento anterior para comparar movimentos consecutivos

      if (movAleatorio==1 && serve==1) { // se movimento for possivel 
        moverImagem(iPreta+1, jPreta, movAleatorio, iPreta, jPreta); // há movimento (há troca de peças) , neste caso há troca na linha
      }
      if (movAleatorio==2 && serve==1) {
        moverImagem(iPreta-1, jPreta, movAleatorio, iPreta, jPreta);
      }
      if (movAleatorio==3 && serve==1) {
        moverImagem(iPreta, jPreta+1, movAleatorio, iPreta, jPreta);
      }
      if (movAleatorio==4 && serve==1) {
        moverImagem(iPreta, jPreta-1, movAleatorio, iPreta, jPreta);
      }
    }
  }

  void opcaoImagem(int iniAcessorio) {
    int sentidoAux=0;
    for (int j = 0; j< col; j++) {
      for (int i = 0; i < lin; i++) {
        if (procuraImagem(i, j)==true) { // encontar imagem possivel de mover (true)
          //  verifica o movimento da peça clicada junto à peça preta
          if (iPreta-i==-1 && jPreta-j==0) { // peça preta (3,4) e a outra for(4,4) há movimento para cima
            sentidoAux=1; // peça do puzzle para cima
          }
          if (iPreta-i==1 && jPreta-j==0) {
            sentidoAux=2; // peça do puzzle para baixo
          }
          if (iPreta-i==0 && jPreta-j==-1) {
            sentidoAux=3; // peça do puzzle para esquerda
          }
          if (iPreta-i==0 && jPreta-j==1) {
            sentidoAux=4; // peça do puzzle para direita
          }
          // se não for possivel mover faz som2 
          if (abs(i-iPreta)>1 || abs(j-jPreta)>1 || (abs(i-iPreta)+abs(j-jPreta))>1) som2.play();

          if (sentidoAux>0) // se for possivel movimento
          {
            moverImagem(i, j, sentidoAux, iPreta, jPreta);
            if(liga.opcaoBotao3()==true){
    mmm++;
  }
            //if(mmm%2==0){
            movimentos=movimentos-1; // conta movimentos
           // }
          //  else{
              //movimentos=movimentos;
           // }
            som1.play(); // se for possivel mover faz som1

          // meti
            //testar se ganhou ou perdeu
            iGanhou=1; // esta sempre a testar se ganha
            for (int a = 0; a < ordemJogo.size()-1; a++) {
              if (ordemJogo.get(a+1)-ordemJogo.get(a) != 1) { // se ordem jogo não for igual à ordem inicial ainda nao ganhou
                iGanhou=0;
              }
            }
if(liga.opcaoBotao3()==true){
    mmm++;
  }
            if (iGanhou==1) {
              ganhar(); // quando ganha chama metodo ganhar
            } else// se o botao tiver ligado
            if(mmm%2==0){
              if (movimentos==0) perder(); // perde se ultrapassar limite dos movimentos maximos
            }
            
            
          }
            //println("Linha= "+i  +" Coluna= "+j);
          }
        }
      }
  {}

    if (iniAcessorio==1) objBotoes.desenharContador(movimentos, movMax); // verifica se iniciou o jogo
    objBotoes.desenhar(); // desenha botao contador
  }
  boolean procuraImagem(int i, int j) { // verifica se mouse está em cima do botão contador
    int pontoX = (larg/col);
    int pontoY = (alt/lin);       
    if (abs((j+1)*pontoX-pontoX/2-mouseX)<(larg/col)/2 && abs((i+1)*pontoY-pontoY/2-mouseY)<(alt/lin)/2 && mousePressed==true) {
      return true;
    } else {
      return false;
    }
  }


  void moverImagem(int linha, int coluna, int sentido, int iPt, int jPt) {
    //sentido 1- cima, 2- baixo, 3- esquerda, 4- direita
    // traduz o sentido numerico para texto
    if (sentido==1) sSentido="Cima";
    if (sentido==2) sSentido="Baixo";
    if (sentido==3) sSentido="Esquerda";
    if (sentido==4) sSentido="Direita";    

    //mostra movimentos iniciais e os realizados pelo jogador
    //println("Peça "+ (linha+1)  +"/"+ (coluna+1) +" "+sSentido+" troca com "+(iPt+1)  +"/"+ (jPt+1));

    int linAux=0;
    int colAux=0;
    int trocar=0;
    int sentidoInv=0;

    //verifica se há possibilidade de realizar troca no jogo
    if (sentido==1 && linha>0) { 
      linAux=linha-1;
      colAux=coluna;
      trocar=1;
      sentidoInv=2;
    }
    if (sentido==2 && linha<lin-1) {
      linAux=linha+1;
      colAux=coluna;
      trocar=1;
      sentidoInv=1;
    }
    if (sentido==3 && coluna>0) {
      linAux=linha;
      colAux=coluna-1;
      trocar=1;
      sentidoInv=4;
    }
    if (sentido==4 && coluna<col-1) {
      linAux=linha;
      colAux=coluna+1;
      trocar=1;
      sentidoInv=3;
    }
    if (trocar==1) { // se for possivel trocar esta realiza-se
      iPreta=linha;
      jPreta=coluna;
      imgaux=images[linha][coluna];
      images[linha][coluna]=images[linAux][colAux];
      images[linAux][colAux]=imgaux;

      //para gravar as jogadas aleatórias e do jogador nas intlist
      if (numLinhaP.size()<ciclos) {
        numLinhaP.append(linha+1);
        numColunaP.append(coluna+1);
        numsentidoInv.append(sentidoInv);
      } else {
       numLinha.append(linha+1);
       numColuna.append(coluna+1);
       numsentido.append(sentido);
      }
      println(sentido);

      // ao fazer troca atualiza a ordem das peças no arrayList
      // set() substitui valor na posição     set(index, valor)
      //(metodo set() consultado do site processing.org)
      auxIndex= ordemJogo.get(linAux+colAux*lin);
      ordemJogo.set(linAux+colAux*lin, ordemJogo.get(iPreta+jPreta*lin));     
      ordemJogo.set(iPreta+jPreta*lin, auxIndex);
      //println(numLinha+" / "+numColuna+" / "+numsentidoInv);

      //println(ordemJogo);
    }

    fill(255);
    rectMode(CORNER);
    rect(0, 0, 500, 670);
    for (int j = 0; j < col; j++) {
      for (int i = 0; i < lin; i++) {
        image(images[i][j], j*larg/col, i*alt/lin);
      }
    }
  }

  void ganhar() {
    // se ganhar desenha "ganhou"
    fill(0, 0, 255);
    rectMode(CORNER);
    rect(0, 0, 500, 670);
    textAlign(CENTER);
    textSize(100);
    fill(255);
    text("Ganhou", 250, 350);

    nivel=nivel+1; //troca de niveis
    objBotoes.desenhar(); //botão muda nivel
    somGanhar.play(); //faz som ganhar
    
    //Apresenta jogadas do jogador
    println("Jogadas:");    
    for (int k=0; k<numLinha.size(); k++) {
      // transforma valor numerico em palavras
      if (numsentido.get(k)==1) sSentido="Cima";
      if (numsentido.get(k)==2) sSentido="Baixo";
      if (numsentido.get(k)==3) sSentido="Esquerda";
      if (numsentido.get(k)==4) sSentido="Direita";  
      //apresenta a solução passo a passo
      println("Moveu peça da linha "+numLinha.get(k)+" e da coluna "+numColuna.get(k)+" para "+sSentido);
    }
  }

  void perder() {
    // se perder desenha 
    fill(0, 0, 255);
    rectMode(CORNER);
    rect(0, 0, 500, 670);

    textAlign(CENTER);
    textSize(100);
    fill(255);
    text("Perdeu", 250, 350);

    //inverte ordem da lista dos movimentos baralhados
    //(metodo reverse() consultado do site processing.org)
    //numLinha.reverse();
    //numColuna.reverse();
    //numsentido.reverse();
    numLinhaP.reverse();
    numColunaP.reverse();
    numsentidoInv.reverse(); 

    //Apresenta solução
    println("Solução:");

    for (int k=0; k<numLinhaP.size(); k++) {
      // transforma valor numerico em palavras
      if (numsentidoInv.get(k)==1) sSentido2="Cima";
      if (numsentidoInv.get(k)==2) sSentido2="Baixo";
      if (numsentidoInv.get(k)==3) sSentido2="Esquerda";
      if (numsentidoInv.get(k)==4) sSentido2="Direita";  
      //apresenta a solução passo a passo
      println("Mover peça da linha "+numLinhaP.get(k)+" e da coluna "+numColunaP.get(k)+" para "+sSentido2);
    }
    objBotoes.desenhar();
    somPerder.play(); //som quando perde
  }
}