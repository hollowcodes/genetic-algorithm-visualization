import java.util.Collections;

int genome_length = 12;
int population_size = 300;
float mutation_probability = 0.02;

Draw draw = new Draw();
Start start = new Start(genome_length, population_size);
Reproduction reproduction = new Reproduction(genome_length, population_size, mutation_probability);

//---------------------------------------------------------------------------------------

// SETUP
void setup() {
  
  background(0);
  size(700, 700);

}
//---------------------------------------------------------------------------------------

// START
ArrayList<PVector> knots = start.create_knots();
ArrayList<ArrayList> seed_generation = start.seed(knots);
ArrayList<ArrayList> parents = reproduction.selection(seed_generation);
ArrayList<ArrayList> current_parents = parents;
ArrayList<PVector> current_fittest = current_parents.get(0);
ArrayList<ArrayList> current_generation = seed_generation;//new ArrayList<ArrayList>();
int i = 0;
//---------------------------------------------------------------------------------------

// DRAW LOOP
void draw() {
  i++;
  background(0);
  draw.draw_knots(knots);
  

  current_parents = reproduction.selection(current_generation);
  current_generation = reproduction.crossover(current_parents.get(0), current_parents.get(1));
  
  current_fittest = current_parents.get(0);
  println(reproduction.check_fitness(current_fittest));
  
  draw.draw_paths(current_fittest);
  
  delay(50);

  
}
//---------------------------------------------------------------------------------------