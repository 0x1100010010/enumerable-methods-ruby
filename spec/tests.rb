
#!/usr/bin/ruby

require 'rspec'
require './main.rb'
require 'colorize'

describe Enumerable do
  
  describe '[my_each tests] >'.blue.bold do

    it "my_each returned value." do
      expect( [1, 2, 3, 4].my_each {|i|} ).to eq( [1, 2, 3, 4].each {|i|})
    end
    
    it "my_each block parsing." do
      arr = []
      my_arr = []
      [1, 2, 3, 4].each {|i| arr<<(i+1)}
      [1, 2, 3, 4].my_each {|i| my_arr<<(i+1) }
      expect( my_arr ).to eq( arr )
    end
    
    it "my_each range parsing." do
      expect( (1..5).my_each {|i|} ).to eq( (1..5).each {|i|} )
    end

  end



  describe '[my_each_with_index tests] >'.bold.blue do
    arr = [1, 2, 3, 4]
    it 'my_each_with_index returned value.' do
      expect( arr.my_each_with_index {|item, i|} ).to eq([1, 2, 3, 4].each_with_index {|item, i|})
    end
    
    block = proc {|el, i| puts "#{el}:#{i}"}
    it 'my_each_with_index block parsing.' do
      expect { print(arr.my_each_with_index(&block)) }.to output(print([1, 2, 3].each_with_index(&block))).to_stdout
    end

    my_each_with_index_output = ''
    enum = (1..5)
    block = proc { |num, idx| my_each_with_index_output += "Num: #{num}, idx: #{idx}\n" }
    it 'my_each_with_index block parsing.' do
      expect(enum.my_each_with_index(&block)).to eq(enum.each_with_index(&block))
    end
  end

  

end