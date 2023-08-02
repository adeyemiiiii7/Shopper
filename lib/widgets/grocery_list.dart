import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shooper/data/categories.dart';
//import 'package:shooper/data/dummy_data.dart';
import 'package:shooper/data/models/grocery_item.dart';
import 'package:shooper/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  // var _isLoading = true;
  late Future<List<GroceryItem>> _loadedItems;
  String? _error;

  @override
  //to intialize the _loaditems method
  void initState() {
    super.initState();
    _loadedItems = _loadItems();
  }

  Future<List<GroceryItem>> _loadItems() async {
    final url =
        Uri.https('shooper-58945-default-rtdb.firebaseio.com', 'shooper.json');
    //Uri.https('abc.firebaseio.com', 'shooper.json');
    final response = await http.get(url);
    //print(response.statusCode);

    if (response.statusCode >= 400) {
      setState(() {
        _error = 'Failed to fetch data, pls try again later......';
      });
    }
    if (response.body == 'null') {
      //no need to set a laoding state manually any more thanks to future builder
      // setState(() {
      //   _isLoading = false;
      // });
      //return an empty list
      return [];
    }
    //use json.decode to convert a map back
    //add dynamic because it has numbers
    //final category = categories.entries.firstWhere(...).value;: Inside the loop, this line looks up the category of the grocery item based on the 'category' property in the JSON data.
    // It uses the categories.entries to get the list of key-value pairs in the categories map. Then, it uses the firstWhere method to find the first entry whose value's title matches the 'category' value of
    //the current grocery item in the loop. Finally, it extracts the value of the matching category and assigns it to the category variable
//loadedItems.add(...): After retrieving the category, this line creates a new Grocery Item
    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> loadedItems = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
              (catItem) => catItem.value.title == item.value['category'])
          .value;
      loadedItems.add(
        GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category),
      );
    }
    //don't forget intialize with setstate
    //to override the locally avaliable data of _groceryItems
    // setState(() {
    //   _groceryItems = loadedItems;
    //   _isLoading = false;
    // });
    return loadedItems;
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
    // _loadItems();

    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) async {
    //handle errors for emoving the item incase the url for the deleteing the items are wrong
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });
    final url = Uri.https(
        'shooper-58945-default-rtdb.firebaseio.com', 'shooper/${item.id}.json');
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      throw Exception('Failed To Fetch Grocery Items, Try Again Later!');
      // setState(() {
      //   _groceryItems.insert(index, item);
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            _removeItem(_groceryItems[index]);
          },
          key: ValueKey(_groceryItems[index].id),
          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(
              _groceryItems[index].quantity.toString(),
            ),
          ),
        ),
      );
    }
    // if (_error != null) {
    //   content = Center(
    //     child: Text(_error!),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
          future: _loadedItems,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(_error!),
              );
            }
          }),
    );
  }
}
