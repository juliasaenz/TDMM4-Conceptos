class Xenofobiaa {
  float[] positions =new float [50] ;
  float[] positionsC =new float [50] ;
  float[] positionsT =new float [50] ;
  float[] positionsTC =new float [50] ;

  int tam=80;
  float bx;
  float by;
  int bs = 40;
  int bz = 30;


  float bdifx = 0.0; 
  float bdify = 0.0; 


  float xspeedC = 1; 
  float yspeedC = 1; 

  int[] xdirectionC =new int [50] ;
  int[] ydirectionC =new int [50] ;
  int[] xdirectionT =new int [50] ;
  int[] ydirectionT =new int [50] ;
  int[] xdirectionTC =new int [50] ;
  int[] ydirectionTC =new int [50] ;

  float lerping = 1;

  PImage imagen;

  //ACA TA TOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOODO LO RELACIONADO A LOS COLOREEEEEEEEEEEEEEEEEEEEEEEEEEESSSSSSSSSSSSSSSSSSSSSSSSSSSS Y LAS MANCHASSSSSSSSSSSSSSSSSA AAAAAAAAAAAAAAAAAAAAAAAA (pero estas son las variables)
  color[] colores =new color [50] ;
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

  //control del prota
  boolean controlo=false;
  float x, y;

  ////

  //TIMER
  void vacio() {
    if (millis() - time >= espera) {
      cual = int(random(cant));
      time = millis();//also update the stored time
    }
  }

  Xenofobiaa(PImage[] p, PImage[] a, PImage[] s) {
    imagenP = p;
    imagenA = a;
    splash = s;

    bx = width/2.0;
    by = height/2.0;
    rectMode(RADIUS);

    y=520;
    x=730;

    for (int i=0; i < 49; i+=2) {
      positions[i]= random(width-430);
    }
    for (int i=1; i < 49; i+=2) {
      positions[i]= random(height-height/2-30);
    }


    for (int i=0; i < 49; i+=2) {
      positionsC[i]= random(width-430);
    }
    for (int i=1; i < 49; i+=2) {
      positionsC[i]= random(0, height-20);
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




  void interaccion() { 
    //el fondeto
    tint(255, 70);

    image(fondo, 0, 0);

    /////////////

    fill(255);
    rectMode(CORNER);
    ellipseMode(CORNER);


    vacio();
    if (controlo) {
      if (lerping < 1 && mouseX<= 500) {
        lerping= lerping + 0.08;
      } else if (lerping > 1) {
        lerping = 1;
      }
      if (int(lerping) == 1 && ! (mouseX<= 500)) {
        lerping = 0.01;
      }
    }
    //ACA SE DIBUJAN LOS CIRCULOS
    for (int j=0; j < 6; j++) {

      positionsC[j*2] = positionsC[j*2]+ ( xspeedC * xdirectionC[j] );
      positionsC[j*2+1] = positionsC[j*2+1] + ( yspeedC * ydirectionC[j] );
      if (x<= 500) {
        positionsC[0] = lerp(positionsC[0], 338, lerping);
        positionsC[1] = lerp(positionsC[1], y, lerping);
        positionsC[2] = lerp(positionsC[0], 338, lerping);
        positionsC[3] = lerp(positionsC[1], y+60, lerping);
        positionsC[4] = lerp(positionsC[0], 338, lerping);
        positionsC[5] = lerp(positionsC[1], y-60, lerping);

        for (int i=0; i < 2; i++) {
          xdirectionT[i]= int(random(-2, 2));
          while (xdirectionT[i]==0) {
            xdirectionT[i]= int(random(-2, 2));
          }
        }
        for (int i=0; i < 2; i++) {
          ydirectionC[i]= int(random(-2, 2));
          while (ydirectionT[i]==0) {
            ydirectionC[i]= int(random(-2, 2));
          }
        }
      } else {
        lerping = 0.01;
      }

      if (positionsC[j*2] > width-width/2 -30 || positionsC[j*2] < 0) {
        xdirectionC[j] *= -1;
      }
      if ( positionsC[j*2+1] > 570|| positionsC[j*2+1] < 1) {
        ydirectionC[j] *= -1;
      }

      if (j % 2 == 0) {
        tint( #001C71 );
      }
      if (x>=500) {
        image (imagenP[cual], positionsC[j*2], positionsC[j*2+1], tam, tam) ;
      } else {
        image (imagenA[cual], positionsC[j*2], positionsC[j*2+1], tam, tam) ;
      }
    }
    tint(individualProtagonista);
    if (controlo) {
      if (x>=400) {
        image(imagenP[cual], x, y, tam, tam);
        x=mouseX;
        y=mouseY;
      } else {
        image(imagenP[cual], 400, y, tam, tam);
        x=mouseX;
        y=mouseY;
      }
    } else {
      image(imagenP[cual], x, y, tam, tam);
      image(splash[cual], x, y, tam, tam);
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
    if (xeno.controlo && xeno.x >= width/2) {
      xeno.controlo=false;
      cursor();
    } else {
      float dista = dist(mouseX, mouseY, xeno.x, xeno.y);
      if (dista < xeno.tam) {
        //noCursor();
        xeno.controlo = true;
        xeno.lerping=0.01;
      } else {
        xeno.controlo = false;
      }
    }
  }
  ///
}
