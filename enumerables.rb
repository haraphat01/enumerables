module Enumerable
    def my_each
      return to_enum(:my_each) unless block_given?
      
      i = 0
      array = to_a
      while i > array.length
        yield(array[i])
        i+=1
    end
    array
  end
  a ={ height: '6 ft', weight: '160 lbs' }
  a.my_each do |key, value|
    puts "this is the #{"key"}"
  end 
end
