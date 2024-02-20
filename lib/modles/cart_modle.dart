import 'package:flutter/cupertino.dart';

class CartModle {
  final String image;
  final String name;
  final String id;
  final int price;
  final int quantity;

  CartModle({
    required this.image,
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });
}
