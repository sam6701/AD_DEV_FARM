import 'package:adifoodapp/helper/helper_function.dart';
import 'package:adifoodapp/screen/cart_page.dart';
import 'package:adifoodapp/screen/login_page.dart';
import 'package:adifoodapp/screen/search_page.dart';
import 'package:adifoodapp/screen/widget/widgets.dart';
import 'package:adifoodapp/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:adifoodapp/provider/my_provider.dart';
import 'package:adifoodapp/screen/categories.dart';
import 'package:adifoodapp/screen/detail_page.dart';
import 'package:provider/provider.dart';
import 'package:adifoodapp/modles/categories_modle.dart';
import 'package:adifoodapp/modles/food_categories_modle.dart';
import 'package:adifoodapp/modles/food_modle.dart';
import 'widget/bottom_container.dart';
import 'package:adifoodapp/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adifoodapp/screen/profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  QuerySnapshot? completeSnapshot;
  List<FoodModle> singleFoodList = [];
  String userName = "";
  String email = "";
  AuthService authService = AuthService();
  Stream? groups;
  bool _isLoading = false;
  String groupName = "";

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  // string manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    await HelperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameFromSF().then((val) {
      setState(() {
        userName = val!;
      });
    });
    // getting the list of snapshots in our stream
    /*await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });*/
  }

  Widget drawerItem(
      {required String name, required IconData icon, required onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.green,
      ),
      title: Text(
        name,
        style: TextStyle(fontSize: 20, color: Colors.green),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    provider.getFoodList();
    singleFoodList = provider.throwFoodModleList;
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 20, 255, 28),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                  accountName: Text(userName),
                  accountEmail: Text(email),
                ),
                drawerItem(
                    icon: Icons.person,
                    name: "Profile",
                    onTap: () {
                      nextScreenReplace(
                          context,
                          ProfilePage(
                            userName: userName,
                            email: email,
                          ));
                    }),
                drawerItem(
                    icon: Icons.add_shopping_cart,
                    name: "Cart",
                    onTap: () {
                      nextScreen(context, CartPage());
                    }),
                drawerItem(icon: Icons.shop, name: "Order", onTap: () {}),
                drawerItem(
                    icon: Icons.home_rounded,
                    name: "Home",
                    onTap: () {
                      nextScreen(context, HomePage());
                    }),
                ListTile(
                  leading: Text(
                    "Settings",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                    ),
                  ),
                ),
                Divider(
                  thickness: 2,
                  color: Colors.green,
                ),
                drawerItem(
                    icon: Icons.exit_to_app,
                    name: "Log Out",
                    onTap: () async {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Logout"),
                              content: const Text(
                                  "Are you sure you want to logout?"),
                              actions: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await authService.signOut();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                        (route) => false);
                                  },
                                  icon: const Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            );
                          });
                    }),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        leading: Icon(
          Icons.apps,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
        actions: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Search Food",
                    hintStyle: TextStyle(color: Colors.green),
                    prefixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        nextScreen(context, const SearchPage());
                      },
                    ),
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.only(left: 1),
              child: Container(
                child: Text(
                  'All Foods',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 30, color: Colors.green),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 510,
                width: double.infinity,
                child: GridView.count(
                    shrinkWrap: false,
                    primary: false,
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: singleFoodList
                        .map(
                          (e) => BottomContainer(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                      image: e.image,
                                      name: e.name,
                                      price: e.price,
                                      categories: e.categories,
                                      description: e.description,
                                      id: e.id),
                                ),
                              );
                            },
                            image: e.image,
                            price: e.price,
                            name: e.name,
                          ),
                        )
                        .toList())
                /* GridView.count(
                shrinkWrap: false,
                primary: false,
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children:,
                ),

        ),*/
                ), /*GridView.count(
                shrinkWrap: false,
                primary: false,
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: singleFoodList
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
                              ),
                            ),
                          );
                        },
                        image: e.image,
                        price: e.price,
                        name: e.name,
                      ),
                    )
                    .toList()
                
                ),*/
          ],
        ),
      ),
    );
  }
}
