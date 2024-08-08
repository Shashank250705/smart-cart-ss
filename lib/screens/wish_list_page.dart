import 'dart:io';

import 'package:flutter/material.dart';

//wishlist page
class WishlistPage extends StatefulWidget {
  final List<Map<String, dynamic>> wishlistItems;
  final List<Map<String, dynamic>> cartItems;

  const WishlistPage({
    super.key,
    required this.wishlistItems,
    required this.cartItems,
  });

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  void moveToCart(Map<String, dynamic> item) {
    setState(() {
      widget.cartItems.add(item);
      widget.wishlistItems.remove(item);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item moved to cart')),
    );
  }

  void removeFromWishlist(Map<String, dynamic> item) {
    setState(() {
      widget.wishlistItems.remove(item);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item removed from wishlist')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: widget.wishlistItems.isEmpty
          ? const Center(child: Text('Your wishlist is empty'))
          : ListView.builder(
              itemCount: widget.wishlistItems.length,
              itemBuilder: (context, index) {
                final item = widget.wishlistItems[index];
                return ListTile(
                  leading: item['photo'].startsWith('http')
                      ? Image.network(
                          item['photo'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.fitHeight,
                        )
                      : Image.file(
                          File(item['photo']),
                          width: 50,
                          height: 50,
                          fit: BoxFit.fitHeight,
                        ),
                  title: Text(item['name']),
                  subtitle: Text('₹${item['price'].toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => moveToCart(item),
                        icon: const Icon(Icons.shopping_cart),
                      ),
                      IconButton(
                        onPressed: () => removeFromWishlist(item),
                        icon: const Icon(Icons.remove_circle),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
