import 'package:flutter/material.dart';
import 'api_service.dart';

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

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Wishlist Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _urlController,
              decoration: InputDecoration(labelText: 'URL'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newItem = {
                  'name': _nameController.text,
                  'description': _descriptionController.text,
                  'url': _urlController.text,
                };

                Navigator.pop(context, newItem);
              },
              child: Text('Add Item'),
            ),
          ],
        ),
      ),
    );
  }
}

