require_relative 'node'

class Tree
  attr_accessor :root_node

  def initialize(messy_array)
    clean_array = clean(messy_array)

    self.root_node = build_tree(clean_array, 0, clean_array.size - 1)
  end

  def build_tree(array, start_index, end_index)
    if start_index > end_index
      return nil
    else
      middle_index = (start_index + end_index) / 2
      root_node = Node.new(array[middle_index])

      root_node.left_child = build_tree(array, start_index, middle_index - 1)
      root_node.right_child = build_tree(array, middle_index + 1, end_index)
    end

    root_node
  end

  def clean(array)
    array.sort.uniq
  end
end

