//INICIALIZACIÓN DE LAS PALABRAS
void inicializar_pal() {
  acoso = new Acoso(imagenP, imagenA, splash);
  mediacion = new Mediacion(imagenP, imagenA, splash);
  extra = new Extrangerizacion (imagenP, splash);
  van = new Vanidad(imagenP, imagenA, splash);
  des = new Desarraigoo(imagenP, imagenA, splash);
  ind = new Individualismo(imagenP, imagenA, splash);
  lider = new Liderazgoo (imagenP, imagenA, splash);
  desinteres = new Desinteress (imagenP, imagenA, splash);
  desigualdad = new Desigualdad (imagenP, imagenA, splash);
  xeno = new Xenofobiaa (imagenP, imagenA, splash);
  alien = new Alienacion(imagenP, imagenA, splash);
  enf = new Enfermedad(imagenP, imagenA, splash);
}

//INICIALIZACIÓN DE LAS IMAGENES
void inicializar_imgs() {
  //GRILLA
  grillas = new PImage[12];
  for (int i= 0; i<12; i++) {
    grillas[i]= loadImage("Grilla/grilla"+str(i)+".png");
    grillas[i].resize(800,600);
  }

  // IMAGENES PASIVAS
  imagenP = new PImage [4];
  imagenP[0] = loadImage("mancha redonda.png");
  imagenP[1] = loadImage("mancha redonda2.png");
  imagenP[2] = loadImage("mancha redonda3.png");
  imagenP[3] = loadImage("mancha redonda4.png");

  // IMAGENES AGRESIVAS
  imagenA = new PImage [4];
  imagenA[0] = loadImage("mancha agresiva.png");
  imagenA[1] = loadImage("mancha agresiva2.png");
  imagenA[2] = loadImage("mancha agresiva3.png");
  imagenA[3] = loadImage("mancha agresiva4.png");

  // SPLASH
  splash = new PImage [4];
  splash[0] = loadImage("splash.png");
  splash[1] = loadImage("splash2.png");
  splash[2] = loadImage("splash3.png");
  splash[3] = loadImage("splash4.png");

  //FIltro a todas las imagens para poder darles tint
  for (int i = 0; i < 4; i++) {
    imagenP[i].filter( INVERT );
    imagenA[i].filter( INVERT );
    splash[i].filter( INVERT );
    splash[i].resize(95, 95);
  }
}

//CONTROL DEL MENU
void control_menu() {
  //pregunto en donde estan mouseX y mouseY
  switch(int(mouseY/100)) {
    //primera fila
  case 0:
  case 1:
    switch(int(mouseX/100)) {
    case 0:
    case 1:
      estado = 1;
      break;
    case 2:
    case 3:
      estado = 2;
      break;
    case 4:
    case 5:
      estado = 3;
      break;
    case 6:
    case 7:
      estado = 4;
      break;
    }
    break;
    //segunda fila
  case 2:
  case 3:
    switch(int(mouseX/100)) {
    case 0:
    case 1:
      estado = 5;
      break;
    case 2:
    case 3:
      estado = 6;
      break;
    case 4:
    case 5:
      estado = 7;
      break;
    case 6:
    case 7:
      estado = 8;
      break;
    }
    break;
    //tercera fila
  case 4:
  case 5:
    switch(int(mouseX/100)) {
    case 0:
    case 1:
      estado = 9;
      break;
    case 2:
    case 3:
      estado = 10;
      break;
    case 4:
    case 5:
      estado = 11;
      break;
    case 6:
    case 7:
      estado = 12;
      break;
    }
    break;
  }
}

//HOVER DEL MENU
//CONTROL DEL MENU
PImage queImagen() {
  //pregunto en donde estan mouseX y mouseY
  switch(int(mouseY/100)) {
    //primera fila
  case 0:
  case 1:
    switch(int(mouseX/100)) {
    case 0:
    case 1:
      //acoso
      return grillas[0];
    case 2:
    case 3:
      //alienación
      return grillas[1];
    case 4:
    case 5:
      //desarraigo
      return grillas[2];
    case 6:
    case 7:
      //desigualdad
      return grillas[3];
    }
    break;
    //segunda fila
  case 2:
  case 3:
    switch(int(mouseX/100)) {
    case 0:
    case 1:
      //desinteres
      return grillas[4];
    case 2:
    case 3:
      //enfermedad
      return grillas[5];
    case 4:
    case 5:
      //extrangerizacioj¿n
      return grillas[6];
    case 6:
    case 7:
     //individualismo
      return grillas[7];
    }
    break;
    //tercera fila
  case 4:
  case 5:
    switch(int(mouseX/100)) {
    case 0:
    case 1:
      //liderazgo
      return grillas[8];
    case 2:
    case 3:
      //mediacion
      return grillas[9];
    case 4:
    case 5:
      //vanidad
      return grillas[10];
    case 6:
    case 7:
      //xenofobia
      return grillas[11];
    }
    break;
  }
  return null;
}

//PALETA
class Paleta {

  PImage imagen;

  Paleta( String nombre ) {
    imagen = loadImage( nombre );
  }

  color darUnColor() {
    int posX = int( random( imagen.width ));
    int posY = int( random( imagen.height ));
    return imagen.get( posX, posY );
  }

  color darUnColor( float alfa ) {
    int posX = int( random( imagen.width ));
    int posY = int( random( imagen.height ));
    color pixelColorElegido = imagen.get( posX, posY ); 
    return color( red(pixelColorElegido), green(pixelColorElegido), blue(pixelColorElegido), alfa );
  }
}
