module Enumerable
    def my_each
      return to_enum(:my_each) unless block_given?
      
      i = 0
      array = to_a
      while i < array.length
        yield(array[i])
        i+=1
      end
    array
    end
 

    def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    
    i = 0
    array = to_a
    while i < array.length
      yield(array[i], i)
      i+=1
  end
  array
   end

    def my_select
    return to_enum(:my_select) unless block_given?
    new_array = []
     my_each do |x|
     new_array.push(x) if yield(x) == true
  end
  new_array
    end

    def my_all?
  return to_enum(:my_all?) unless block_given?
   my_each do |x|
 if yield(x) != true
  return false 
 
  
  
    end

  end
  true
end
def my_any?
  return to_enum(:my_any?) unless block_given?
  my_each do |x|
  if yield(x) == true
    return true
  end
end
false
end
def my_none?
  return to_enum(:my_none?) unless block_given?
  my_each do |x|
  if yield(x) == true
    return false
  end
end
true
end
end



puts %w{ant bear cat}.none? { |word| word.length == 3 } #=> true
puts %w{ant bear cat}.none? { |word| word.length < 2 } #=> false
                     

