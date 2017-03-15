class RGBCyclicCellularAutomata extends CyclicCellularAutomata{
  RGBCell grid[][];
   RGBCyclicCellularAutomata(int cs, int w, int h,  int threshold, int radius, int nStates, Neighborhood n){
    super();
    this.w = w;
    this.h = h;
    this.cs = cs;
    RGBCyclicRule rgb = new RGBCyclicRule(threshold, radius, nStates, n);
    this.rule =  rgb;
    this.grid = new RGBCell[this.w][this.h];
    for (int y = 0; y < h; y++){
      for (int x = 0; x < w; x++){
         grid[x][y] = new RGBCell(x*cs,y*cs,cs, rgb);
      }
    }
    setAllNeighbors();
    super.grid = this.grid;
  }
  RGBCyclicCellularAutomata(int cs, int w, int h,  int threshold, int radius, int nStates, Neighborhood n, boolean torodial){
    super();
    this.w = w;
    this.h = h;
    this.cs = cs;
    this.torodial = torodial;
    RGBCyclicRule rgb = new RGBCyclicRule(threshold, radius, nStates, n);
    this.rule =  rgb;
    this.grid = new RGBCell[this.w][this.h];
    for (int y = 0; y < h; y++){
      for (int x = 0; x < w; x++){
         grid[x][y] = new RGBCell(x*cs,y*cs,cs, rgb);
      }
    }
    setAllNeighbors();
    super.grid = this.grid;
  }
  void setAllNeighbors(){
    for (int y = 0; y < h; y++){
      for (int x = 0; x < w; x++){
        switch(this.rule.neighborhood){
          case Moore:
            grid[x][y].neighbors = mooreNeighbors(x,y,this.rule.radius);
            break;
          case VanNeumann:
            grid[x][y].neighbors = vanneumannNeighbors(x,y,this.rule.radius);
            break;
          default:
            grid[x][y].neighbors = vanneumannNeighbors(x,y,this.rule.radius);
            break;
        }
      }
    }
  }
  
  RGBCell grid(int x, int y){
    if (torodial){
      return this.grid[((x%w)+w)%w][((y%h)+h)%h];
    }else{
      if (x >= 0 && x < w && y >= 0 && y < h){
        return this.grid[x][y];
      }else{
        return null;
      }
    }  
  }
  
  
  RGBCell[] vanneumannNeighbors(int x, int y, int r){
    RGBCell[] nbrs = new RGBCell[1+2*r*(r+1)];
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
  
  RGBCell[] mooreNeighbors(int x, int y, int r){
     RGBCell[] nbrs = new RGBCell[(1+(2*r))*(1+(2*r))];
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
   
  void setTorodial(boolean t){
    torodial = t;
    this.setAllNeighbors();
  }
  
}