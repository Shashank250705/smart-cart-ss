import 'package:flutter/material.dart';

class WishlistPage extends StatefulWidget {
  final List<Map<String, dynamic>> wishlistItems;
  final List<Map<String, dynamic>> cartItems;

  const WishlistPage(
      {super.key, required this.wishlistItems, required this.cartItems});

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
                  leading: Image.network(
                    item['photo'],
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item['name']),
                  subtitle: Text('\$${item['price'].toStringAsFixed(2)}'),
                  trailing: ElevatedButton(
                    onPressed: () => moveToCart(item),
                    child: const Text('Move to Cart'),
                  ),
                );
              },
            ),
    );
  }
}



/*import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget {
  final List<Map<String, dynamic>> wishlistItems;
  final List<Map<String, dynamic>> cartItems;

  const WishlistPage(
      {super.key, required this.wishlistItems, required this.cartItems});

  void moveToCart(BuildContext context, Map<String, dynamic> item) {
    // Add item to cart
    cartItems.add(item);
    // Remove item from wishlist
    wishlistItems.remove(item);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item moved to cart')),
    );

    // Refresh the page
    (context as Element).markNeedsBuild();
  }

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
            subtitle: Text('\$${item['price'].toStringAsFixed(2)}'),
            trailing: ElevatedButton(
              onPressed: () => moveToCart(context, item),
              child: const Text('Move to Cart'),
            ),
          );
        },
      ),
    );
  }
}*/