import 'package:flutter/material.dart';
import 'package:shooper/data/models/category.dart';

const categories = {
  Categories.vegetables: Category(
    'Vegetables',
    Color.fromARGB(255, 46, 122, 84),
  ),
  Categories.fruit: Category(
    'Fruit',
    Color.fromARGB(255, 130, 177, 70),
  ),
  Categories.meat: Category(
    'Meat',
    Color.fromARGB(255, 112, 68, 38),
  ),
  Categories.dairy: Category(
    'Dairy',
    Color.fromARGB(255, 18, 56, 64),
  ),
  Categories.carbs: Category(
    'Carbs',
    Color.fromARGB(255, 0, 60, 255),
  ),
  Categories.sweets: Category(
    'Sweets',
    Color.fromARGB(255, 255, 149, 0),
  ),
  Categories.spices: Category(
    'Spices',
    Color.fromARGB(255, 255, 187, 0),
  ),
  Categories.convenience: Category(
    'Convenience',
    Color.fromARGB(255, 191, 0, 255),
  ),
  Categories.hygiene: Category(
    'Hygiene',
    Color.fromARGB(255, 149, 0, 255),
  ),
  Categories.other: Category(
    'Other',
    Color.fromARGB(255, 0, 225, 255),
  ),
  Categories.seafood: Category(' Sea-Food', Colors.blueAccent),
  Categories.drinks: Category(
    ' Drinks ',
    Color.fromARGB(255, 60, 2, 32),
  ),
  Categories.snacks: Category(' Snacks', Color.fromARGB(255, 21, 41, 74)),
  Categories.cereals: Category(' Cereals', Color.fromARGB(255, 50, 11, 246)),
  Categories.swallows: Category(' Swallows', Color.fromARGB(255, 24, 60, 52)),
};
