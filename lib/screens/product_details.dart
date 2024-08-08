import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//product details
class ProductDetailsPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Widget _buildProductImage() {
    if (_image != null) {
      return Image.file(
        _image!,
        height: 300,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else if (widget.product['photo'] != null) {
      return widget.product['photo'].startsWith('http')
          ? Image.network(
              widget.product['photo'],
              width: double.infinity,
              height: 400,
              fit: BoxFit.fitHeight,
            )
          : Image.file(
              File(widget.product['photo']),
              width: double.infinity,
              height: 400,
              fit: BoxFit.fitHeight,
            );
    } else {
      return const Icon(
        Icons.image,
        size: 150,
        color: Colors.grey,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product['name']),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                _pickImage(ImageSource.gallery);
                // Change to ImageSource.camera for camera
              },
              child: _buildProductImage(),
            ),
            const SizedBox(height: 16.0),
            Text(
              widget.product['name'],
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              '₹${widget.product['price']}',
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Floor no: ${widget.product['floorno']}',
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Section no: ${widget.product['sectionno']}',
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Row no: ${widget.product['rowno']}',
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.grey,
              ),
            ),
            // Add more product details here as needed
          ],
        ),
      ),
    );
  }
}
