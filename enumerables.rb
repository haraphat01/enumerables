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
end
  

puts [1,2,3,4,5,6].my_select(&:even?)



