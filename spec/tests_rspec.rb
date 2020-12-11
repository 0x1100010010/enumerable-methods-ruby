require '../main.rb'
describe Enumerable do
  emp_arr = []
  ran = (1..10)
  arr = [3, 4, 7, 1, 2, 8]
  arr_str = %w[andrik alan lluis akshay]
  up_arr = %w[ANDRIK ALAN LLUIS AKSHAY]
  context '#my_each' do
    it "my_each iteration testing" do
      expect(arr.my_each {|i|}).to eq(arr.each {|i|})
    end
    it "my_each block testing" do
      my_emp_arr = []
      arr.each {|i| emp_arr << (i + 1)}
      arr.my_each {|i| my_emp_arr << (i + 1)}
      expect(my_emp_arr).to eq(emp_arr)
    end
    it "my_each range testing" do
      expect(ran.my_each {|i|}).to eq(ran.each {|i|})
    end
  end
  context '#my_each_with_index' do
    it "my_each_with_index iteration testing" do
      expect(arr.my_each_with_index {|i, j|}).to eq(arr.each_with_index {|i, j|})
    end
    it "my_each_with_index block testing" do
      expect(arr.my_each_with_index {|i, j| puts "#{i} : #{j}"}).to eq(arr.each_with_index {|i, j| puts "#{i} : #{j}"})
    end
    it "my_each_with_index range testing" do
      expect(ran.my_each_with_index {|i, j| puts "#{i} : #{j}"}).to eq(ran.each_with_index {|i, j| puts "#{i} : #{j}"})
    end
  end