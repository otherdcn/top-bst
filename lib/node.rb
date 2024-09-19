class Node
  include Comparable

  attr_accessor :data, :left_child, :right_child

  def initialize(data)
    self.data = data
    self.left_child = nil
    self.right_child = nil
  end

  def <=>(other)
    data <=> other.data
  end
end
