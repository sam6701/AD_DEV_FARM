import 'package:flutter/material.dart';
import 'package:adifoodapp/screen/detail_page.dart';
import 'package:adifoodapp/modles/food_categories_modle.dart';
import 'package:adifoodapp/screen/home_page.dart';
import 'widget/bottom_container.dart';

class Categories extends StatelessWidget {
  List<FoodCategoriesModle> list = [];
  Categories({required this.list});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (contet) => HomePage()));
          },
        ),
      ),
      body: GridView.count(
          shrinkWrap: false,
          primary: false,
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: list
              .map(
                (e) => BottomContainer(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                            image: e.image,
                            name: e.name,
                            price: e.price,
                            categories: e.name,
                            description: e.name,
                            id: e.id),
                      ),
                    );
                  },
                  image: e.image,
                  price: e.price,
                  name: e.name,
                ),
              )
              .toList()),
    );
  }
}
