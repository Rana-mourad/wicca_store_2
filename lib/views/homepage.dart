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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, _) {
              currentPosition = index;
              setState(() {});
            },
            height: 150,
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
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: product.imageProvider,
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(height: 8),
                      Text(product.description),
                      SizedBox(height: 8),
                      Text('Price: \$${product.price}'),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          context.read<CartProvider>().addToCart(
                                product.title,
                                product.price,
                              );
                        },
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
          ),
        ),
      ],
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
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: imageProvider,
              height: 100,
              width: 100,
            ),
            SizedBox(height: 8),
            Text(description),
            SizedBox(height: 8),
            Text('Price: \$$price'),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                context.read<CartProvider>().addToCart(title, price);
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
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
