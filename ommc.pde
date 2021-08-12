class Game {
  PImage[] bgimg = new PImage[4];
  PImage[] eneimg = new PImage[11];
  PImage bomber;
  PImage maru;
  PImage batu;
  String [] quesVoc = {"一番面積の大きい国は?", "正方形の対角線の本数は", "イモリとヤモリ両生類はどっち?", 
    "デジタルコンテンツの先生の名前は?(フルネームで)", "一つ前の内閣総理大臣の名前は?(フルネームで)", 
    "鎌倉幕府を開いた人物は", "桜上水駅前にあるラーメン屋の名前は", "東京都知事の名前", "PCはなんの略?", 
    "大人気漫画「鬼滅の刃」の主人公の名前は?", "東京オリンピックの開会式の場所は", 
    "大人気漫画「onepiece」の主人公の名前は?", "神奈川県の県庁所在地は？", "日本で一番大きい湖は?", 
    "ハイボールはソーダとなにを混ぜる", "ドラゴンボールの作者は?", "天の川の英訳は?", 
    "「電圧＝電流×抵抗」、これは何の法則？", "絵の具で、赤と青と黄を混ぜると何色になる？", 
    "英文の終止符は「ピリオド」、では日本語の文の終止符は？", "ＣＤって何の略？", "99歳のことを何という？"};
  String [] ansVoc  = {"rosia", "nihonn", "yamori", "kitaharateturou", "abesinnzou", "minamotonoyoritomo", 
    "oudouya", "koikeyuriko", "pa-sonarukonnpyu-ta", "kamadotannjirou", "sinnkokuritukyougijou", 
    "monnki-deli-rufi-", "yokohamasi", "biwako", "uisuki-", "toriyamaakira", "miruki-ulei", "o-munohousoku", 
    "kuro", "kutenn", "konnpakutodelisuku", "hakujyu"};
  String letter;
  String text_data = "";
  int ques_num = int(random(quesVoc.length));
  int bgnum = int(random(bgimg.length));
  int enenum = int(random(eneimg.length));
  //クリアした問題数
  int clear_cnt = 0;
  //全問クリアにかかった時間
  int clear_time = 0;
  int game_status = 0;
  int s;
  //1問ごとの回答時間
  int timeLimit = 30;
  //ゲームクリアの問題数
  int clear_line = 12;
  int ene_cnt = 0;
  //何問ごとに敵が変わるか
  int ene_line = 3;
  int tm0;


  Game() {
    bgimg[0] = loadImage("jangle.jpg");
    bgimg[1] = loadImage("kazan.jpg");
    bgimg[2] = loadImage("cosmo.jpg");
    bgimg[3] = loadImage("ocean.jpg");
    eneimg[0] = loadImage("keiten.png");
    eneimg[1] = loadImage("toto.png");
    eneimg[2] = loadImage("brook.png");
    eneimg[3] = loadImage("arlong.png");
    eneimg[4] = loadImage("kongou_rikishi_set.png");
    eneimg[5] = loadImage("monster06.png");
    eneimg[6] = loadImage("myouou.png");
    eneimg[7]= loadImage("pa-ntou.png");
    eneimg[8]= loadImage("hangyojin.png");
    eneimg[9]= loadImage("zombie.png");
    eneimg[10] = loadImage("utyujinn.png");
    bomber = loadImage("bakuhatsu.png");
    maru = loadImage("quiz_woman_maru.png");
    batu = loadImage("quiz_man_batsu.png");
  }

  void time(int tm0) {
    //タイマー処理
    int tm = millis() - tm0;
    s = tm / 1000;
    int countDown = (timeLimit - s);
    //println(timeLimit + "-"+ s + " = " + countDown );
    if (countDown > 3) {
      fill(180);
    } else if (countDown > 0) {
      fill(255, 0, 0);
    } else {
      game_status = 2;
    }
    text("COUNT DOWN : " + countDown, 250, 50);
  }

  void gameover() {
    background(120);
    String title = "Game Over";
    fill(255, 20, 20);
    textSize(100);
    text(title, width/2, height/3);
    String to_play = "Enterキーを押すとスタート画面に戻る";
    fill(255);
    textSize(30);
    text(to_play, width/2, height*2/3);
  }

  void start_window() {
    image(bgimg[0], 0, 0, width, height);
    fill(255);
    textSize(300);
    String title = "西打";
    text(title, width/2, height/2);
    String to_play = "Enterキーを押すとゲーム開始";
    textSize(30);
    text(to_play, width/2, height*2/3);
    fill(255, 0, 0);
    String attenntion1 = "んはnnと打ってください!";
    text(attenntion1, width/2, height/7);
    String attenntion2 = "さ行、た行などはhを使わずに、si、tiと打ってください！";
    text(attenntion2, width/2, height/5);
    String attenntion3 = "母音の小文字「ぁ」などはlaと「l」を付けて打ってください！";
    text(attenntion3, width/2, height/6);
    String attenntion4 = "じゃ行は「jya」の様に「jy」を付けて打ってください！";
    text(attenntion4, width/2, height/4);
    textSize(50);
    String attenntion = "注意事項";
    text(attenntion, width/2, height/11);
  }

  void play() {
    image(bgimg[bgnum], 0, 0, width, height);
    image(eneimg[enenum], width/4, height/4, width/2, height/2);
    letter = quesVoc[ques_num];
    fill(255);
    textSize(width/30);
    text(letter, width/2, height/5);
    text(text_data, width/2, height*4/5);
    text("クリア数：" + clear_cnt, width-250, 50);
    fill(255, 0, 0);
    textSize(width/50);
    String tab = "TABキーを押すと全文字消去";
    text(tab, width/2, height -height/20);
  }

  void judge_answer() {
    println("判定");
    println(text_data);
    println(ansVoc[ques_num]);
    if (text_data.equals(ansVoc[ques_num])) {
      println("正解");
      text_data = "";
      clear_cnt++;
      ene_cnt++;
      for (int i = 0; i < 50; i++) {
        image(maru, width*4/5, height/2, height/5, height/5);
      }
      if (clear_cnt >= clear_line) {
        game_status = 3;
      }
      que_reset();
      if (ene_cnt >= ene_line) {
        ene_reset();
      }
      clear_time += s;
      tm0 = millis();
    } else {
      println("不正解");
      for (int i = 0; i < 50; i++) {
        image(batu, width*4/5, height/2, height/5, height/5);
      }
    }
  }

  void clear_window() {
    image(bgimg[2], 0, 0, width, height);
    fill(255);
    textSize(width/30);
    text("あなたのタイムは" + clear_time + "秒です", width/2, height/2);
    String to_play = "Enterキーを押すとスタート画面に戻る";
    fill(255);
    textSize(30);
    text(to_play, width/2, height*2/3);
  }

  void reset() {
    g.game_status = 1;
    tm0 = millis();
    ques_num = int(random(quesVoc.length));
    bgnum = int(random(bgimg.length));
    enenum = int(random(eneimg.length));
    clear_cnt = 0;
    clear_time = 0;
    text_data = "";
  }

  void que_reset() {
    int ques_num_prev = ques_num;
    do {
      ques_num = int(random(quesVoc.length));
    } while (ques_num_prev == ques_num);
    int bgnum_prev = bgnum;
    do {
      bgnum = int(random(bgimg.length));
    } while (bgnum == bgnum_prev);
  }

  void ene_reset() {
    for (int i = 0; i < 60; i++) {
      image(bomber, width/4, height/4, width/2, height/2);
    }
    int enenum_prev = enenum;
    do {
      enenum = int(random(eneimg.length));
    } while (enenum == enenum_prev);
    ene_cnt = 0;
  }
}

Game g;



void setup() {
  size(1600, 1200);
  noStroke();
  textAlign(CENTER);
  PFont font = createFont("Meiryo", 50);
  textFont(font);
  g = new Game();
}

void draw() {
  switch(g.game_status) {
    //スタート画面
  case 0:
    g.start_window();
    break;

    //プレイ画面
  case 1:
    g.play();
    g.time(g.tm0);
    break;

    //ゲームオーバー画面
  case 2:
    g.gameover();
    break;

    //クリア画面
  case 3:
    g.clear_window();
    break;
  }
}


void keyPressed() {
  switch(g.game_status) {
    //スタート画面
  case 0:
    if (key == ENTER) {
      g.reset();
    }
    break;

    //プレイ画面
  case 1:
    if (key == BACKSPACE) {
      if (g.text_data.length() > 0) {
        g.text_data = g.text_data.substring(0, g.text_data.length()-1);
      }
    } else if (key == ENTER) {
      g.judge_answer();
    } else if (key == TAB) {
      g.text_data = "";
    } else {
      g.text_data = g.text_data + key;
    }
    break;

    //ゲームオーバー画面
  case 2:
    if (key == ENTER) {
      g.game_status = 0;
    }
    break;

    //クリア画面
  case 3:
    if (key == ENTER) {
      g.game_status = 0;
    }
    break;
  }
}
