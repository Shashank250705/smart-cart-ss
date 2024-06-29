/*import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget {
  final List<Map<String, dynamic>> wishlistItems;

  const WishlistPage({Key? key, required this.wishlistItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: ListView.builder(
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          final item = wishlistItems[index];
          return ListTile(
            leading: Image.network(
              item['photo'],
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            title: Text(item['name']),
            subtitle: Text('\$${item['price']}'),
          );
        },
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget {
  final List<Map<String, dynamic>> wishlistItems;

  const WishlistPage({super.key, required this.wishlistItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: ListView.builder(
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(
              wishlistItems[index]['photo'],
              fit: BoxFit.cover,
              width: 50,
              height: 50,
            ),
            title: Text(wishlistItems[index]['name']),
            subtitle:
                Text('\$${wishlistItems[index]['price'].toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}
//.