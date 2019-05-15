// IMPORTS
import java.util.Collections;
//---------------------------------------------------------------------------------------

// HYPERPARAMETERS AND CLASS OBJECTS
int genome_length = 15;
int population_size = 300;
float mutation_probability = 0.05;

// call all classes and pass the hyperparameters as constructor argument
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
int stop_counter = 0;
float previous_fitness = 0.0;
//---------------------------------------------------------------------------------------

// DRAW LOOP
void draw() {
  
  // count iterations, reset background, draw the static knots
  i++;
  background(0);
  draw.draw_knots(knots);
  
  // select the parents, generate new generation out of them
  current_parents = reproduction.selection(current_generation);
  current_generation = reproduction.crossover(current_parents.get(0), current_parents.get(1));
  
  // select the two fittest as the new parents and draw the most fittest
  current_fittest = current_parents.get(0);
  draw.draw_paths(current_fittest);
  
  // print out the highest fitness
  float fitness = reproduction.check_fitness(current_fittest);
  println("fitness at iteration [", i, "] : ", fitness);
  
  // decide to stop the trianing by checking differences of the highest fitness-score and print end-result
  if(previous_fitness == fitness) {
    stop_counter++;
  }
  else {
    stop_counter = 0;
  }
  if (stop_counter == 100) {
    noLoop();
    println("\n + finished evolutional training after [", i, "] iterations with a fitness-score of [", fitness, "]"); 
  }
  previous_fitness = fitness;
  
  // delay to manage the speed
  delay(50);
  
}