import 'package:flutter/material.dart';

class Category {
  String id;
  String title;
  String imageUrl;
  Color color;

  Category(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.color});

  static List<Category> getCategory(){
    return [
      Category(id: 'sports', title: 'Sports', imageUrl: 'assets/images/sports.png', color: Colors.red),
      Category(id: 'general', title: 'General', imageUrl: 'assets/images/Politics.png', color: Colors.blue),
      Category(id: 'health', title: 'Health', imageUrl: 'assets/images/health.png', color: Colors.pinkAccent),
      Category(id: 'business', title: 'Business', imageUrl: 'assets/images/bussines.png', color: Colors.orange),
      Category(id: 'entertainment', title: 'Environment', imageUrl: 'assets/images/environment.png', color: Colors.blueAccent),
      Category(id: 'science', title: 'Science', imageUrl: 'assets/images/science.png', color: Colors.yellow),

    ];
  }
}
