import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wicca',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wicca Store'),
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to the cart page
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (index, _) {
                currentPosition = index;
                setState(() {});
              },
              height: 200,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            ),
            items: [
              ProductCard(
                title: 'Special Offer',
                description: 'Limited time offer!',
                price: 49.99,
                imageProvider: AssetImage('images/1.png'),
              ),
              ProductCard(
                title: 'New Arrivals',
                description: 'Explore our latest products.',
                price: 39.99,
                imageProvider: AssetImage('images/2.png'),
              ),
              ProductCard(
                title: 'Best Sellers',
                description: 'Discover our top-selling items.',
                price: 59.99,
                imageProvider: AssetImage('images/3.png'),
              ),
              ProductCard(
                title: 'Fashion Collection',
                description: 'Trendy styles for every occasion.',
                price: 69.99,
                imageProvider: AssetImage('images/1.png'),
              ),
              ProductCard(
                title: 'Holiday Deals',
                description: 'Celebrate with our special offers.',
                price: 79.99,
                imageProvider: AssetImage('images/6.png'),
              ),
            ].map((product) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image(
                            image: product.imageProvider,
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          product.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          product.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Price: \$${product.price}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                        SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            context.read<CartProvider>().addToCart(
                                  product.title,
                                  product.price,
                                );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                          ),
                          child: Text('Add to Cart'),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
          DotsIndicator(
            dotsCount: 5,
            position: currentPosition,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              activeColor: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String description;
  final double price;
  final ImageProvider<Object> imageProvider;

  ProductCard({
    required this.title,
    required this.description,
    required this.price,
    required this.imageProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
    // Implement the content of the ProductCard if needed
  }
}

class CartProvider with ChangeNotifier {
  List<String> _cartItems = [];

  List<String> get cartItems => _cartItems;

  void addToCart(String itemName, double itemPrice) {
    _cartItems.add('$itemName - \$$itemPrice');
    notifyListeners();
  }
}
