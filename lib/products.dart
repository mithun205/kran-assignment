import 'package:flutter/material.dart';
import 'package:flutter_application_1/single%20product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductScreen extends StatefulWidget {
  final String token;
  ProductScreen({required this.token});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List products = [];
  List categories = [];
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _fetchCategories();
  }

  Future<void> _fetchProducts() async {
    final response = await http.get(
      selectedCategory == null
          ? Uri.parse('https://fakestoreapi.com/products')
          : Uri.parse(
              'https://fakestoreapi.com/products/category/$selectedCategory'),
    );
    if (response.statusCode == 200) {
      setState(() {
        products = jsonDecode(response.body);
      });
    }
  }

  Future<void> _fetchCategories() async {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/categories'));
    if (response.statusCode == 200) {
      setState(() {
        categories = List<String>.from(jsonDecode(response.body));
      });
    }
  }

  void _selectCategory(String category) {
    setState(() {
      selectedCategory = category;
      _fetchProducts();
      Navigator.pop(context); // Close drawer
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        backgroundColor: Colors.blue[200],
      ),
      drawer: Drawer(
        backgroundColor: Colors.blue[50],
        child: ListView(
          children: [
            DrawerHeader(
                child: Text(
              'Categories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            for (var category in categories)
              ListTile(
                title: Text(category),
                onTap: () => _selectCategory(category),
              ),
          ],
        ),
      ),
      body: products.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.blue[50],
                    child: ListTile(
                      title: Text(products[index]['title']),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            productId: products[index]['id'],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
