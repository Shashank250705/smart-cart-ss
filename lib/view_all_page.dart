import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bloc_flutter/screens/product_details.dart';
import 'package:bloc_flutter/screens/item_search.dart';

//viewpage
class ViewAllPage extends StatefulWidget {
  const ViewAllPage({super.key});

  @override
  _ViewAllPageState createState() => _ViewAllPageState();
}

class _ViewAllPageState extends State<ViewAllPage> {
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    final snapshot = await FirebaseFirestore.instance.collection('items').get();
    setState(() {
      items = snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("All products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: ItemSearch(items));
            },
          ),
        ],
      ),
      body: items.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(product: item),
                      ),
                    );
                  },
                  child: GridTile(
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(item['name'] ?? 'Unknown'),
                      subtitle: Text('₹${item['price']?.toString() ?? '0.0'}'),
                    ),
                    child: item['photo'].startsWith('http')
                        ? _buildNetworkImage(item['photo'])
                        : _buildLocalImage(item['photo']),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildNetworkImage(String url) {
    return Image.network(
      url,
      width: double.infinity,
      fit: BoxFit.fitHeight,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.image);
      },
    );
  }

  Widget _buildLocalImage(String filePath) {
    return Image.file(
      File(filePath),
      width: double.infinity,
      fit: BoxFit.fitHeight,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.image);
      },
    );
  }
}
