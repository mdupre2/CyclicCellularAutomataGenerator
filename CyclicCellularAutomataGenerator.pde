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

// Note that the style array and getColor functions are not used right now.
// instead the color is calculated in the draw function of Cell using HSB color mode 

class StateType{
  int nStates = 4;
  color[] style;
  float max  =  4;
  float min = 0;
  float dft = 0;
  
  StateType(){
    style = new color[nStates];
    for(int i = 0; i < nStates; i++){
      style[i] = color(i*(255/nStates));
    }
  } 
  
  StateType(int nStates, color[] style, float min, float max){
    this.nStates = nStates;
    this.style = style;
    this.min = min;
    this.max = max;
  }
  
  StateType(int nStates){
    this.nStates = nStates;
    this.min = 0;
    this.max = float(nStates);
    this.style = new color[nStates];
    for(int i = 0; i < nStates; i++){
      style[i] = color(i*(255/nStates));
    } 
  }
  
  float inc(float val){
    return float((int(val) + 1)%nStates);
  }
  
  color getColor(float v){
     if (v >= max){
       return style[nStates-1];
     }
     float size =  (max - min)/nStates;
     int i = int((v-min)/size);
     return style[i];
  }
}


class Rule{
  Neighborhood neighborhood = Neighborhood.VanNeumann;//Neighborhood.Moore;
  StateType st;
  int radius = 1;
  
  Rule(){
    st = new StateType();
  }
  
  Rule(Neighborhood nh){
    neighborhood = nh;
    st = new StateType();
  }
  
  Rule(Neighborhood nh, StateType st){
    neighborhood = nh;
    this.st = st;
  }
  Rule(Neighborhood nh, int nStates){
    neighborhood = nh;
    this.st = new StateType(nStates);
  }
  

  float inc(float x){
    return st.inc(x);
  }
  
  float apply(Cell[] nbrs){
    int tot = 0;
    int threshold = 2;
    int nStates = 4;
    Cell c = nbrs[0];
    for(int i = 1; i < nbrs.length; i++){
      Cell cell = nbrs[i];
      if (cell != null && int(cell.val()) == (int(c.val()) + 1) % nStates){
        tot++;
      }
    }
    if (tot >= threshold){
      return float((int(c.val()) + 1) % nStates);
    }else{
      return c.val();
    }
  }
  
  color getColor(float v){
    return st.getColor(v);
  }
  float randomState(){
    return float(int(random(st.nStates)) % st.nStates);
  }
  float dft(){
    return st.dft;
  }
}

class Cell{
  int x;
  int y;
  int size;
  private float val;
  private float newVal;
  private Rule rule;
  Cell[] neighbors = {};
  
  Cell (int x, int y, int size, Rule r){
    this.x = x;
    this.y = y;
    this.size = size;
    this.rule = r;
    this.val = rule.randomState();
    color[] style = { color(255, 0, 255),  color(255, 0, 0), color(255, 255, 0), color(255, 150, 0)};
  }
  
  float val(float v){
    newVal = v;
    return v;
  }
  
  void inc(){
    val(rule.inc(val()));
  }
  
  float val(){
    return val;
  }
  
  color getColor(){
    return rule.getColor(val);
  }
  
  void clear(){
    newVal = rule.dft();
  }
  
  
  void draw(){
    noStroke();
    //fill(getColor());  //alternative to the line below if you want to use custome colo
    fill(val*(255/rule.st.nStates),200,255);
    rect(x, y, size ,size);
  }
  
  void update(){
    val = newVal;
  }
  void setStateType(StateType st){
    rule.st = st;
  }
  
  void setRule(Rule r){
    this.rule = r;
  }
  
  void applyRule(){
    val(rule.apply(neighbors));
  }
  
}

class Grid{
  
  Cell[][] grid;
  int w = 40;
  int h = 40;
  int cs = 4;
  Rule rule;
  boolean torodial = true;
  
  Grid(){
    rule = new Rule();
  }
  
  Grid(int cellSize, int width, int height, Rule rule){
    this.w = width;
    this.h = height;
    this.cs = cellSize;
    this.rule = rule;
    grid = new Cell[this.w][this.h];
    for (int y = 0; y < h; y++){
      for (int x = 0; x < w; x++){
         grid[x][y] = new Cell(x*cs,y*cs,cs, this.rule);
      }
    }
    for (int y = 0; y < h; y++){
      for (int x = 0; x < w; x++){
         grid[x][y].neighbors = findNeighbors(x,y);
      }
    }
  }


  Cell[] findNeighbors(int x, int y){
    
    if(rule.neighborhood == Neighborhood.VanNeumann){
      Cell c = center(x,y);
      Cell n = north(x,y);
      Cell s = south(x,y);
      Cell e = east(x,y);
      Cell w = west(x,y);
      Cell[] nbrs = {c,n,s,e,w};
      return nbrs;
    }else{
      Cell c = center(x,y);
      Cell n = north(x,y);
      Cell ne = northeast(x,y);
      Cell nw = northwest(x,y);
      Cell s = south(x,y);
      Cell se = southeast(x,y);
      Cell sw = southwest(x,y);
      Cell e = east(x,y);
      Cell w = west(x,y);
      Cell[] nbrs = {c,n,ne,nw,s,se,sw,e,w};
      return nbrs;
    }
  }
  
  Cell grid(int x, int y){
    if (torodial){
      return grid[((x%w)+w)%w][((y%h)+h)%h];
    }else{
      if (x >= 0 && x < w && y >= 0 && y < h){
        return grid[x][y];
      }else{
        return null;
      }
    }
    
  }
  
  Cell west(int x, int y){
    return grid(x-1,y);
  }
  
  Cell east(int x, int y){
    return grid(x+1,y);
  }
  
  Cell north(int x, int y){
    return grid(x,y-1);
  }
  
  Cell south(int x, int y){
    return grid(x,y+1);
  }
  
  Cell northeast(int x, int y){
    return grid(x+1,y-1);
  }
  
  Cell southeast(int x, int y){
    return grid(x+1,y+1);
  }
  
  Cell northwest(int x, int y){
    return grid(x-1,y-1);
  }
  
  Cell southwest(int x, int y){
    return grid(x-1,y+1);
  }
  
  Cell center(int x, int y){
    return grid(x,y);
  }
  
  Cell[] vanneumannNeighbors(int x, int y, int r){
    Cell[] nbrs = new Cell[1+2*r*(r+1)];
    int pos = 0;
    for (int radius = 0; radius <= r; radius++){
      for (int dx = -radius; dx <= radius; dx++){
        nbrs[pos] = grid(x+dx, y+(radius-abs(dx)));
        pos++;
        if (abs(dx) != radius){
          nbrs[pos] = grid(x+dx, y-(radius-abs(dx)));
          pos++;
        }
      }
    }
    return nbrs;
  }
  
  Cell[] mooreNeighbors(int x, int y, int r){
     Cell[] nbrs = new Cell[(1+(2*r))*(1+(2*r))];
     int pos = 1;
     nbrs[0] = grid(x,y);
     for (int radius = 1; radius <= r; radius++){
       for (int dx = -radius; dx <= radius; dx++){
         nbrs[pos] = grid(x+dx,y-radius);
         pos++;
         nbrs[pos] = grid(x+dx,y+radius);
         pos++;
       }
       for (int dy = -radius + 1; dy < radius; dy++){
         nbrs[pos] = grid(x-radius,y+dy);
         pos++;
         nbrs[pos] = grid(x+radius,y+dy);
         pos++;
       }
     }
     return nbrs;
  }
  
  void update(){
    for (int y = 0; y < h; y++){
      for (int x = 0; x < w; x++){
        grid[x][y].update(); 
      }
    }
  }
  
  void applyRule(){
    for (int y = 0; y < h; y++){
      for (int x = 0; x < w; x++){
        grid[x][y].applyRule();
      }
    }
    update();
  }
  
  void changeRule(Rule rule){
    this.rule = rule;
    for (int y = 0; y < h; y++){
      for (int x = 0; x < w; x++){
        grid[x][y].rule = this.rule; 
      }
    }
  }
  
  void draw(){
    for (int y = 0; y < h; y++){
      for (int x = 0; x < w; x++){
        (grid[x][y]).draw(); 
      }
    }
  }
  
  void clear(){
    for (int y = 0; y < h; y++){
      for (int x = 0; x < w; x++){
        grid[x][y].clear(); 
        grid[x][y].update();
      }
    }
  }
  void touch(int x, int y, int px, int py){
    int i = x / cs;
    int j = y / cs;
    int pi = px / cs;
    int pj = py / cs;
    if (i != pi || j != pj){
      if ( i < w && j < h  && i >= 0 && j >= 0){
        grid[i][j].inc();
        grid[i][j].update();
      }
    }
  }
  void touch(int x, int y){
    int i = x / cs;
    int j = y / cs;
    if ( i < w && j < h && i >= 0 && j >= 0){
      grid[i][j].inc();
      grid[i][j].update();
    }
  } 
}
class CyclicRule extends Rule{
  int threshold = 2;
  int radius = 1;
  CyclicRule(){
    super();
  }
  CyclicRule(int t, int r,  int s, Neighborhood n){
    super(n,s);
    threshold = t;
    radius = r;
  }
  float apply(Cell[] nbrs){
    int tot = 0;
    Cell c = nbrs[0];
    for(int i = 1; i < nbrs.length; i++){
      Cell cell = nbrs[i];
      if (cell != null && int(cell.val()) == (int(c.val()) + 1) % st.nStates){
        tot++;
      }
    }
    if (tot >= threshold){
      return float((int(c.val()) + 1) % st.nStates);
    }else{
      return c.val();
    }
  }
}
class CyclicCellularAutomata extends Grid{
  CyclicCellularAutomata(){
    super();
    changeRule(new CyclicRule());
  }
  CyclicCellularAutomata(int cs, int w, int h,  int threshold, int radius, int nStates, Neighborhood n){
    this.w = w;
    this.h = h;
    this.cs = cs;
    this.rule = new CyclicRule(threshold, radius, nStates, n);
    this.grid = new Cell[this.w][this.h];
    for (int y = 0; y < h; y++){
      for (int x = 0; x < w; x++){
         grid[x][y] = new Cell(x*cs,y*cs,cs, this.rule);
      }
    }
    for (int y = 0; y < h; y++){
      for (int x = 0; x < w; x++){
        switch(n){
          case Moore:
            grid[x][y].neighbors = mooreNeighbors(x,y,radius);
            break;
          case VanNeumann:
            grid[x][y].neighbors = vanneumannNeighbors(x,y,radius);
            break;
          default:
            grid[x][y].neighbors = vanneumannNeighbors(x,y,radius);
            break;
        }
         
      }
    }
  }
}


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
}

void controlEvent(ControlEvent theEvent) {
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
      default:
        break;
    }
  } 
}


void setup(){
  colorMode(HSB, 255);
  size(600,600);
  cp5 = new ControlP5(this);
  setup_dropdown();
  int n = 300;
  int cs = canvasSize/n;
  Rule r = new Rule();
  int threshold = 3;
  int nStates  = 4;
  int radius = 1;
  Neighborhood nbhd =  Neighborhood.Moore;
  g = new Grid(cs, n, n, r);
  g = new CyclicCellularAutomata(cs, n, n, threshold, radius, nStates, nbhd); 
  g.draw();
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

void mouseReleased() {
  mp = false;
}