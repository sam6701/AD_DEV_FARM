import 'package:flutter/material.dart';

class BottomContainer extends StatelessWidget {
  final String image;
  final String name;
  final int price;
  final Function()? onTap;
  BottomContainer(
      {required this.onTap,
      required this.image,
      required this.price,
      required this.name});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 270,
        width: 220,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 201, 198, 198),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(image),
            ),
            ListTile(
              leading: Text(
                name,
                style: TextStyle(fontSize: 15, color: Colors.green),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$ $price",
                        style: TextStyle(fontSize: 20, color: Colors.green),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 20,
                            color: Colors.green,
                          ),
                          Icon(
                            Icons.star,
                            size: 20,
                            color: Colors.green,
                          ),
                          Icon(
                            Icons.star,
                            size: 20,
                            color: Colors.green,
                          ),
                          Icon(
                            Icons.star,
                            size: 20,
                            color: Colors.green,
                          ),
                          Icon(
                            Icons.star,
                            size: 20,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ]))
          ],
        ),
      ),
    );
  }
}
