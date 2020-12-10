require '../main.rb'

describe Enumerable do
  arr = [3, 4, 7, 1, 2]

  describe '#my_each' do
    it "returned each value" do
      expect(arr.my_each {|i|} ).to eq(arr.each{|i|})
    end
  end
end
