class Individualismo {
  // usuario
  float tam = 80;
  float x = width/2;
  float y = height/2;
  float dirX = 1;
  float dirY = 1;
  boolean controlo = false;
  float xO = 0;
  float yO = 0;
  float lerping = 1;

  ////Arreglos de las figuras y sus direcciones y posiciones
  float[] positions =new float [50] ;

  float bx;
  float by;
  int bs = 40;
  int bz = 30;

  float bdifx = 0.0; 
  float bdify = 0.0; 

  float xspeedC = 2; 
  float yspeedC = 2; 

  int[] xdirection =new int [50] ;
  int[] ydirection =new int [50] ;

  int seleccionado = 0;
  //Colores
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

  ////

  //TIMER
  void vacio() {
    if (millis() - time >= espera) {
      cual = int(random(cant));
      time = millis();//also update the stored time
    }
  }

  Individualismo(PImage[] p, PImage[] a, PImage[] s) {
    pushStyle();
    imagenP = p;
    imagenA = a;
    splash = s;
    int xFormacion = width/2, yFormacion = height/2;
    rectMode(CENTER);
    imageMode(CENTER);
    positions[0]= xFormacion;
    positions[1]= yFormacion;
    positions[2]= xFormacion+80;
    positions[3]= yFormacion;
    positions[4]= xFormacion+80;
    positions[5]= yFormacion+80;
    positions[6]= xFormacion;
    positions[7]= yFormacion+80;
    positions[8]= xFormacion + 80;
    positions[9]= yFormacion + 160;
    positions[10]= xFormacion;
    positions[11]= yFormacion+160;
    for (int i=0; i < 15; i++) {
      ydirection[i]= 1;
      while (ydirection[i]==0) {
        ydirection[i]= 1;
      }
    }
    for (int i=0; i < 15; i++) {
      xdirection[i]= 1;
      while (xdirection[i]==0) {
        xdirection[i]= 1;
      }
    }

    for (int i=2; i < 15; i++) {
      if (i % 2 == 0) {
      } else {
      }
    }
    // ----------------- COLORES --------------------------------

    //ACA ARRANCA LO QUE ES EL TRAZO DE PINTURA
    miPaletaTranqui = new Paleta( "tranquis4.png" ); //la paleta
    miPaletaIntensa = new Paleta( "intensos4.png" ); //la paleta
    mancha = loadImage( "mancha1pasiva.png"); // trazos
    mancha.filter( INVERT );

    for (int j=0; j < 15; j++) {
      colores[j] = miPaletaTranqui.darUnColor( random(150, 255));
    }

    individualProtagonista = miPaletaIntensa.darUnColor( random(150, 255));
    popStyle();
  }

  void _look_usuario() {
    // como se ve
    fill(#35D3CA);
    noStroke();
    smooth();
  }

  void _look_otros() {
    // como se ve
    fill(255, 0, 0);
    noStroke();
    smooth();
  }

  void _usuario(float a, float b) {
  }

  void _otro() {
    _look_otros();
    x = x + (xspeedC*dirX);
    y = y + (yspeedC*dirY);

    if (controlo) {

      xO = mouseX;
      yO = mouseY;
      x= xO;
      y = yO;
      tint( individualProtagonista );
      image(imagenA[cual], xO, yO, tam, tam);
    } else {

      xO = lerp(xO, positions[seleccionado], lerping);
      yO = lerp(yO, positions[seleccionado+1], lerping);

      tint(#FAE950);
      image(imagenP[cual], xO, yO, tam, tam);
    }  



    for (int j=0; j < 12; j=j+2) {

      positions[j] = positions[j]+ ( xspeedC * xdirection[j] );
      positions[j+1] = positions[j+1] + ( yspeedC * ydirection[j] );

      if (positions[j] > width- 30 || positions[j] < 0) {
        xdirection[j] *= -1;
      }
      if ( positions[j+1] > 600|| positions[j+1] < 0) {
        ydirection[j] *= -1;
      }


      if (j % 2 == 0) {
        tint( #FAE950);
      }
      if (j != seleccionado) {
        image(imagenP[cual], positions[j], positions[j+1], tam, tam) ;
      }
    }
  }


  void interaccion() {
    tint(255, 70);
    image(fondo, 0, 0);
    vacio();
    _otro();
    if (ind.lerping<1) {
      ind.lerping= ind.lerping + 0.001;
    }
  }

  void seleccion() {
    if (ind.controlo) {
      ind.controlo=false;
      ind.xdirection[ind.seleccionado] = ind.xdirection[0];
      ind.ydirection[ind.seleccionado] = ind.ydirection[0];
      cursor();
    } else {

      for (int i=0; i < 12; i++) {
        if (i % 2 == 0) {
          float dista = dist(mouseX, mouseY, ind.positions[i], ind.positions[i+1]);

          if (dista < ind.tam) {
            //noCursor();
            ind.seleccionado = i;
            ind.controlo = true;
            ind.lerping=0.01;
          } else {
            //ind.controlo = false;
            //ind.seleccionado=20;
          }
        }
      }
    }
  }
  ///// fin de clase
}
