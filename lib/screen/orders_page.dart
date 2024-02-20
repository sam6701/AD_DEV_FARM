import 'package:adifoodapp/screen/widget/widgets.dart';
import 'package:adifoodapp/services/auth_service.dart';
import 'package:adifoodapp/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adifoodapp/provider/my_provider.dart';
import 'package:adifoodapp/screen/home_page.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget cartItem(
      {required String image,
      required String name,
      required int price,
      required Function()? onTap,
      required int quantity,
      required int total}) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.black12),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20),
              width: 100,
              height: 100,
              child: CircleAvatar(
                backgroundImage: NetworkImage(image),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  height: 200,
                  padding: EdgeInsets.only(right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "price:"
                            "$price",
                            style: TextStyle(fontSize: 20, color: Colors.green),
                          ),
                          Text(
                            "quantity:"
                            "$quantity",
                            style: TextStyle(fontSize: 20, color: Colors.green),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: onTap,
                )
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    int total = provider.totalprice();
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 12, 235, 20),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 65,
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$ $total",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            InkWell(
              onTap: () {
                provider.deleteAll();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                  border: Border.all(color: Colors.white, width: 1),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text(
                  "pay",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Cart",
          style: TextStyle(
              color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              provider.getCartFromFirestore();
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: provider.cartList.length,
        itemBuilder: (ctx, index) {
          provider.getDeleteIndex(index);
          return cartItem(
            onTap: () {
              try {
                print('harsh: try ${provider.cartList[index]}');
                final FirebaseAuth auth = FirebaseAuth.instance;
                DatabaseService(uid: auth.currentUser!.uid)
                    .deletingUserDataInCart(provider.cartList[index].id,
                        provider.cartList[index].quantity);
                provider.delete();
              } catch (e) {
                print('harsh: error $e');
              }
            },
            image: provider.cartList[index].image,
            name: provider.cartList[index].name,
            price: provider.cartList[index].price,
            quantity: provider.cartList[index].quantity,
            total: provider.totalprice(),
          );
        },
      ),
    );
  }
}