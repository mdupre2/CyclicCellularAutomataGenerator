class CyclicCellularAutomata extends Grid{
  CyclicCellularAutomata(){
    super();
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
    setAllNeighbors();
    /*
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
    }*/
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
}