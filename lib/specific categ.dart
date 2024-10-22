import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SpecificCategoryScreen extends StatefulWidget {
  final String categoryName;

  const SpecificCategoryScreen({Key? key, required this.categoryName})
      : super(key: key);

  @override
  _SpecificCategoryScreenState createState() => _SpecificCategoryScreenState();
}

class _SpecificCategoryScreenState extends State<SpecificCategoryScreen> {
  final Dio _dio = Dio();
  List _products = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  Future<void> fetchCategoryProducts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _dio.get(
          'https://fakestoreapi.com/products/category/${widget.categoryName}');
      setState(() {
        _products = response.data;
      });
    } catch (e) {
      print('Error fetching category products: $e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.categoryName} Products'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return ListTile(
                  title: Text(product['title']),
                  subtitle: Text('\$${product['price']}'),
                );
              },
            ),
    );
  }
}
