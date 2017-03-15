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
  
  color getColor(float r, float g, float b){
      return color(r*(255/nStates),g*(255/nStates),b*(255/nStates));
     //return color((r-min/max-min)*255,(g-min/max-min)*255,(b-min/max-min)*255);
  }
}