class Liderazgoo {
  // usuario
  float x = 0;
  float y = 0;
  float tam = 80;
  // posicion de los npc
  float xO = 0;
  float yO = 0;
  boolean liderSeleccionado=false;

  ////Arreglos de las figuras y sus direcciones y posiciones
  float[] positions =new float [50] ;

  float bx;
  float by;
  int bs = 40;
  int bz = 30;

  float bdifx = 0.0; 
  float bdify = 0.0; 

  float xspeedC = 3; 
  float yspeedC = 3; 

  int[] xdirection =new int [50] ;
  int[] ydirection =new int [50] ;

  float angle = 0; // angulo
  float targetAngle = 0; //angulo target

  // ------------------------------------------ COLORES -----------
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
  float genDista;

  Liderazgoo(PImage[] p, PImage[] a, PImage[] s) {
    imagenP = p;
    imagenA = a;
    splash = s;


    imageMode(CENTER);
    x= width/2;
    y=height/2;

    for (int i=0; i < 49; i+=2) {
      positions[i]= random(width-430);
    }
    for (int i=1; i < 49; i+=2) {
      positions[i]= random(height-height/2-30);
    }

    for (int i=0; i < 10; i++) {
      xdirection[i]= int(random(-2, 2));
      while (xdirection[i]==0) {
        xdirection[i]= int(random(-2, 2));
      }
    }
    for (int i=0; i < 10; i++) {
      ydirection[i]= int(random(-2, 2));
      while (ydirection[i]==0) {
        ydirection[i]= int(random(-2, 2));
      }
    }
    //ACA ARRANCA LO QUE ES EL TRAZO DE PINTURA
    miPaletaTranqui = new Paleta( "tranquis4.png" ); //la paleta
    miPaletaIntensa = new Paleta( "intensos4.png" ); //la paleta
    mancha = loadImage( "mancha1pasiva.png"); // trazos
    mancha.filter( INVERT );

    for (int j=0; j < 15; j++) {
      colores[j] = miPaletaTranqui.darUnColor( random(150, 255));
    }


    individualProtagonista = #FF001B;
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
    int colorActual = 1;
    vacio();

    if (liderSeleccionado) {
      x = mouseX;
      y = mouseY;
      rotacion(x, y);

      _usuario();
    } else {
      //ESTE ES EL MOVIMIENTO DE LAS FIGURAS CUANDO ESTAN LIBREMENTE YENDO DE UN LADO A OTRO
      _usuario();
      for (int j=0; j < 10; j=j+2) {

        positions[j] = positions[j]+ ( xspeedC * xdirection[j] );
        positions[j+1] = positions[j+1] + ( yspeedC * ydirection[j] );

        if (positions[j] > width- 80 || positions[j] < 0) {
          xdirection[j] *= -1;
        }
        if ( positions[j+1] > 520|| positions[j+1] < 0) {
          ydirection[j] *= -1;
        }
        if (liderSeleccionado) {
          tint(#fae950);
        } else {
          tint( #00d4e9 );
        }
        image(imagenP[cual], positions[j], positions[j+1], tam, tam);

        colorActual++;
      }
      colorActual=1;
    }
  }

  //ROTACIÓN DE USUARIO AL REDEDOR DE JUGADOR
  void rotacion(float x_, float y_) {

    //aca en el original va la posicion del que se sigue con esa resta.
    angle = atan2(  mouseY - 250, mouseX - 350 );
    // check and adjust angle to go from 0 to TWO_PI
    //if ( angle < targetAngle - PI ) angle = angle + TWO_PI;
    //if ( angle > targetAngle + PI ) angle = angle - TWO_PI;
    float dir = (angle - targetAngle) / TWO_PI;

    dir = dir - Math.round(dir);
    dir = dir * TWO_PI;
    targetAngle += dir *0.1;
    pushMatrix();
    //aca en el original va el mouse que sigue al jugador.
    translate(mouseX, mouseY);
    rotate(targetAngle);
    //_usuario();
    figuras();
    popMatrix();
  }

  void _usuario() {
    tint(individualProtagonista);
    if (!liderSeleccionado) {
      image(imagenP[cual], x, y, tam, tam);
      image(splash[cual], x, y);
    } else {
      image(imagenA[cual], x, y, tam, tam);
    }
  }

  void _otro(int sumax, int sumay, float lerping, int arregloX, int arregloY, int colorito) {

    //positions[arregloX] = xO;
    //positions[arregloY] = yO;
    xO = lerp(positions[arregloX], 0+sumax, lerping);
    yO = lerp(positions[arregloY], 0+sumay, lerping);
    positions[arregloX] = xO; //+sumax;
    positions[arregloY] = yO; //+sumay;
    //tint( colores[colorito] );
    tint(#fae950);
    image(imagenP[cual], positions[arregloX], positions[arregloY], tam, tam);
  }

  void figuras() {
    //pushMatrix();
    _otro(40, 70, 0.03, 0, 1, 1);
    _otro(-40, 70, 0.03, 2, 3, 2);
    _otro(0, 150, 0.03, 4, 5, 3);
    _otro(100, 150, 0.03, 6, 7, 4);
    _otro(-100, 150, 0.03, 8, 9, 5);
    //popMatrix();
  }

  void seleccion() {
    genDista = dist(mouseX, mouseY, x, y);
    if (lider.liderSeleccionado && genDista < 100) {
      lider.liderSeleccionado = false;
      cursor();
      for (int i=0; i < 10; i++) {
        lider.xdirection[i]= int(random(-2, 2));
        while (lider.xdirection[i]==0) {
          lider.xdirection[i]= int(random(-2, 2));
        }
      }
      for (int i=0; i < 10; i++) {
        lider.ydirection[i]= int(random(-2, 2));
        while (lider.ydirection[i]==0) {
          lider.ydirection[i]= int(random(-2, 2));
        }
      }
      for (int j=0; j < 10; j=j+2) {

        positions[j] = positions[j] + ( mouseX );
        positions[j+1] = positions[j+1] +( mouseY );
      }
    } else if (genDista < 100) {
      lider.liderSeleccionado = true;

      for (int j=0; j < 10; j=j+2) {

        positions[j] = positions[j]- ( mouseX );
        positions[j+1] = positions[j+1] - (mouseY);
      }
    }
  }
}
