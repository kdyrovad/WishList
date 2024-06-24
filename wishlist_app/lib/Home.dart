import 'package:flutter/material.dart';

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

//Update Screen

class EditItemScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  EditItemScreen({required this.item});

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.item['name'];
    _descriptionController.text = widget.item['description'];
    _urlController.text = widget.item['url'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Wishlist Item'),
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
                final updatedItem = {
                  '_id': widget.item['_id'],
                  'name': _nameController.text,
                  'description': _descriptionController.text,
                  'url': _urlController.text,
                };

                Navigator.pop(context, updatedItem);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
