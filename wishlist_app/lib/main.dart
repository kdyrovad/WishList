import 'package:flutter/material.dart';
import 'api_service.dart';
import 'Home.dart';

void main() {
  runApp(WishlistApp());
}

class WishlistApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wishlist App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WishlistScreen(),
    );
  }
}

class WishlistScreen extends StatefulWidget {
  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<dynamic> items = [];

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  void fetchItems() async {
    try {
      final data = await ApiService.getItems();
      setState(() {
        items = data;
      });
    } catch (e) {
      print('Failed to load items: $e');
    }
  }

  void addItem(Map<String, String> newItem) async {
    try {
      await ApiService.addItem(newItem);
      fetchItems();
    } catch (e) {
      print('Failed to add item: $e');
    }
  }

  void updateItem(Map<String, dynamic> updatedItem) async {
    try {
      await ApiService.updateItem(updatedItem['_id'], updatedItem);
      fetchItems();
    } catch (e) {
      print('Failed to update item: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]['name']),
            subtitle: Text(items[index]['description']),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  await ApiService.deleteItem(items[index]['_id']);
                  fetchItems();
                } catch (e) {
                  print('Failed to delete item: $e');
                }
              },
            ),
            onTap: () async {
              final updatedItem = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditItemScreen(item: items[index]),
                ),
              );

              if (updatedItem != null) {
                updateItem(updatedItem);
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newItem = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemScreen()),
          );

          if (newItem != null) {
            addItem(newItem);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
