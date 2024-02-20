import 'package:flutter/cupertino.dart';

class FoodModle {
  final String image;
  final String name;
  final int price;
  final String description;
  final String categories;
  final String id;
  FoodModle(
      {required this.image,
      required this.name,
      required this.price,
      required this.categories,
      required this.description,
      required this.id});
}
