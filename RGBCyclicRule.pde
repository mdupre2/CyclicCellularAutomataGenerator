class RGBCyclicRule extends CyclicRule{
  RGBCyclicRule(){
    super();
  }
  RGBCyclicRule(int t, int r,  int s, Neighborhood n){
    super(t, r, s, n);
  }
  
  float[] apply(RGBCell[] nbrs){
    //print("hello world");
    int totr = 0;
    int totg = 0;
    int totb = 0;
    float r,g,b;
    RGBCell c = nbrs[0];
    for(int i = 1; i < nbrs.length; i++){
      RGBCell cell = nbrs[i];
      if (cell != null && int(cell.rval()) == (int(c.rval()) + 1) % st.nStates){
        totr++;
      }
    }
    if (int(c.gval()) == (int(c.rval()) + 1) % st.nStates){
        totr++;
    }
    if (int(c.bval()) == (int(c.rval()) + 1) % st.nStates){
        totr++;
    }
    if (totr >= threshold){
      r =  float((int(c.rval()) + 1) % st.nStates);
    }else{
      r = c.rval();
    }
 
    for(int i = 1; i < nbrs.length; i++){
        RGBCell cell = nbrs[i];
        if (cell != null && int(cell.gval()) == (int(c.gval()) + 1) % st.nStates){
          totg++;
        }
      }
    if (int(c.rval()) == (int(c.gval()) + 1) % st.nStates){
        totg++;
    }
    if (int(c.bval()) == (int(c.gval()) + 1) % st.nStates){
        totg++;
    }
    if (totg >= threshold){
      g =  float((int(c.gval()) + 1) % st.nStates);
    }else{
      g = c.gval();
    }
    
    for(int i = 1; i < nbrs.length; i++){
      RGBCell cell = nbrs[i];
      if (cell != null && int(cell.bval()) == (int(c.bval()) + 1) % st.nStates){
        totb++;
      }
    }
    if (int(c.gval()) == (int(c.bval()) + 1) % st.nStates){
        totb++;
    }
    if (int(c.rval()) == (int(c.bval()) + 1) % st.nStates){
        totb++;
    }
    if (totb >= threshold){
      b =  float((int(c.bval()) + 1) % st.nStates);
    }else{
      b = c.bval();
    }
    
    float[] ret = {r,g,b};
    return ret;
  }

  
}