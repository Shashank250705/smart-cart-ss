import 'dart:async';
import 'dart:io';
import 'package:bloc_flutter/notification.dart';
import 'package:bloc_flutter/screens/item_search.dart';
import 'package:bloc_flutter/screens/my_drawer_header.dart';
import 'package:bloc_flutter/screens/pages/page1.dart';
import 'package:bloc_flutter/screens/pages/page2.dart';
import 'package:bloc_flutter/screens/pages/page3.dart';
import 'package:bloc_flutter/screens/pages/page4.dart';
import 'package:bloc_flutter/screens/product_details.dart';
import 'package:bloc_flutter/screens/welcome_page.dart';
import 'package:bloc_flutter/screens/wish_list_page.dart';
import 'package:bloc_flutter/view_all_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'cart_page.dart';

//homepage
class Homepage extends StatefulWidget {
  final DocumentSnapshot<Object?> userData;
  const Homepage({super.key, required this.userData});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final PageController _controller1 = PageController();
  //final PageController _controller2 = PageController();
  final PageController _controller3 = PageController();

  Timer? _timer;

  List<Map<String, dynamic>> cartItems = [];
  List<Map<String, dynamic>> wishlistItems = [];
  List<Map<String, dynamic>> items = [];
  static const int listViewLimit = 4;
  static const int gridViewLimit = 6;
  static const int smooth = 4;

  Future<void> fetchItems() async {
    final snapshot = await FirebaseFirestore.instance.collection('items').get();
    setState(() {
      items = snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchItems();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      int nextPage1 = _controller1.page!.round() + 1;
      if (nextPage1 >= 4) {
        nextPage1 = 0;
      }
      _controller1.animateToPage(
        nextPage1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller1.dispose();
    //_controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }
//Home Page Routing to Cart Page
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CartPage(cartItems: cartItems),
          ),
        );
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WishlistPage(
                wishlistItems: wishlistItems, cartItems: cartItems),
          ),
        );
      }
    });
  }

  Future<void> scanBarcode() async {
    try {
      var result = await BarcodeScanner.scan();
      if (result.type == ResultType.Barcode) {
        String barcode = result.rawContent;
        bool itemFound = false;
        setState(() {
          for (var cartItem in cartItems) {
            if (cartItem['barcode'] == barcode) {
              // Assuming you have a quantity field in cartItem
              cartItem['quantity'] = (cartItem['quantity'] ?? 1) + 1;
              itemFound = true;
              break;
            }
          }
          if (!itemFound) {
            for (var item in items) {
              if (item['barcode'] == barcode) {
                cartItems.add({
                  'barcode': item['barcode'],
                  'photo': item['photo'],
                  'name': item['name'],
                  'price': item['price'],
                  'quantity': 1, // Assuming you start with a quantity of 1
                });
                break;
              }
            }
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added to cart')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to get the barcode')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("Homepage"),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: scanBarcode,
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: ItemSearch(items));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300.0,
              width: 600,
              child: PageView(
                controller: _controller1,
                children: const <Widget>[
                  Page1(),
                  Page2(),
                  Page3(),
                  Page4(),
                ],
              ),
            ),
            const SizedBox(height: 4.0),
            SmoothPageIndicator(
              controller: _controller1,
              count: 4,
              effect: const ExpandingDotsEffect(
                dotHeight: 10.0,
                dotWidth: 10.0,
                activeDotColor: Colors.purple,
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 300.0,
              child: PageView(
                controller: _controller3,
                children: <Widget>[
                  for (var item in items)
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: item['photo'].startsWith('http')
                                ? Image.network(
                                    item['photo'],

                                    //height: 50,
                                    fit: BoxFit.fitHeight,
                                    width: double.infinity,
                                  )
                                : Image.file(
                                    File(item['photo']),

                                    width: double.infinity,
                                    //height: 50,
                                    fit: BoxFit.fitHeight,
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  item['name'],
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  '₹${item['price']}',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                      icon: const Icon(Icons.shopping_cart),
                                      onPressed: () {
                                        setState(() {
                                          cartItems.add(item);
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Product added to cart')),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.favorite),
                                      onPressed: () {
                                        setState(() {
                                          wishlistItems.add(item);
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Product added to wishlist')),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            SmoothPageIndicator(
              controller: _controller3,
              count: items.take(smooth).length,
              effect: const ExpandingDotsEffect(
                dotHeight: 10.0,
                dotWidth: 10.0,
                activeDotColor: Colors.purple,
              ),
            ),
            const SizedBox(height: 16.0),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: items.take(gridViewLimit).length,
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
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: item['photo'].startsWith('http')
                              ? Image.network(
                                  item['photo'],

                                  //height: 50,
                                  fit: BoxFit.fitHeight,
                                  width: double.infinity,
                                )
                              : Image.file(
                                  File(item['photo']),

                                  width: double.infinity,
                                  //height: 50,
                                  fit: BoxFit.fitHeight,
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                item['name'],
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                '₹${item['price']}',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    icon: Lottie.asset(
                                      'asset/animations/addtocart.json',
                                      width: 24,
                                      height: 24,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        cartItems.add(item);
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Product added to cart')),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Lottie.asset(
                                      'asset/animations/wishlist.json',
                                      width: 24,
                                      height: 24,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        wishlistItems.add(item);
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Product added to wishlist')),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TRENDING',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ViewAllPage()),
                      );
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4.0),
            SizedBox(
              height: 300.0,
              //width: 00.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.take(listViewLimit).length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = items[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailsPage(product: item),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 300.0,
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16.0),
                                ),
                                child: item['photo'].startsWith('http')
                                    ? Image.network(
                                        items[index]['photo'],
                                        height: 150,
                                        fit: BoxFit.fitHeight,
                                        width: double.infinity,
                                      )
                                    : Image.file(
                                        File(items[index]['photo']),
                                        width: double.infinity,
                                        height: 150,
                                        fit: BoxFit.fitHeight,
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      items[index]['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    //const SizedBox(height: 1.0),
                                    Text(
                                      '\₹ ${items[index]['price'].toString()}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        color: Colors.purple,
                                      ),
                                    ),
                                    //const SizedBox(height: 8.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Lottie.asset(
                                            'asset/animations/addtocart.json',
                                            width: 24,
                                            height: 24,
                                          ),
                                          onPressed: () {
                                            // Implement add to cart functionality
                                            setState(() {
                                              cartItems.add(items[index]);
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text('Added to Cart'),
                                              ),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: Lottie.asset(
                                            'asset/animations/wishlist.json',
                                            width: 24,
                                            height: 24,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              wishlistItems.add(items[index]);
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Product added to wishlist')),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Lottie.asset(
              'asset/animations/home.json',
              width: 24,
              height: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Lottie.asset(
              'asset/animations/addtocart.json',
              width: 24,
              height: 24,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Lottie.asset(
              'asset/animations/wishlist.json',
              width: 24,
              height: 24,
            ),
            label: 'WishList',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<User?>(
                future: Future.value(FirebaseAuth.instance.currentUser),
                builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return const Center(child: Text('No user is logged in'));
                  } else {
                    final User? user = snapshot.data;
                    return user != null
                        ? MyHeaderDrawer(userId: user.uid)
                        : const Center(child: Text('No user is logged in'));
                  }
                },
              ),
              const MyDrawerList(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyDrawerList extends StatelessWidget {
  const MyDrawerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          menuItem(
            'asset/animations/home.json',
            'Home',
            () {
              // Handle Home press
            },
          ),
          menuItem(
            'asset/animations/notification.json',
            'Notifications',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationScreen()),
              );
            },
          ),
          InkWell(
            /*onTap: () {
              // Perform sign out logic
              FirebaseAuth.instance.signOut();
              // Navigate to WelcomeScreen and remove all previous routs
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                (Route<dynamic> route) =>
                    false, // Remove all routes from the stack
              );
            },**/
            child: menuItem(
              'asset/animations/signout.json',
              'Sign Out',
              () {
                onTap() {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomeScreen()),
                    (Route<dynamic> route) => false,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget menuItem(String lottieUrl, String title, VoidCallback onTap) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Lottie.asset(
                lottieUrl,
                width: 30,
                height: 30,
              ),
              const SizedBox(width: 20.0),
              Text(
                title,
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
