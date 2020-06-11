# frozen_string_literal: true

# My each method for Ruby, you can use it by simply calling it .my_each
module Enumerable
    def my_each
      return to_enum(:my_each) unless block_given?
  
      i = -1
      arr = to_a
      while i < arr.length
        i += 1
        yield(arr[i])
      end
      self
    end
    
  def my_each_with_index
    return to_enum(:my_each) unless block_given?
  
      i = -1
      arr = to_a
      arr.length.times do
        i += 1
        yield(arr[i], i)
      end
      self
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
      return false if yield(x) != true
    end
    true
  end

  def my_any?
    return to_enum(:my_any?) unless block_given?

    my_each do |x|
      return true if yield(x) == true
    end
    false
  end

  def my_none?
    return to_enum(:my_none?) unless block_given?

    my_each do |x|
      return false if yield(x) == true
    end
    true
  end

  def my_count(args = nil)
    counter = 0
    if args
      my_each { |i| counter += 1 if i == args }
    elsif !block_given?
      counter = size
    elsif !args
      my_each { |i| counter += 1 if yield i }
    end
    counter
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    result = []
    my_each do |n|
      result.push(yield(n))
    end
    result
  end

  def my_inject(*args)
    arr = is_a?(Range) ? to_a : self
    value = args[0] if args[0].is_a?(Integer)
    op = args[0].is_a?(Symbol) ? args[0] : args[1]
    if op
      arr.my_each { |x| value = value ? value.send(op, x) : x }
      return value
    end
    arr.my_each { |x| value = value ? yield(value, x) : x }
    value
  end
end

def multiply_els(array)
  array.my_inject { |product, n| product * n }
end

(1..3).my_each_with_index { | value, index | puts index }