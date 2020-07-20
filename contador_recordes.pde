class Record extends Botoes{
  
  String a;// nomes niveis;
  ArrayList<String>p= new ArrayList();
  // numero segundos no nivel;
  String b;
  int c=1;// nuemro do nivel
  ArrayList d= new ArrayList(c);
  void Record(String b,int c){
    String[]a= new String[c];
    fill(255);
      noStroke();
      rectMode(CENTER);
      rect(xi, height-height/2,largBotao, altBotao*2,7);
      fill(0);
      textSize(15);
      textAlign(CENTER);
      text("TEMPO", xi,height-height/2-altBotao+15);
    for(int i=0; i<c; i++){
      d.add(c);
      p.add(b);
      a[i]="nivel";
      if(c!=0){
     text(a[i] + (int)d.get(i) +":" + p.get(i), xi,height-height/2+10*i*2);
     
      }
    }
    
    
  }
}