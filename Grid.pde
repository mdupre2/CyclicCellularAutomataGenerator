class Grid{
  
  Cell[][] grid;
  int w = 40;
  int h = 40;
  int cs = 4;
  Rule rule;
  boolean torodial = true;//true;
  Grid(){
    
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
    setAllNeighbors();
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
  void setAllNeighbors(){
    for (int y = 0; y < h; y++){
      for (int x = 0; x < w; x++){
        switch(rule.neighborhood){
          case Moore:
            grid[x][y].neighbors = mooreNeighbors(x,y,1);
            break;
          case VanNeumann:
            grid[x][y].neighbors = vanneumannNeighbors(x,y,1);
            break;
          default:
            grid[x][y].neighbors = vanneumannNeighbors(x,y,1);
            break;
        }
         
      }
    }
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
  void setTorodial(boolean t){
    torodial = t;
    setAllNeighbors();
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