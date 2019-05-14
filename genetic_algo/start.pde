
class Start {
  
  // CONSTRUCTOR
  Start(int genome_length, int population_size) {
    population_size = population_size;
    genome_length = genome_length;

  }
  //---------------------------------------------------------------------------------------
  
  // SEED
  ArrayList<ArrayList> seed(ArrayList<PVector> knots) {
    
    ArrayList<ArrayList> gen0 = new ArrayList<ArrayList>();
    for(int i=0; i<=population_size; i++) {
      Collections.shuffle(knots);
      gen0.add(new ArrayList(knots));
    }
    
    return gen0;
  }
  //---------------------------------------------------------------------------------------
  
  // CREATE KNOTS
  ArrayList<PVector> create_knots(){
    
    int total_knots = genome_length;
    
    ArrayList<PVector> knots = new ArrayList<PVector>();
    for(int i=1; i<=total_knots; i++){
      
      float x = random(100, 600);
      float y = random(100, 600);
      PVector knot = new PVector(x, y);
      
      knots.add(knot);
    }
    
    return knots;
  }
  //---------------------------------------------------------------------------------------
  
}