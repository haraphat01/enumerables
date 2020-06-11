# frozen_string_literal: true
# My each method for Ruby, you can use it by simply calling it .my_each
module Enumerable # rubocop:disable Metrics/ModuleLength
  def my_each
    new_array = [] unless block_given?
    i = 0
    a = Array self
    while i < a.size
      yield(a[i]) if block_given?
      new_array << a[i] unless block_given?
      i += 1
    end
    return Enumerator.new(new_array) unless block_given?

    self
  end

  def my_each_with_index
    new_array = [] unless block_given?
    i = 0
    a = Array self
    while i < size
      yield(a[i], i) if block_given?
      new_array << a[i] unless block_given?
      i += 1
    end
    return Enumerator.new(new_array) unless block_given?

    self
  end

  def my_select
    return my_each unless block_given?

    new_array = []
    my_each { |n| new_array.push(n) if yield(n) }
    new_array
  end

  def my_all?(pattern = nil)
    if block_given?
      my_each { |n| return false unless yield(n) }
    elsif pattern
      my_each { |n| return false unless value(n, pattern) }
    else
      my_each { |n| return false unless n }
    end
    true
  end

  def my_any?(pattern = nil)
    if block_given?
      my_each { |n| return true if yield(n) }
    elsif pattern
      my_each { |n| return true if any_checker(n, pattern) }
    else
      my_each { |n| return true if n }
    end
    false
  end

  def my_none?(pattern = nil)
    if block_given?
      my_each { |n| return false if yield(n) }
    elsif pattern
      my_each { |n| return false if value(n, pattern) }
    else
      my_each { |n| return false if n }
    end
    true
  end

  def my_count(item = false)
    count = 0

    if !block_given?
      return size unless item

      my_each { |n| count += 1 if n == item }
    elsif block_given? && !item
      my_each { |n| count += 1 if yield(n) }
    elsif block_given? && item
      my_each { |n| count += 1 if n == item }
    end
    count
  end

  def my_map(proc = nil)
    new_array = []
    if proc
      my_each { |n| new_array.push(proc.call(n)) }
    else
      my_each { |n| new_array.push(yield(n)) } if block_given?
      my_each { |n| new_array << n } unless block_given?
      new_array = Enumerator.new(new_array) unless block_given?
      new_array
    end
  end

  def my_inject(*args)
    memo = nil
    if oop?(args[0])
      initial = args[1]
      operation = args[0]
      memo = initial
    elsif args[0]
      initial = args[0]
      operation = args[1]
      memo = initial
    end
    if block_given? && operation.nil?
      my_each do |n|
        memo && memo = yield(memo, n)
        memo ||= n
        memo = nil if yield(memo, n).nil?
      end
    else
      memo = nil_asign(operation, memo)
      my_each { |n| memo = oop_eval(memo, n, operation) }
    end
    memo
  end
end

def multiply_els(array)
  array.my_inject { |product, n| product * n }
end
puts (5..10).inject { |sum, n| sum + n } 