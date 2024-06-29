import 'dart:async';

import 'package:bloc_flutter/screens/ai_bot.dart';
import 'package:bloc_flutter/screens/my_drawer_header.dart';
import 'package:bloc_flutter/screens/pages/page1.dart';
import 'package:bloc_flutter/screens/pages/page2.dart';
import 'package:bloc_flutter/screens/pages/page3.dart';
import 'package:bloc_flutter/screens/pages/page4.dart';
import 'package:bloc_flutter/screens/wish_list_page.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'cart_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final PageController _controller1 = PageController();
  final PageController _controller2 = PageController();
  final PageController _controller3 = PageController();
  Timer? _timer;

  final List<Map<String, dynamic>> items = [
    {
      'barcode': '8901277011497',
      'photo':
          'https://imgs.search.brave.com/28UaY6-zkZE1eT1TGxHzenl0jTfjAN2jV7LD-A2ln2A/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly80Lmlt/aW1nLmNvbS9kYXRh/NC9FSC9JSi9BTkRS/T0lELTIwNjY0MDE1/L3Byb2R1Y3QtMTAw/MHgxMDAwLmpwZWc',
      'name': 'Park Avenue Deodorant',
      'price': 150.00,
    },
    {
      'barcode': '0806360623008',
      'photo':
          'https://imgs.search.brave.com/g3gxQrcvlNO0MK-EHV8pC8CEgh7NcDn-lrgsILMc5cs/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/MzE2czdINytaNEwu/anBn',
      'name': 'Whit glow loation',
      'price': 135.00,
    },
    //.
    {
      'photo':
          'https://imgs.search.brave.com/VXHNQuW-asIW6Qog0gd9B_hjRkneXnB2YJ4rT_GGi5o/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMTcz/MjQyNzUwL3Bob3Rv/L2JhbmFuYS1idW5j/aC5qcGc_cz02MTJ4/NjEyJnc9MCZrPTIw/JmM9TUFjOEFYVno1/S3h3V2VFbWg3NVd3/SDZqX0hvdVJjekJG/QWh1bExBdFJVVT0',
      'name': 'BANANA',
      'price': 29.99,
    },
    {
      'photo':
          'https://imgs.search.brave.com/6T9ebo_LZ3tRxAdcdKu4DU-RbkKLVYv_a6WTpzwMtdo/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvNDU1/MDQ5MzY3L3Bob3Rv/L2JyZWFkLXNsaWNl/cy5qcGc_cz02MTJ4/NjEyJnc9MCZrPTIw/JmM9Mnh4Y3ZaRnh6/T0NUc2NmdXo0My1L/T3BjTnp2MTJYeDFV/ZVMyNE1Pcng1Zz0',
      'name': 'bread',
      'price': 19.99,
    },
    {
      'photo':
          'https://imgs.search.brave.com/sUn59m48gAf7Kdp3Sm6ry6hcH2RPrfaXBcPWGR_5kNc/rs:fit:500:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzAwLzUzLzUxLzYy/LzM2MF9GXzUzNTE2/MjYxXzhaS2lrRDdF/V0FXYnl1bWhLRjRJ/eG1xTnVvYUxVb2tU/LmpwZw',
      'name': 'pea',
      'price': 49.99,
    },
    {
      'photo':
          'https://imgs.search.brave.com/M6u3m7J3bZymw167mdLJAzAFZ-O27sh3EqyczI_xxNg/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMudW5zcGxhc2gu/Y29tL3Bob3RvLTE1/MjM0NzM4Mjc1MzMt/MmE2NGQwZDM2NzQ4/P3E9ODAmdz0xMDAw/JmF1dG89Zm9ybWF0/JmZpdD1jcm9wJml4/bGliPXJiLTQuMC4z/Jml4aWQ9TTN3eE1q/QTNmREI4TUh4elpX/RnlZMmg4TVRGOGZH/MXBiR3Q4Wlc1OE1I/eDhNSHg4ZkRBPQ',
      'name': 'Milk',
      'price': 59.99,
    },
    {
      'photo':
          'https://imgs.search.brave.com/swvluGcCuyYD8EghhD5HJ25gmcM8-iXBvTS0CcKqISA/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvNTMx/MjA0NTUxL3Bob3Rv/L3RocmVlLWNhcnJv/dHMtaW4tYS1yb3cu/anBnP3M9NjEyeDYx/MiZ3PTAmaz0yMCZj/PUxfbmw3VnZjcW1r/emU5UXliYk1EeU9H/dTUyQUIyZ0xFWVJk/QUlTTVdEQ0E9',
      'name': 'Carrot',
      'price': 39.99,
    },
    {
      'photo':
          'https://imgs.search.brave.com/QBKZ0tFJulGvtoQpxi0nVZ513fiZ1yfAO4h_17YkEdU/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/ZnJlZS1waG90by9v/cmFuZ2UtanVpY2Vf/MjMtMjE0ODA3OTUz/NS5qcGc_c2l6ZT02/MjYmZXh0PWpwZw',
      'name': 'Orange juice',
      'price': 24.99,
    },
  ];

  List<Map<String, dynamic>> cartItems = [];
  List<Map<String, dynamic>> wishlistItems = [];

  @override
  void initState() {
    super.initState();
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
      int nextPage2 = _controller2.page!.round() + 1;
      if (nextPage2 >= 4) {
        nextPage2 = 0;
      }
      _controller2.animateToPage(
        nextPage2,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

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
            builder: (context) => WishlistPage(wishlistItems: wishlistItems),
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
        for (var item in items) {
          if (item['barcode'] == barcode) {
            setState(() {
              cartItems.add(item);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product added to cart')),
            );
            break;
          }
        }
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
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 200.0,
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
            const SizedBox(height: 4.0),
            SizedBox(
              height: 200,
              child: PageView(
                controller: _controller2,
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
              controller: _controller2,
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
                            child: Image.network(
                              item['photo'],
                              fit: BoxFit.cover,
                              width: double.infinity,
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
                                  '\$${item['price']}',
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
              count: items.length,
              effect: const ExpandingDotsEffect(
                dotHeight: 10.0,
                dotWidth: 10.0,
                activeDotColor: Colors.purple,
              ),
            ),
            const SizedBox(height: 16.0),
            /*const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Trending Items',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),*/
            GridView.builder(
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
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Image.network(
                          item['photo'],
                          fit: BoxFit.cover,
                          width: double.infinity,
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
                                    ScaffoldMessenger.of(context).showSnackBar(
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
                                    ScaffoldMessenger.of(context).showSnackBar(
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
                      // Implement action on button press
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
            const SizedBox(height: 10.0),
            SizedBox(
              height: 200.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 300.0,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16.0),
                              ),
                              child: Image.network(
                                items[index]['photo'],
                                height: 80.0,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                  const SizedBox(height: 1.0),
                                  Text(
                                    '\$ ${items[index]['price'].toString()}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                      color: Colors.purple,
                                    ),
                                  ),
                                  //const SizedBox(height: 8.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                          // Implement add to wishlist functionality
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text('Added to Wishlist'),
                                            ),
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
                  }),
            ),
          ],
        ),
      ),
      /*floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            left: 16.0,
            bottom: 30.0, // Adjust as needed
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatScreen()),
                );
              },
              child: Lottie.asset(
                'asset/animations/ai_bot.json',
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),*/
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
              'asset/animations/profile.json',
              width: 24,
              height: 24,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
      ),
      drawer: const Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyHeaderDrawer(),
              MyDrawerList(),
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
            'asset/animations/addtocart.json',
            'Cart',
            () {
              // Handle Cart press
            },
          ),
          menuItem(
            'asset/animations/info.json',
            'About us',
            () {
              // Handle Profile press
            },
          ),
          menuItem(
            'asset/animations/settings.json',
            'Settings',
            () {
              // Handle Profile press
            },
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
                width: 24,
                height: 24,
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
