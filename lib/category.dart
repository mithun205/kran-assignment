import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'specific categ.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final Dio _dio = Dio();
  List _categories = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response =
          await _dio.get('https://fakestoreapi.com/products/categories');
      setState(() {
        _categories = response.data;
      });
    } catch (e) {
      print('Error fetching categories: $e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return ListTile(
                  title: Text(category),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SpecificCategoryScreen(categoryName: category),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
