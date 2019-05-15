// IMPORTS
import java.util.Random;
//---------------------------------------------------------------------------------------

// REPRODCUTION
class Reproduction {
  
  // CONSTRUCTOR
  Reproduction(int genome_length, int population_size, float mutation_probability) {
    population_size = population_size;
    genome_length = genome_length;
    mutation_probability = mutation_probability;
  }
  //---------------------------------------------------------------------------------------
  
  // FITNESS FUNCTION
  float check_fitness(ArrayList<PVector> knots) {
    
    // 100 devided by the sum of all vector distances
    float sum = 0;
    knots.add(knots.get(0));
    for(int i=0; i<=knots.size() - 2; i++) {
      
      PVector knot1 = knots.get(i);
      PVector knot2 = knots.get(i+1);
      
      sum += knot1.dist(knot2);
    }
    knots.remove(knots.size() - 1);
    
    return 100 / sum;
  }
  //---------------------------------------------------------------------------------------
  
  // SELECTION
  ArrayList<ArrayList> selection(ArrayList<ArrayList> population) {
    
    // store all fitness scores
    ArrayList<Float> fitness_scores = new  ArrayList<Float>();
    for(int i=0; i<=population_size - 2; i++) {
      float fitness = check_fitness(population.get(i));
      fitness_scores.add(fitness);
    }
    
    ArrayList<PVector> parent1 = new ArrayList<PVector>();
    ArrayList<PVector> parent2 = new ArrayList<PVector>();
    
    // select most fittest and remove
    parent1 = population.get(fitness_scores.indexOf(Collections.max(fitness_scores)));
    fitness_scores.remove(Collections.max(fitness_scores));
    population.remove(fitness_scores.indexOf(Collections.max(fitness_scores)));
    
    // select second fittest
    parent2 = population.get(fitness_scores.indexOf(Collections.max(fitness_scores)));  
    
    ArrayList<ArrayList> parents = new ArrayList<ArrayList>();
    parents.add(new ArrayList(parent1));
    parents.add(new ArrayList(parent2));
    
    return parents;
  }
  //-----------------------------------------------------------------------------------------
  
  // CROSSOVER
  ArrayList<ArrayList> crossover(ArrayList<PVector> parent1, ArrayList<PVector> parent2) {
        
    Random r = new Random();
        
    ArrayList<ArrayList> children = new ArrayList<ArrayList>();
    for(int i=0; i<=population_size - 1; i++) {
      
      // random choose between different crossover methods
      int choice = r.nextInt((2 - 1) + 1) + 1;
      switch (choice) {
        
        case 1: {
          // random split first parent and pass the elements to the same index of the child,
          // fill the other indices with the elements of the second parent
          
          int split_index = r.nextInt(((genome_length - 1) - 1) + 1) + 1;

          ArrayList<PVector> child = new ArrayList<PVector>();
          
          for(int k=0; k<=split_index - 1; k++) {
            child.add(parent1.get(k));
          }
          for(int k=split_index; k<=genome_length - 1; k++) {
            for(int g=0; g<=genome_length - 1; g++) {
              
              if(child.contains(parent2.get(g)) == false) {
                child.add(parent2.get(g));
                break;
              }
              
            }
          }
          
          // add possible mutation
          children.add(mutation(child));
        }
        break;
        
      case 2: {
        // random split second parent and pass the elements to the same index of the child,
        // fill the other indices with the elements of the first parent
        
        int split_index = genome_length / 2;
        
        ArrayList<PVector> child = new ArrayList<PVector>();
        
        for(int k=0; k<=split_index - 1; k++) {
          child.add(parent2.get(k));
        }
        for(int k=split_index; k<=genome_length - 1; k++) {
          for(int g=0; g<=genome_length - 1; g++) {
            
            if(child.contains(parent1.get(g)) == false) {
              child.add(parent1.get(g));
              break;
            }
            
          }
        }
        
        // add possible mutation
        children.add(mutation(child));
      }
      break;
     
      }
    }
    
    return children;
  }
  //-----------------------------------------------------------------------------------------
  
  // MUTATION
  ArrayList<PVector> mutation(ArrayList<PVector> child) {

    Random r = new Random();
    
    // do a mutation at a certain likelyhood
    double check = Math.random();
    if(check <= mutation_probability) {
      
      // random switch two elements by their indices
      int random_index1 = r.nextInt((genome_length - 1) + 1);
      int random_index2 = r.nextInt((genome_length - 1) + 1);
      
      PVector to_switch1 = child.get(random_index1);
      PVector to_switch2 = child.get(random_index2);
      
      child.set(random_index1, to_switch2);
      child.set(random_index2, to_switch1);
    }
    
    return child;
  }
 
}