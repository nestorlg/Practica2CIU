PShape figura;
PShape solido;
int count;
int X;
int Y;
float lastX;
float lastY;
float firstX;
float firstY;
float[][] puntos;
float[][] puntosAux;
boolean terminado;
boolean comienzo;

void setup () {
  size(1300,650,P3D);
  count = 0;
  terminado = false;
  comienzo = true;
  puntos = new float[1][3];
  puntosAux = new float[1][3];
  background(0);
  stroke(255);
  figura = createShape();
  figura.beginShape();
  figura.fill(random(255),random(255),random(255));
  figura.stroke(255);
  figura.strokeWeight(2);
}

void draw () {
  if (terminado) {
    background(0);
    translate(X,Y);
    shape(solido);
    if (keyPressed == true) {
      if (keyCode == UP) {
        Y -= 5;
      }
      if (keyCode == DOWN) {
        Y += 5;
      }
      if (keyCode == LEFT) {
        X -= 5;
      }
      if (keyCode == RIGHT) {
        X += 5;
      }
    }
  }
}

void mousePressed() {
  if (!terminado) {
    if (mouseButton == LEFT) {
      figura.vertex(mouseX,mouseY);
      if (count > 0) {
        puntosAux = puntos;
        puntos = new float[count+1][3];
        java.lang.System.arraycopy(puntosAux,0,puntos,0,count);
      }
      puntos[count][0] = mouseX - width/2;
      puntos[count][1] = height - mouseY;
      if (!comienzo) {
        line(lastX,lastY,mouseX,mouseY);
      } else {
        firstX = mouseX;
        firstY = mouseY;
        comienzo = false;
      }
      lastX = mouseX;
      lastY = mouseY;
      count++;
    } else {
      if (mouseButton == RIGHT) {
        line(lastX,lastY,firstX,firstY);
        figura.endShape();
        solido = createShape();
        solido.beginShape();
        solido.fill(255);
        solido.stroke(255,0,0);
        solido.strokeWeight(2);
        puntosAux = new float[count][3];
        for (int i = 0;i < 72;i++) {
          for (int j = 0;j < count;j++) {
            puntosAux[j][0] = puntos[j][0]*cos(5) - puntos[j][2]*sin(5);
            puntosAux[j][1] = puntos[j][1];
            puntosAux[j][2] = puntos[j][0]*sin(5) + puntos[j][2]*cos(5);
            puntos[j][0] = puntosAux[j][0];
            puntos[j][1] = puntosAux[j][1];
            puntos[j][2] = puntosAux[j][2];
            solido.vertex(puntosAux[j][0] + width/2,height - puntosAux[j][1],puntosAux[j][2]);
          }
        }
        solido.endShape();
      }
      terminado = true;
    }
  } else {
    if (mouseButton == RIGHT) {
      terminado = false;
      comienzo = true;
    }
  }
}
