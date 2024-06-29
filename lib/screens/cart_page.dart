import 'package:bloc_flutter/screens/payment_screen.dart';
import 'package:flutter/material.dart';

//.
class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> get cartItems => widget.cartItems;

  void _updateQuantity(int index, int quantity) {
    setState(() {
      cartItems[index]['quantity'] = quantity;
    });
  }

  @override
  void initState() {
    super.initState();
    for (var item in cartItems) {
      item['quantity'] = item.containsKey('quantity') ? item['quantity'] : 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = cartItems.fold(
        0, (sum, item) => sum + (item['price'] * item['quantity']));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  leading: Image.network(item['photo']),
                  title: Text(item['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\$${item['price']}'),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              if (item['quantity'] > 1) {
                                _updateQuantity(index, item['quantity'] - 1);
                              }
                            },
                          ),
                          Text('${item['quantity']}'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              _updateQuantity(index, item['quantity'] + 1);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Text(
                      '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Total: \$${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PaymentPage(totalAmount: totalPrice)),
                    );
                  },
                  child: const Text('Proceed to Payment'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
