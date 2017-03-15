class Cell{
  int x;
  int y;
  int size;
  protected float val;
  protected float newVal;
  protected Rule rule;
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
    colorMode(HSB, 255);
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
    val(rule.apply(neighbors)[0]);
  }
  
}