import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

//adminpage
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AdminPage(),
    );
  }
}

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _photoController = TextEditingController();
  final TextEditingController _floornoController = TextEditingController();
  final TextEditingController _sectionnoController = TextEditingController();
  final TextEditingController _rownoController = TextEditingController();
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _scanBarcode() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      if (barcodeScanRes != '-1') {
        _barcodeController.text = barcodeScanRes;
      }
    } catch (e) {
      barcodeScanRes = 'Failed to get barcode: $e';
      print(barcodeScanRes);
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    if (source == ImageSource.camera) {
      var status = await Permission.camera.status;
      if (!status.isGranted) {
        await Permission.camera.request();
      }
    } else if (source == ImageSource.gallery) {
      var status = await Permission.photos.status;
      if (!status.isGranted) {
        await Permission.photos.request();
      }
    }

    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _photoController.text =
            pickedFile.path; // This can be used to store the local path
      });
    }
  }

  Future<void> _addItem() async {
    try {
      await FirebaseFirestore.instance.collection('items').add({
        'name': _nameController.text,
        'price': double.parse(_priceController.text),
        'barcode': _barcodeController.text,
        'photo': _photoController.text,
        'floorno': _floornoController.text,
        'sectionno': _sectionnoController.text,
        'rowno': _rownoController.text,
      });

      _nameController.clear();
      _priceController.clear();
      _barcodeController.clear();
      _photoController.clear();
      _floornoController.clear();
      _sectionnoController.clear();
      _rownoController.clear();
      setState(() {
        _image = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item added')),
      );
    } catch (e) {
      print('Failed to add item: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add item: $e')),
      );
    }
  }

  Future<void> _updateItem(String id) async {
    try {
      await FirebaseFirestore.instance.collection('items').doc(id).update({
        'name': _nameController.text,
        'price': double.parse(_priceController.text),
        'barcode': _barcodeController.text,
        'photo': _photoController.text,
        'floorno': _floornoController.text,
        'sectionno': _sectionnoController.text,
        'rowno': _rownoController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item updated')),
      );
    } catch (e) {
      print('Failed to update item: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update item: $e')),
      );
    }
  }

  Future<void> _deleteItem(String id) async {
    try {
      await FirebaseFirestore.instance.collection('items').doc(id).delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item deleted')),
      );
    } catch (e) {
      print('Failed to delete item: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete item: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Item Name'),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Item Price'),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _barcodeController,
                    decoration:
                        const InputDecoration(labelText: 'Item Barcode'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: _scanBarcode,
                ),
              ],
            ),
            TextField(
              controller: _photoController,
              decoration: const InputDecoration(labelText: 'Item Photo URL'),
            ),
            Row(
              children: [
                _image == null
                    ? const Text('No image selected.')
                    : Image.file(
                        _image!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                IconButton(
                  icon: const Icon(Icons.photo_library),
                  onPressed: () => _pickImage(ImageSource.gallery),
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: () => _pickImage(ImageSource.camera),
                ),
              ],
            ),
            TextField(
              controller: _floornoController,
              decoration: const InputDecoration(labelText: 'Floor Number'),
            ),
            TextField(
              controller: _sectionnoController,
              decoration: const InputDecoration(labelText: 'Section Number'),
            ),
            TextField(
              controller: _rownoController,
              decoration: const InputDecoration(labelText: 'Row Number'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addItem,
              child: const Text('Add Item'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('items').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var doc = snapshot.data!.docs[index];
                      var item = doc.data() as Map<String, dynamic>;

                      return ListTile(
                        leading: item['photo'].startsWith('http')
                            ? Image.network(
                                item['photo'],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(item['photo']),
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                        title: Text(item['name']),
                        subtitle: Text('₹${item['price']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _nameController.text = item['name'];
                                _priceController.text =
                                    item['price'].toString();
                                _barcodeController.text = item['barcode'];
                                _photoController.text = item['photo'];
                                _floornoController.text = item['floorno'];
                                _sectionnoController.text = item['sectionno'];
                                _rownoController.text = item['rowno'];
                                _updateItem(doc.id);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _deleteItem(doc.id);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
