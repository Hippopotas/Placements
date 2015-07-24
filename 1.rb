class Generations
 
  def initialize(length)
    @length = length.to_i - 1                 #Subtracts 1 due to array index counter starting at 0.
    @@all_gens = Array.new                    #The entire array of generations is stored here.
    @generation = Array.new(@length)          #All generations are arrays that will be .join'd to strings later.
   
    0.upto(@length) do |position|             #First gen is randomly created.
      @generation[position] = rand(2)
    end
    
    @@all_gens.push(@generation)              #Making the two dimensional array. Each generation is an element.
  end
  
  def nextgen(gencount,zerosum,onesum,twosum,threesum)
    @generation=Array.new(@length)            #Resets the temporary variable of the generation being created
    0.upto(@length) do |position|             #since the generations are all saved in @@all_gens.
      
      #Puts the sums (0 to 3) in the correct position, with specific cases for the first and last positions.
      if position == 0
        @generation[0] = 0 + @@all_gens[gencount-1][0] + @@all_gens[gencount-1][1]
      elsif position == @length
        @generation[@length] = 0 + @@all_gens[gencount-1][@length-1] + @@all_gens[gencount-1][@length]
      else
        @generation[position] = @@all_gens[gencount-1][position-1] + @@all_gens[gencount-1][position] + @@all_gens[gencount-1][position+1]
      end
      
      #Replaces sums with 0s and 1s depending on inputted rules.
      if @generation[position] == 0
        @generation[position] = zerosum
      elsif @generation[position] == 1
        @generation[position] = onesum
      elsif @generation[position] == 2
        @generation[position] = twosum
      elsif @generation[position] == 3
        @generation[position] = threesum
      end
    end
    @@all_gens.push(@generation)
  end
  
  #Writer method for later access.
  def self.all
    @@all_gens
  end
  
end

def main
  
  #For when there are too many console inputs.
  if ARGV[6].to_s == ARGV[6]
    puts "You entered too many arguments. Please enter only 6 numbers."
  
  #For when there are too few console inputs.
  elsif not ARGV[5].to_s == ARGV[5]
    puts "You did not input enough values. There should be exactly 6 numbers."

  #For when console inputs are not all digits. 
  elsif not (ARGV[0] !~ /\D/ and ARGV[1] !~ /\D/ and ARGV[2] !~ /\D/ and ARGV[3] !~ /\D/ and ARGV[4] !~ /\D/ and ARGV[5] !~ /\D/)
    puts "Your input was invalid. It should be formatted as a series of 6 numbers (no letters)."
    
  #For when you put everything in correctly.
  else
    #Makes the first generation.
    gens = Generations.new(ARGV[0])
    1.upto(ARGV[1].to_i-1) do |gen|                      #Makes every subsequent generation.
      gens.nextgen(gen,ARGV[2].to_i,ARGV[3].to_i,ARGV[4].to_i,ARGV[5].to_i)
    end
    
    #Outputs result to console.
    Generations.all.each do |gen|
      combined = gen.join
      puts combined
    end
  end
end

#ARGV order should be: length / generations / 0 sum / 1 sum / 2 sum / 3 sum

main