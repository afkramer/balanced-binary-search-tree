# frozen_string_literal: true

require_relative './node'
require_relative './tree'

def main
  values = (Array.new(15) { rand(1..100)})
  puts "Starting array: #{values}"
  tree = Tree.new(values)
  tree.pretty_print
  puts "The tree is balanced: #{tree.balanced?}"
  puts "Level-order: #{tree.level_order}"
  puts "Inorder: #{tree.inorder}"
  puts "Preorder: #{tree.preorder}"
  puts "Postorder: #{tree.postorder}"
  new_values = [105, 101, 110, 107, 122, 125, 102, 103, 104]
  puts 'Adding several elements to the tree'
  new_values.each { |value| tree.insert(tree.root, value) }
  tree.pretty_print
  puts "The tree is balanced: #{tree.balanced?}"
  puts 'Rebalancing the tree'
  tree.rebalance
  tree.pretty_print
  puts "The tree is balanced: #{tree.balanced?}"
  puts "Level-order: #{tree.level_order}"
  puts "Inorder: #{tree.inorder}"
  puts "Preorder: #{tree.preorder}"
  puts "Postorder: #{tree.postorder}"
end

main
