
// DRAW
class Draw {
  
  // DRAW KNOTS
  void draw_knots(ArrayList<PVector> knots) {
    
    // draw the static knots
    for(int i=0; i<=knots.size() - 1; i++){
      ellipse(knots.get(i).x, knots.get(i).y, 25, 25);
    }
  }
  //---------------------------------------------------------------------------------------
  
  // DRAW PATHS
  void draw_paths(ArrayList<PVector> parent1) {
    
    // draw current fittest
    parent1.add(parent1.get(0));
    for(int i=0; i<=parent1.size() - 2; i++) {
      
      PVector knot1 = parent1.get(i);
      PVector knot2 = parent1.get(i+1);
      
      pushStyle();
      stroke(255);
      line(knot1.x, knot1.y, knot2.x, knot2.y);
      popStyle();
    }
    parent1.remove(parent1.size() - 1);
  }

}