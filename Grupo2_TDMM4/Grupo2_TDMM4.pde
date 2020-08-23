//IMAGENES y PALETA(código)
PImage fondo = new PImage();
PImage menu = new PImage();
PImage titulo = new PImage();
PImage atras = new PImage();
PImage atrasR = new PImage();
PImage[] imagenA, imagenP, splash;
PImage[] grillas;
//ESTADO
/*
  Guía de número --> palabra
 - -1: título
 - 0: menu
 - 1: Acoso
 - 2: Aliencación
 - 3: Desarraigo
 - 4: Desigualdad
 - 5: Desinteres
 - 6: Enfermedad
 - 7: Extrangerización
 - 8: Individualismo
 - 9: Liderazgo
 - 10: Mediación
 - 11: Vanidad
 - 12: Xenofobia
 */
int estado = -1;
//OBJETOS PALABRAS
Acoso acoso;
Mediacion mediacion;
Extrangerizacion extra;
Vanidad van;
Desarraigoo des;
Individualismo ind;
Liderazgoo lider;
Desinteress desinteres;
Desigualdad desigualdad;
Xenofobiaa xeno;
Alienacion alien;
Enfermedad enf;
void settings() {
  size(800, 600, P2D);
}

void setup() {
  inicializar_imgs();
  inicializar_pal();
  //fondo
  fondo = loadImage("fondo.png");
  fondo.resize(800, 600);
  //menu
  menu = loadImage("menu.png");
  //título
  titulo = loadImage("titulo.png");
  titulo.resize(800, 600);
  //atras
  atras = loadImage("atras.png");
  atras.resize(30, 30);
  atrasR = loadImage("atrasR.png");
  atrasR.resize(30, 30);
}

void draw() {
  //println("estado: ", estado);
  //fondo
  tint(255, 60);
  imageMode(CORNER);
  image(fondo, 0, 0);
  textSize(30);
  fill(0);

  // Diagrama de estados
  switch(estado) {
  case -1: 
    image(titulo, 0, 0);
    break;
  case 0:
    cursor();
    image(queImagen(), 0, 0);
    break;
  case 1:
    acoso.interaccion();
    break;
  case 2:
    alien.interaccion();
    break;
  case 3:
    des.interaccion();
    break;
  case 4:
    desigualdad.interaccion();
    break;
  case 5:
    desinteres.interaccion();
    break;
  case 6:
    enf.interaccion();
    break;
  case 7:
    extra.interaccion();
    break;
  case 8:
    ind.interaccion();
    break;
  case 9:
    lider.interaccion();
    break;
  case 10:
    mediacion.interaccion();
    break;
  case 11:
    van.interaccion();
    break;
  case 12:
    xeno.interaccion();
    break;
  } 

  // botón para volver atr
  pushStyle();
  if (estado != 0 && estado != -1) {
    imageMode(CENTER);
    if (mouseX >= 0 && mouseX <= 30 && mouseY >= 0 && mouseY <= 30) {
      image(atrasR, 20, 20);
    } else {
      image(atras, 20, 20);
    }
  }
  popStyle();
}

void keyPressed() {
  //PARA NOSOTROS --> VOLVER AL INICIO
  if (key == '1') {
    estado = 0;
  }
}
//////////////////////

void mouseClicked() {
  switch(estado) {
  case -1:
    estado = 0;
    break;
  case 0:
    control_menu();
    break;
  case 1:
    if (acoso.genDista <100) {
      acoso.elegido = !acoso.elegido;
    }
    break;
  case 10:
    if (mediacion.genDista <100) {
      mediacion.elegido = !mediacion.elegido;
    }
    break;
  case 7:
    if (extra.genDista <100) {
      extra.elegido = !extra.elegido;
    }
    break;
  case 11:
    if (van.genDista <100) {
      van.elegido = !van.elegido;
    }
    break;
  case 3:
    des.seleccion();
    break;
  case 4:
    desigualdad.seleccion();
    break;
  case 2: 
    if (alien.genDista <100) {
      alien.elegido = !alien.elegido;
    }
    break;
  case 6:
    enf.select();
    break;
  }

  // botón para volver atrás
  if (estado != -1 && estado != 0) {
    if (mouseX >= 0 && mouseX <= 30 && mouseY >= 0 && mouseY <= 30) {
      estado = 0;
      // reseteo de alienación
      alien.reseteo();
    }
  }
}

void mousePressed() {
  switch(estado) {
  case 8:
    ind.seleccion();
    break;
  case 9:
    lider.seleccion();
    break;
  case 5:
    desinteres.seleccion();
    break;
  case 12:
    xeno.seleccion();
    break;
  }
}
