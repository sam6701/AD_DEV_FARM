import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'widget/mytext_field.dart';
import 'package:adifoodapp/helper/helper_function.dart';
import 'package:adifoodapp/screen/home_page.dart';
import 'package:adifoodapp/services/auth_service.dart';
import 'widget/widgets.dart';
import 'package:adifoodapp/screen/login_page.dart';
import 'package:adifoodapp/screen/welcome_page.dart';

class SignUp extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  late UserCredential userCredential;
  RegExp regExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  /*TextEditingController fullName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();*/
  String email = "";
  String password = "";
  String fullName = "";
  AuthService authService = AuthService();
  /*GlobalKey<ScaffoldMessengerState> globalKey =
      GlobalKey<ScaffoldMessengerState>();*/
  final globalKey = GlobalKey<FormState>();
  /*Future sendData() async {
    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      await FirebaseFirestore.instance
          .collection('userData')
          .doc(userCredential.user!.uid)
          .set({
        "firstName": firstName.text.trim(),
        "lastName": lastName.text.trim(),
        "email": email.text.trim(),
        "userid": userCredential.user!.uid,
        "password": password.text.trim(),
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        globalKey.currentState!.showSnackBar(
          SnackBar(
            content: Text("The password provided is too weak."),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        globalKey.currentState!.showSnackBar(
          SnackBar(
            content: Text("The account already exists for that email"),
          ),
        );
      }
    } catch (e) {
      globalKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('${["e"]}'),
        ),
      );
      setState(() {
        loading = false;
      });
    }
    setState(() {
      loading = false;
    });
  }*/
  register() async {
    if (globalKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      await authService
          .registerUserWithEmailandPassword(fullName, email, password)
          .then((value) async {
        if (value == true) {
          // saving the shared preference state
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(fullName);
          nextScreenReplace(context, HomePage());
        } else {
          showSnackbar(context, value);
          setState(() {
            loading = false;
          });
        }
      });
    }
  }
  /*void validation() {
    if (fullName.text.trim().isEmpty) {
      showSnackbar(context,"enter the First name");
      
    }
    if (email.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("enter the Email")));
      return;
    } else if (!regExp.hasMatch(email.text)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please enter vaild Email")));
      return;
    }
    if (password.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please enter the passsword more then 6 digit")));
      return;
    } else {
      setState(() {
        loading = true;
      });
      //sendData();
    }
  }*/

  Widget button(
      {required String buttonName,
      required Color color,
      required Color textColor,
      required Function()? ontap}) {
    return Container(
      width: 120,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        onPressed: ontap,
        child: Text(
          buttonName,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: globalKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.green,
            ),
            onPressed: () {
              nextScreen(context, WelcomePage());
            }),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(color: Colors.green),
            )
          : SingleChildScrollView(
              child: Form(
                key: globalKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /*Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),*/
                      Container(
                        child: Center(
                          child: Image.asset('assets/images/front_logo.png'),
                        ),
                      ),
                      Container(
                        height: 80,
                      ),
                      Container(
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  labelText: "Full Name",
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.green,
                                  )),
                              onChanged: (val) {
                                setState(() {
                                  fullName = val;
                                });
                              },
                              validator: (val) {
                                if (val!.isNotEmpty) {
                                  return null;
                                } else {
                                  return "Name cannot be empty";
                                }
                              },
                            ),
                            Container(
                              height: 5,
                            ),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  labelText: "Email",
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.green,
                                  )),
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
                              // check tha validation
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val!)
                                    ? null
                                    : "Please enter a valid email";
                              },
                            ),
                            Container(
                              height: 5,
                            ),
                            TextFormField(
                              obscureText: true,
                              decoration: textInputDecoration.copyWith(
                                  labelText: "Password",
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.green,
                                  )),
                              validator: (val) {
                                if (val!.length < 6) {
                                  return "Password must be at least 6 characters";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                            ),
                            /*MyTextField(
                            controller: fullName,
                            obscureText: false,
                            hintText: 'fistName',
                          ),
                          MyTextField(
                            controller: email,
                            obscureText: false,
                            hintText: 'Email',
                          ),
                          MyTextField(
                            controller: password,
                            obscureText: true,
                            hintText: 'password',
                          )*/
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          button(
                            ontap: () {},
                            buttonName: "Canel",
                            color: Colors.grey,
                            textColor: Colors.black,
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          button(
                            ontap: () {
                              register(); //validation();
                            },
                            buttonName: "Register",
                            color: Colors.red,
                            textColor: Colors.black,
                          ),
                        ],
                      ),
                      Container(
                        height: 15,
                      ),
                      Center(
                        child: Text.rich(TextSpan(
                          text: "Already have an account? ",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Login now",
                                style: const TextStyle(
                                    color: Colors.red,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    nextScreen(context, LoginPage());
                                  }),
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
