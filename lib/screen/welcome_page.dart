import 'package:adifoodapp/screen/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:adifoodapp/screen/login_page.dart';
import 'package:adifoodapp/screen/sign_up.dart';

class WelcomePage extends StatelessWidget {
  Widget button(
      {required String name,
      required Color color,
      required Color textColor,
      required dynamic value,
      required dynamic context}) {
    return Container(
      height: 45,
      width: 300,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: BorderSide(color: Colors.green, width: 2),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        onPressed: () {
          nextScreen(context, value);
        },
        child: Text(
          name,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Image.asset('assets/images/front_logo.png'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Welcome To AD-DEV Farm",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Column(
                    children: [
                      Text("Nature's way of care"),
                    ],
                  ),
                  button(
                      name: 'Login',
                      color: Colors.green,
                      textColor: Colors.white,
                      context: context,
                      value: LoginPage()),
                  button(
                      name: 'SignUp',
                      color: Colors.white,
                      textColor: Colors.green,
                      context: context,
                      value: SignUp()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
