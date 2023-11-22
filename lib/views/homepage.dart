import 'package:flutter/material.dart';
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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('wicca'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProductCard(
              title: 'childern suit',
              description: 'nice suit for girle childern.',
              price: 19.99,
              imageProvider: AssetImage('images/1.png'),
            ),
            ProductCard(
              title: 'GenZ shirt',
              description: 'awesome t-shirt for local brand.',
              price: 29.99,
              imageProvider: AssetImage('images/2.png'),
            ),
            ProductCard(
              title: 'red chose',
              description: 'Famous brand.',
              price: 39.99,
              imageProvider: AssetImage('images/6.png'),
            ),
          ],
        ),
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
