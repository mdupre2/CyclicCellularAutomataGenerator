class RGBCell extends Cell{
  protected float gval;
  protected float bval;
  protected float gnewVal;
  protected float bnewVal;
  RGBCell[] neighbors;
  RGBCyclicRule rule;
  
  RGBCell (int x, int y, int size, RGBCyclicRule r){
    super(x,y,size,r);
    rule = r;
    this.val =  r.randomState();
    this.bval = r.randomState();
    this.gval = r.randomState();
  }
  
  float rval(float v){
    newVal = v;
    return v;
  }
  
  float rval(){
    return val;
  }
  
  float gval(float v){
    gnewVal = v;
    return v;
  }
  
  float gval(){
    return gval;
  }
  
  float bval(float v){
    bnewVal = v;
    return v;
  }
  
  float bval(){
    return bval;
  }
  
  void update(){
    val = newVal;
    bval = bnewVal;
    gval = gnewVal;
  }
  
  void clear(){
    newVal = rule.dft();
    gnewVal = rule.dft();
    bnewVal = rule.dft();
  }
  
  color getColor(){
    return rule.getColor(rval(), gval(), bval());
  }
  
  void draw(){
    noStroke();
    colorMode(RGB, 255);
    fill(getColor());
    rect(x, y, size ,size);
  }
  
  void applyRule(){
    float[] v = this.rule.apply(this.neighbors);
    rval(v[0]);
    gval(v[1]);
    bval(v[2]);
  }
}