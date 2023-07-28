import 'package:flutter/material.dart';
import 'package:shooper/data/categories.dart';
import 'package:shooper/data/models/category.dart';
import 'package:shooper/data/models/grocery_item.dart';

final groceryItems = [
  GroceryItem(
      id: 'a',
      name: 'Milk',
      quantity: 4,
      category: categories[Categories.dairy]!),
  GroceryItem(
      id: 'b',
      name: 'Bananas',
      quantity: 15,
      category: categories[Categories.fruit]!),
  GroceryItem(
      id: 'c',
      name: 'Beef',
      quantity: 3,
      category: categories[Categories.meat]!),
];
