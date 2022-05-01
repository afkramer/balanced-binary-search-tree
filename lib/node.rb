# frozen_string_literal: true

# The node class contains functionality to create Nodes in a balanced binary search tree
class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def <=>(other)
    data <=> other.data
  end
end
