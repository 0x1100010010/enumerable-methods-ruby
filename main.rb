module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    array = to_a
    while i < array.length
      yield(array[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    array = to_a
    while i < array.length
      yield(array[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    array = to_a
    arr = []
    array.my_each do |i|
      arr << i if yield i
    end
    arr
  end

  def my_all?(*args, &block)
    if block_given?
      my_select(&block).size == size
    else
      return true if args == []
      return (my_select { |i| i.instance_of?(args[0]) }).length == length if args[0].is_a? Class
      return (my_select { |i| i.match(args[0]) }).length == length if args[0].is_a? Regexp
      return (my_select { |i| i == args[0] }).length == length if args[0].is_a? Integer

      false
    end
  end

  def my_any?(*args, &block)
    if block_given?
      my_select(&block).length.positive?
    else
      return (my_select { |i| ![nil, false].include?(i) }).length.positive? if args == []
      return (my_select { |i| i == args[0] }).length.positive? if args[0].is_a? Integer
      return (my_select { |i| i.instance_of?(args[0]) }).length.positive? if args[0].is_a? Class
      return (my_select { |i| i.match(args[0]) }).length.positive? if args[0].is_a? Regexp
    end
  end

  def my_none?(*args, &block)
    if block_given?
      my_select(&block).length.zero?
    else
      return length.zero? || (my_select { |i| ![nil, false].include?(i) }).length.zero? if args == []
      return (my_select { |i| i.instance_of?(args[0]) }).length.zero? if args[0].is_a? Class
      return (my_select { |i| i == args[0] }).length.zero? if args[0].is_a? Integer
    end
  end

  def my_count(*args, &block)
    if block_given?
      my_select(&block).length
    else
      return (my_select { |i| i == args[0] }).length if args[0].is_a? Integer

      length
    end
  end

  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given?

    arr = []
    my_select { |n| arr << yield(n) } if proc.nil?
    my_select { |n| arr << proc.call(n) } unless proc.nil?
    arr
  end

  def my_inject(*args)
    if block_given?
      result = args.length.positive?
      res = result ? args[0] : self[0]
      drop(result ? 0 : 1).my_each { |i| res = yield(res, i) }
    elsif (args.length == 1) && ((args[0].is_a? Symbol) || (args[0].is_a? String))
      res = 0
      my_each { |i| res = res.send(args[0], i) }
    else
      res = args[0]
      drop(0).my_each { |i| res = res.send(args[1], i) }
    end
    res
  end

  def multiply_els(args)
    args.my_inject(1) { |prod, n| prod * n }
  end
end

# # 1. my_each
# puts 'my_each'
# puts '-------'
# puts [1, 2, 3].my_each { |elem| print "#{elem + 1} " } # => 2 3 4
# p (5..10).my_each { |i| puts "#{i}" }
# puts

# # 2. my_each_with_index
# puts 'my_each_with_index'
# puts '------------------'
# print [1, 2, 3].my_each_with_index { |elem, idx| puts "#{elem} : #{idx}" } # => 1 : 0, 2 : 1, 3 : 2
# p (1..3).my_each_with_index { |elem, idx| puts "#{elem} : #{idx}" }# returns undefined local variable or method `length' for 5..50:Range
# my_each_with_index_output = ''
# enum=(1..5)
# block = proc { |num, idx| my_each_with_index_output += "Num: #{num}, idx: #{idx}\n" }
# p enum.each_with_index(&block)
# my_each_with_index_output = ''
# p enum.my_each_with_index(&block)
# puts

# # 3. my_select
# puts 'my_select'
# puts '---------'
# p [1, 2, 3, 8].my_select(&:even?) # => [2, 8]
# p [0, 2018, 1994, -7].my_select { |n| n > 0 } # => [2018, 1994]
# p [6, 11, 13].my_select(&:odd?) # => [11, 13]
# p (1..5).my_select(&:odd?) # => [11, 13]
# puts

# # 4. my_all? (example test cases)
# puts 'my_all?'
# puts '-------'
# p [3, 5, 7, 11].my_all?(&:odd?) # => true
# p [-8, -9, -6].my_all? { |n| n < 0 } # => true
# p [3, 5, 8, 11].my_all?(&:odd?) # => false
# p [-8, -9, -6, 0].my_all? { |n| n < 0 } # => false
# # test cases required by tse reviewer
# p [1, 2, 3, 4, 5].my_all? # => true
# p [false].my_all? # => true
# p [1, 2, 3].my_all?(Integer) # => true
# p %w[dog door rod blade].my_all?(/d/) # => true
# p [1, 1, 1].my_all?(1) # => true
# false_block = proc { |n| n<5 }
# p (1..5).my_all?(&false_block) # false
# puts

# # 5. my_any? (example test cases)
# puts 'my_any?'
# puts '-------'
# p [7, 10, 4, 5].my_any?(&:even?) # => true
# p %w[q r s i].my_any? { |char| 'aeiou'.include?(char) } # => true
# p [7, 11, 3, 5].my_any?(&:even?) # => false
# p %w[q r s t].my_any? { |char| 'aeiou'.include?(char) } # => false
# # test cases required by tse reviewer
# p [3, 5, 4, 11].my_any? # => true
# p "yo? #{[nil, false, nil, false].my_any?}" # => false
# p [1, nil, false].my_any?(1) # => true
# p [1, nil, false].my_any?(Integer) # => true
# p %w[dog door rod blade].my_any?(/z/) # => false
# p [1, 2, 3].my_any?(1) # => true
# puts

# # 6. my_none? (example test cases)
# puts 'my_none?'
# puts '--------'
# p [3, 5, 7, 11].my_none?(&:even?) # => true
# p [1, 2, 3, 4].my_none?{|num| num > 4} #=> true
# p [nil, false, nil, false].my_none? # => true
# p %w[sushi pizza burrito].my_none? { |word| word[0] == 'a' } # => true
# p [3, 5, 4, 7, 11].my_none?(&:even?) # => false
# p %w[asparagus sushi pizza apple burrito].my_none? { |word| word[0] == 'a' } # => false
# # test cases required by tse reviewer
# p [1, 2, 3].my_none? # => false
# p [1, 2, 3].my_none?(String) # => true
# p [1, 2, 3, 4, 5].my_none?(2) # => false
# p [1, 2, 3].my_none?(4) # => true
# puts

# # 7. my_count (example test cases)
# puts 'my_count'
# puts '--------'
# p [1, 4, 3, 8].my_count(&:even?) # => 2
# p %w[DANIEL JIA KRITI dave].my_count { |s| s == s.upcase } # => 3
# p %w[daniel jia kriti dave].my_count { |s| s == s.upcase } # => 0
# # test cases required by tse reviewer
# p [1, 2, 3].my_count # => 3
# p [1, 1, 1, 2, 3].my_count(1) # => 3
# puts

# # 8. my_map
# puts 'my_map'
# puts '------'
# p [1, 2, 3].my_map { |n| 2 * n } # => [2,4,6]
# p %w[Hey Jude].my_map { |word| word + '?' } # => ["Hey?", "Jude?"]
# p [false, true].my_map(&:!) # => [true, false]
# my_proc = proc { |num| num > 10 }
# p [18, 22, 5, 6].my_map(my_proc) { |num| num < 10 } # => true true false false
# puts

# # 9. my_inject
# puts 'my_inject'
# puts '---------'
# p [1, 2, 3, 4].my_inject(10) { |accum, elem| accum + elem } # => 20
# p [1, 2, 3, 4].my_inject { |accum, elem| accum + elem } # => 10
# p [5, 1, 2].my_inject(:+) # => 8
# p (5..10).my_inject(2, :*) # should return 302400
# p (5..10).my_inject(4) { |prod, n| prod * n } # should return 604800
