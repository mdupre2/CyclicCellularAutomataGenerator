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
  
  float[] apply(Cell[] nbrs){
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
      float[] ret = {float((int(c.val()) + 1) % nStates)};
      return ret;
    }else{
      float[] ret = {c.val()};
      return ret;
    }
  }
  
  color getColor(float v){
    return st.getColor(v);
  }
  
  color getColor(float r, float g, float b){
    return st.getColor(r,g,b);
  }
  
  float randomState(){
    return float(int(random(st.nStates)) % st.nStates);
  }
  float dft(){
    return st.dft;
  }
  
  
}