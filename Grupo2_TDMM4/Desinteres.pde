class Desinteress {
  float[] positions =new float [50] ;
  float[] positionsC =new float [50] ;
  float[] positionsT =new float [50] ;
  float[] positionsTC =new float [50] ;

  int tam=80;
  float bx;
  float by;
  int bs = 40;
  int bz = 30;
  float xO = width-tam;
  float yO = height-tam;

  float bdifx = 0.0; 
  float bdify = 0.0; 

  float esquinaX= 730;
  float esquinaY = 530;

  float posXfigura=esquinaX;
  float posYfigura=esquinaY;

  float xspeedC = 1; 
  float yspeedC = 1; 
  boolean controlo = false;

  int[] xdirectionC =new int [50] ;
  int[] ydirectionC =new int [50] ;
  int[] xdirectionT =new int [50] ;
  int[] ydirectionT =new int [50] ;
  int[] xdirectionTC =new int [50] ;
  int[] ydirectionTC =new int [50] ;

  color[] colores =new color [50] ;
  PImage imagen;
  float lerping = 1;

  //ACA TA TOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOODO LO RELACIONADO A LOS COLOREEEEEEEEEEEEEEEEEEEEEEEEEEESSSSSSSSSSSSSSSSSSSSSSSSSSSS Y LAS MANCHASSSSSSSSSSSSSSSSSA AAAAAAAAAAAAAAAAAAAAAAAA (pero estas son las variables)
  Paleta miPaletaTranqui;
  Paleta miPaletaIntensa;
  PImage mancha;
  PImage trazo;
  PImage fondo = new PImage();

  // imagen
  PImage imagenP[];
  PImage imagenA[];
  PImage splash[];
  color paletaA[];
  int cant = 4;
  //timer
  int time;
  int espera = 500;
  int cual = 0;
  color individualProtagonista;

  Desinteress(PImage[] p, PImage[] a, PImage[] s) {
    imagenP = p;
    imagenA = a;
    splash = s;

    rectMode(CORNER);
    ellipseMode(CORNER);
    size(800, 600);
    bx = width/2.0;
    by = height/2.0;
    rectMode(RADIUS);
    ellipseMode(CENTER);

    for (int i=0; i < 49; i+=2) {
      positions[i]= random(width-490);
    }
    for (int i=1; i < 49; i+=2) {
      positions[i]= random(height-height/2-30);
    }


    for (int i=0; i < 49; i+=2) {
      positionsC[i]= random(width-490);
    }
    for (int i=1; i < 49; i+=2) {
      positionsC[i]= random(0, height-height/2-30);
    }
    for (int i=0; i < 49; i++) {
      xdirectionC[i]= int(random(-2, 2));
      while (xdirectionC[i]==0) {
        xdirectionC[i]= int(random(-2, 2));
      }
    }
    for (int i=0; i < 49; i++) {
      ydirectionC[i]= int(random(-2, 2));
      while (ydirectionC[i]==0) {
        ydirectionC[i]= int(random(-2, 2));
      }
    }
    for (int i=0; i < 49; i+=2) {
      positionsT[i]= -200;
    }
    for (int i=1; i < 49; i+=2) {
      positionsT[i]= -200;
    }
    for (int i=0; i < 49; i++) {
      xdirectionT[i]= int(random(-2, 2));
      while (xdirectionT[i]==0) {
        xdirectionT[i]= int(random(-2, 2));
      }
    }
    for (int i=0; i < 49; i++) {
      ydirectionT[i]= int(random(-2, 2));
      while (ydirectionT[i]==0) {
        ydirectionT[i]= int(random(-2, 2));
      }
    }
    strokeWeight(2.5);

    //ACA TA TOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOODO LO RELACIONADO A LOS COLOREEEEEEEEEEEEEEEEEEEEEEEEEEESSSSSSSSSSSSSSSSSSSSSSSSSSSS Y LAS MANCHASSSSSSSSSSSSSSSSSA AAAAAAAAAAAAAAAAAAAAAAAA
    //ACA ARRANCA LO QUE ES EL TRAZO DE PINTURA
    miPaletaTranqui = new Paleta( "tranquis4.png" ); //la paleta
    miPaletaIntensa = new Paleta( "intensos4.png" ); //la paleta
    mancha = loadImage( "mancha1pasiva.png"); // trazos
    mancha.filter( INVERT );
    // trazo = createImage(70, 70, RGB);
    //trazo.filter( INVERT );
    for (int j=0; j < 15; j++) {
      colores[j] = miPaletaIntensa.darUnColor( random(150, 255));
    }

    individualProtagonista = miPaletaTranqui.darUnColor( random(150, 255));
  }
  //TIMER
  void vacio() {
    if (millis() - time >= espera) {
      cual = int(random(cant));
      time = millis();//also update the stored time
    }
  }
  void interaccion() { 
    tint(255, 70);

    image(fondo, 0, 0);
    //background(255, 100);
    fill(255);
    vacio();
    //ACA SE DIBUJAN LOS CIRCULOS
    for (int j=0; j < 5; j++) {
      if (j % 2 == 0) {
        tint( colores[j] );
      }
      positionsC[j*2] = positionsC[j*2]+ ( xspeedC * xdirectionC[j] );
      positionsC[j*2+1] = positionsC[j*2+1] + ( yspeedC * ydirectionC[j] );

      if (positionsC[j*2] > width-width/2 -70 || positionsC[j*2] < 0) {
        xdirectionC[j] *= -1;
      }
      if ( positionsC[j*2+1] > 590|| positionsC[j*2+1] < 1) {
        ydirectionC[j] *= -1;
      }

      fill(0, 0, 255);
      image (imagenA[cual], positionsC[j*2], positionsC[j*2+1], tam, tam) ;
    }

    tint(individualProtagonista);
    if (controlo) {
      //noCursor();
      xO = mouseX;
      yO = mouseY;
      if (mouseX< width-width/2 -70) {
        controlo=false;
      } else {
        image(imagenP[cual], mouseX, mouseY, tam, tam);
      }
    } else {
      cursor();
      xO = lerp(xO, esquinaX, lerping);
      yO = lerp(yO, esquinaY, lerping);
      image(imagenP[cual], xO, yO, tam, tam);
      image(splash[cual], xO, yO);
    }


    for (int i=0; i < 25; i++) {
      if ( positionsC[i*2] > 401) {
        positionsTC[i*2] = positionsC[i*2];
        positionsTC[i*2+1] = positionsC[i*2+1];
        positionsC[i*2]=-2000;
        positionsC[i*2+1]=-2000;
      }
      if ( positions[i*2] > 401) {
        positionsT[i*2] = positions[i*2];
        positionsT[i*2+1] = positions[i*2+1];
        positions[i*2]=-2000;
        positions[i*2+1]=-2000;
      }
    }
  }

  void seleccion() {
    if (desinteres.controlo) {
      desinteres.controlo=false;
    } else {
      float dista = dist(mouseX, mouseY, desinteres.posXfigura, desinteres.posYfigura);
      if (dista < desinteres.tam) {
        desinteres.controlo = true;
        //noCursor();
        desinteres.lerping=0.01;
      } else {
        desinteres.controlo = false;
      }
    }
  }

  ///fin de clase
}
