class CyclicRule extends Rule{
  int threshold = 2;
  CyclicRule(){
    super();
  }
  CyclicRule(int t, int r,  int s, Neighborhood n){
    super(n,s);
    threshold = t;
    radius = r;
  }
  float[] apply(Cell[] nbrs){
    int tot = 0;
    Cell c = nbrs[0];
    for(int i = 1; i < nbrs.length; i++){
      Cell cell = nbrs[i];
      if (cell != null && int(cell.val()) == (int(c.val()) + 1) % st.nStates){
        tot++;
      }
    }
    if (tot >= threshold){
      float[] ret = {float((int(c.val()) + 1) % st.nStates)};
      return ret;
    }else{
      float[] ret = {c.val()};
      return ret;
    }
  }
}