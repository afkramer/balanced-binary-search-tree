# frozen_string_literal: true

require_relative './node'

# Tree class contains the functionality to build a balanced binary search tree
class Tree
  attr_reader :root

  def initialize(array)
    @root = build_tree(array.sort.uniq, 0, array.sort.uniq.length - 1)
  end

  def build_tree(array, beg, last)
    return nil if beg > last

    mid = (beg + last) / 2
    root = Node.new(array[mid])

    root.left = build_tree(array, beg, mid - 1)
    root.right = build_tree(array, mid + 1, last)

    root
  end

  # This is a Ruby version of: https://www.geeksforgeeks.org/binary-search-tree-set-1-search-and-insertion/?ref=lbp
  def insert(root, value)
    if root.nil?
      root = Node.new(value)
      return root
    end

    if value < root.data
      root.left = insert(root.left, value)
    elsif value > root.data
      root.right = insert(root.right, value)
    end

    root
  end

  # This is a Ruby version of: https://www.geeksforgeeks.org/binary-search-tree-set-2-delete/?ref=lbp
  def delete(root, value)
    return root if root.nil?

    if value < root.data
      root.left = delete(root.left, value)
    elsif value > root.data
      root.right = delete(root.right, value)
    else
      if root.left.nil?
        return root.right
      elsif root.right.nil?
        return root.left
      end

      # Get the in-order successor (smallest value in right subtree)
      root.data = minimum_value(root.right)

      # Delete the in-order successor
      root.right = delete(root.right, root.data)
    end
    root
  end

  def minimum_value(root)
    min = root.data
    until root.left.nil?
      min = root.left.data
      root = root.left
    end
    min
  end

  def find(root, value)
    return root if root.nil?

    if root.data < value
      find(root.right, value)
    elsif root.data > value
      find(root.left, value)
    else
      root
    end
  end

  def level_order
    return root if root.nil?

    to_traverse = [root]
    values = []
    until to_traverse.empty?
      curr_node = to_traverse.shift
      to_traverse << curr_node.left unless curr_node.left.nil?
      to_traverse << curr_node.right unless curr_node.right.nil?
      block_given? ? yield(curr_node) : values << curr_node.data
    end
    return values unless values.empty?
  end

  def level_order_rec(to_traverse = [root], values = [], &block)
    node = to_traverse.shift
    return node if node.nil?

    to_traverse << node.left unless node.left.nil?
    to_traverse << node.right unless node.right.nil?

    block_given? ? yield(node) : values << node.data
    level_order_rec(to_traverse, values, &block)
    return values unless block_given?
  end

  # Nope --> this does a kind of depth first search
  def level_order_rec_1(root, values = [])
    return root if root.nil?

    block_given? ? yield(root) : values << root.data
    level_order_rec(root.left, values)
    level_order_rec(root.right, values)
    return values unless values.empty?
  end

  # Method provided by student of TOP
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new([90, 80, 90, 10, 70, 30, 10, 90, 50, 20, 40])
tree.insert(tree.root, 60)
tree.insert(tree.root, 5)
tree.insert(tree.root, 25)
tree.find(tree.root, 25)
tree2 = Tree.new([36,81,50,30,20,85,82,75,34,32,85,81,50,40,70,60,82,81,65,70,32,36,75])
tree2.insert(tree2.root, 42)
tree2.insert(tree2.root, 90)
# tree2.pretty_print
p tree2.level_order_rec
