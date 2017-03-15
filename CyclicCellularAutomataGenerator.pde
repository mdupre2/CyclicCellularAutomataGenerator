import controlP5.*;

ControlP5 cp5;
DropdownList dl;
Grid g;

boolean mp = false; //mouse press
int canvasSize = 600;
int n = 300;
int cs = canvasSize/n;

enum Neighborhood{
  Moore,
  VanNeumann
}

void mouseReleased() {
  mp = false;
}
 //<>//
void setup_dropdown(){
  dl = cp5.addDropdownList("ca-dl").setPosition(0, 0).setSize(100,300);
  dl.setBackgroundColor(color(190));
  dl.setItemHeight(20);
  dl.setBarHeight(20);
  dl.getCaptionLabel().set("Cellular Automata");
  dl.setColorBackground(color(60));
  dl.setColorActive(color(100, 128));
  dl.addItem("Perfect", 0);
  dl.addItem("Lava Lamp", 1);
  dl.addItem("Maps", 2);
  dl.addItem("Turbulent Phase", 3);
  dl.addItem("Amoeba", 4);
  dl.addItem("Cubism", 5);
  dl.addItem("Squarish Spirals", 6);
  dl.addItem("Stripes", 7);
  dl.addItem("Imperfect", 8);
  dl.addItem("Cyclic Spirals", 9);
  dl.addItem("CCA", 10);
  dl.addItem("313", 11);
  dl.addItem("Black vs White", 12);
  dl.addItem("3-Color Bootstrap", 13);
  dl.addItem("Fossil Debris", 14);
  dl.addItem("RGB1", 15);
  dl.addItem("RGB2", 16);
  dl.addItem("RGB3", 17);
  dl.addItem("RGB4", 18);
  dl.addItem("RGB5", 19);
  dl.addItem("RGB6", 20);
  dl.addItem("RGB7-torodial", 21);
  dl.addItem("RGB7-nontorodial", 22);
  dl.addItem("RGB8", 23);
  dl.addItem("RGB9", 24);
}

void controlEvent(ControlEvent theEvent) { //<>//
  int threshold = 3;
  int radius = 2;
  int nStates = 1;
  Neighborhood nbhd = Neighborhood.Moore;
  if (theEvent.isController()) {
    switch(int(theEvent.getController().getValue())){
      case 0://Perfect
        threshold = 3;
        radius = 1;
        nStates = 4;
        nbhd = Neighborhood.Moore;
        g = new CyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd);
        break;
      case 1://lavalamp
        threshold = 10;
        radius = 2;
        nStates = 4;
        nbhd = Neighborhood.Moore;
        g = new CyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd);
        break;
      case 2://maps
        threshold = 3;
        radius = 2;
        nStates = 5;
        nbhd = Neighborhood.VanNeumann;
        g = new CyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd);
        break;
      case 3://turbulent phase
        threshold = 5;
        radius = 2;
        nStates = 8;
        nbhd = Neighborhood.Moore;
        g = new CyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd);
        break;
      case 4://Amoeba
        threshold = 10;
        radius = 3;
        nStates = 2;
        nbhd = Neighborhood.VanNeumann;
        g = new CyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd);  
        break;
      case 5://Cubism
        threshold = 5;
        radius = 2;
        nStates = 3;
        nbhd = Neighborhood.VanNeumann;
        g = new CyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd);
        break;
      case 6://Squarish Spirals
        threshold = 2;
        radius = 2;
        nStates = 6;
        nbhd = Neighborhood.VanNeumann;
        g = new CyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd);
        break;
      case 7://Stripes
        threshold = 4;
        radius = 3;
        nStates = 5;
        nbhd = Neighborhood.VanNeumann;
        g = new CyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd);  
        break;
      case 8://Imperfect
        threshold = 2;
        radius = 1;
        nStates = 4;
        nbhd = Neighborhood.Moore;
        g = new CyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd);
        break;
        case 9://Cyclic Spirals
        threshold = 5;
        radius = 3;
        nStates = 8;
        nbhd = Neighborhood.Moore;
        g = new CyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd);
        break;
      case 10://CCA
        threshold = 1;
        radius = 1;
        nStates = 14;
        nbhd = Neighborhood.VanNeumann;
        g = new CyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd);  
        break;
      case 11://313
        threshold = 3;
        radius = 1;
        nStates = 3;
        nbhd = Neighborhood.Moore;
        g = new CyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd);
        break;
      case 12://Black vs White
        threshold = 23;
        radius = 5;
        nStates = 2;
        nbhd = Neighborhood.VanNeumann;
        g = new CyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd);
        break;
      case 13://3-color bootstrap
        threshold = 11;
        radius = 2;
        nStates = 3;
        nbhd = Neighborhood.Moore;
        g = new CyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd);
        break;
      case 14://Fossil Debris
        threshold = 9;
        radius = 2;
        nStates = 4;
        nbhd = Neighborhood.Moore;
        g = new CyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd);
        break;
      case 15://RGB //<>//
        threshold = 9;
        radius = 2;
        nStates = 4;
        nbhd = Neighborhood.Moore;
        g = new RGBCyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd);
        break;
      case 16://RGB2
        threshold = 3;
        radius = 2;
        nStates = 4;
        nbhd = Neighborhood.VanNeumann;
        g = new RGBCyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd);
        break;
      case 17://RGB3
        threshold = 5;
        radius = 3;
        nStates = 4;
        nbhd = Neighborhood.VanNeumann;
        g = new RGBCyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd);
        break;
      case 18://RGB4
        threshold = 5;
        radius = 3;
        nStates = 4;
        nbhd = Neighborhood.VanNeumann;
        g = new RGBCyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd, false);
        break;
      case 19://RGB5
        threshold = 29;
        radius = 4;
        nStates = 3;
        nbhd = Neighborhood.Moore;
        g = new RGBCyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd);
        break;
      case 20://RGB6
        threshold = 4;
        radius = 3;
        nStates = 6;
        nbhd = Neighborhood.VanNeumann;
        g = new RGBCyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd);
        break;
      case 21://RGB7-torodial
        threshold = 5;
        radius = 3;
        nStates = 6;
        nbhd = Neighborhood.VanNeumann;
        g = new RGBCyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd, true);
        break;
     case 22://RGB7-nontorodial
        threshold = 5;
        radius = 3;
        nStates = 6;
        nbhd = Neighborhood.VanNeumann;
        g = new RGBCyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd, false);
        break;
      case 23://RGB8
        threshold = 8;
        radius = 3;
        nStates = 6;
        nbhd = Neighborhood.Moore;
        g = new RGBCyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd);
        break;
      case 24://RGB9
        threshold = 7;
        radius = 2;
        nStates = 3;
        nbhd = Neighborhood.Moore;
        g = new RGBCyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd);
        break;
      default:
        break;
    }
  } 
}

void setup(){
  size(600,600);
  cp5 = new ControlP5(this);
  setup_dropdown();
  int threshold = 7;
  int radius = 2;
  int nStates  = 3;
  Neighborhood nbhd =  Neighborhood.Moore;
  g = new RGBCyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd); 
}

void draw() {
  g.draw();
  if (mousePressed == true) {
    if (mp){
      g.touch(mouseX, mouseY, pmouseX, pmouseY);
      mp = true;
    }else{
      g.touch(mouseX, mouseY);
      mp = true;
    } 
  }  
  g.applyRule();
}