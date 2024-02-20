import 'package:adifoodapp/screen/cart_page.dart';
import 'package:adifoodapp/screen/home_page.dart';
import 'package:adifoodapp/screen/login_page.dart';
import 'package:adifoodapp/screen/widget/widgets.dart';
import 'package:adifoodapp/services/auth_service.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  String userName;
  String email;
  ProfilePage({Key? key, required this.email, required this.userName})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
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

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.apps,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
              color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),
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
                  accountName: Text(widget.userName),
                  accountEmail: Text(widget.email),
                ),
                drawerItem(
                    icon: Icons.person,
                    name: "Profile",
                    onTap: () {
                      nextScreenReplace(
                          context,
                          ProfilePage(
                            userName: widget.userName,
                            email: widget.email,
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 170),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Container(
                height: 200,
                width: 200,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Full Name", style: TextStyle(fontSize: 17)),
                Text(widget.userName, style: const TextStyle(fontSize: 17)),
              ],
            ),
            const Divider(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Email", style: TextStyle(fontSize: 17)),
                Text(widget.email, style: const TextStyle(fontSize: 17)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
