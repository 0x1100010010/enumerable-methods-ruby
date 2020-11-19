module Enumerable
  def my_each
    for i in self do
      yield i
    end
  end

  def my_each_with_index
    i = 0
    while i < self.length
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select
    arr = []
    for i in self do
      arr << i if yield i
    end
    arr
  end

  def my_all?(*args)
    return args unless block_given?

    (self.my_select { |i| yield(i) }).length == self.length
    # puts args # args.kind_of?(args) #(self.my_select { |i| i==args } )
  end

  def my_any?
  end

  def my_none?
  end

  def my_count
  end

  def my_map
  end

  def my_inject
  end

  def multiply_els
  end
end

# # 1. my_each
# puts 'my_each'
# puts '-------'
# puts [1, 2, 3].my_each { |elem| print "#{elem + 1} " } # => 2 3 4
# puts

# 2. my_each_with_index
# puts 'my_each_with_index'
# puts '------------------'
# print([1, 2, 3].each_with_index { |elem, idx| puts "#{elem} : #{idx}" }) # => 1 : 0, 2 : 1, 3 : 2
# print([1, 2, 3].my_each_with_index { |elem, idx| puts "#{elem} : #{idx}" }) # => 1 : 0, 2 : 1, 3 : 2
# puts

# # 3. my_select
# puts 'my_select'
# puts '---------'
# p [1, 2, 3, 8].my_select(&:even?) # => [2, 8]
# p [0, 2018, 1994, -7].my_select { |n| n > 0 } # => [2018, 1994]
# p [6, 11, 13].my_select(&:odd?) # => [11, 13]
# puts

# 4. my_all? (example test cases)
puts 'my_all?'
puts '-------'
p [3, 5, 7, 11].my_all?(&:odd?) # => true
p [-8, -9, -6].my_all? { |n| n < 0 } # => true
p [3, 5, 8, 11].my_all?(&:odd?) # => false
p [-8, -9, -6, 0].my_all? { |n| n < 0 } # => false
# test cases required by tse reviewer
p [1, 2, 3, 4, 5].my_all? # => true
p [1, 2, 3].my_all?(Integer) # => true
p %w[dog door rod blade].my_all?(/d/) # => true
p [1, 1, 1].my_all?(1) # => true
puts
