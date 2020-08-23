class Acoso {
  // imagen
  PImage imagenP[];
  PImage imagenA[];
  PImage splash[];
  color paletaA[];
  int cant = 4;
  //timer
  int time;
  int espera = 500;
  //USUARIO
  float x1 = 0; //posición en X
  float y1 = 0; //posición en Y
  float dir = 1; // direccion
  float vel1 = 0.2; // velocidad
  int tam = 60;
  boolean cerca = false;
  float angle = 0; // angulo
  float targetAngle = 0; //angulo target
  boolean elegido = false;
  float genX = 100;
  float genY = 100;
  float genDista;
  int cual = 0;
  //OTRO
  float x = height/2; //pos en x
  float y = width/2; //pos en Y
  float dirX = 1; // direccion X
  float dirY = 1; // direccion Y
  float vel = 1; //velocidad
  float dista = 100; //distancia entre usuario y npc

  Acoso(PImage[] p, PImage[] a, PImage[] s) {
    imagenP = p;
    imagenA = a;
    splash = s;

    // PALETA AGRESIVA
    paletaA = new color[4];
    paletaA[0] = #FF001B;
    paletaA[1] = #FF001B;
    paletaA[2] = #D80000;
    paletaA[3] = #BA0000;

    // timer
    time = millis();
  }

  //TIMER
  void tiempo() {
    if (millis() - time >= espera) {
      cual = int(random(cant));
      time = millis();//also update the stored time
    }
  }

  //DIBUJAR UN USUARIO
  void _un_u(float x_, float y_) {
    pushStyle();
    pushMatrix();
    translate(x_, y_);
    if (y1 >10 || y1 < -10 || x1 >10 || x1 < -10 ) {
      dir = dir * -1;
    }  
    tint(paletaA[0]);
    if (cerca) {
      image(imagenA[cual], x1, y1);
    } else {
      image(imagenP[cual], x1, y1);
    }
    if (!elegido) {
      image(splash[cual], x1, y1);
    }
    popMatrix();
    popStyle();
  }

  //FORMACIÓN DE USUARIOS
  void _usuario() {
    pushMatrix();
    imageMode(CENTER);
    _un_u(0, 0);
    _un_u( 30, -70);
    _un_u(30, 70);
    _un_u(100, 75);
    _un_u(100, -75);
    popMatrix();
  }

  //ROTACIÓN DE USUARIO AL REDEDOR DE NPC
  void rotacion(float x_, float y_) {
    pushMatrix();
    translate(x_, y_);
    angle = atan2( y - height/2, x - width/2 );
    float dir = (angle - targetAngle) / TWO_PI;
    dir -= round( dir );
    dir *= TWO_PI;
    targetAngle += dir;
    rotate(targetAngle);
    _usuario();
    popMatrix();
  }

  //DIBUJO Y MOVIMIENTO DEL NPC
  void _otro() {
    pushStyle();
    x = x + (vel*dirX);
    y = y + (vel*dirY);
    if ( x <= tam/2 || x >= width-tam/2) {
      dirX = dirX * -1;
    }
    if ( y <= tam/2 || y >= height-tam/2) {
      dirY *= -1;
    }
    tint(#00D4E9);
    image(imagenP[2], x, y);
    popStyle();
  }

  //ESCAPE DEL NPC 
  void _miedo() {
    dista = dist(genX, genY, x, y);
    if (dista < 200 && (vel < 5)) {
      vel++;
      //vel1++;
      cerca = true;
    } else if ( dista > 300 && vel > 1) {
      //println("vel: ",vel);
      vel--;
      //vel1--;
      cerca = false;
    }
  }

  //INTERACCION
  void interaccion() {
    genDista = dist(mouseX, mouseY, genX, genY);
    if (elegido) {
      genX = mouseX;
      genY = mouseY;
    } else {
      cursor();
    }
    tiempo();
    rotacion(genX, genY);
    _miedo();
    _otro();
  }










  //FIN DE CLASE
}
