import 'package:chartapp/api/notifiers/user_notifier.dart';
import 'package:chartapp/api/user_api.dart';
import 'package:chartapp/components/constants/constants.dart';
import 'package:chartapp/components/models/user_model.dart';
import 'package:chartapp/screens/msg_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  UserModel user = UserModel();

  ColorConstants color = ColorConstants();
  FontSizeConstants size = FontSizeConstants();

  // push auth details to database

  Future<void> loginUser() async {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      try {
        formKey.currentState!.save();

        AuthNotifier authNotifier =
            Provider.of<AuthNotifier>(context, listen: false);
        signInUser(user, authNotifier);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Colors.white,
            content: Text("Login Successful", style: TextStyle()),
          ),
        );
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MessageScreen(),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.black,
            content: Text(
                "Login Not Successful, invalid credentials or poor internet connection"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen', style: size.sizeC),
        centerTitle: true,
        backgroundColor: color.colorD,
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: SizedBox(
            height: 400,
            child: Card(
              shadowColor: Colors.black,
              elevation: 8.0,
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 32, 0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    // username(),
                    // const SizedBox(
                    //   height: 30,
                    // ),
                    email(),
                    const SizedBox(
                      height: 20,
                    ),
                    password(),
                    const SizedBox(
                      height: 30,
                    ),
                    loginBtn()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget username() {
  //   return Container(
  //     width: 300,
  //     height: 50,
  //     child: TextFormField(
  //       decoration: const InputDecoration(
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(32.0)),
  //           borderSide: BorderSide(width: 1, color: Colors.white),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(32.0)),
  //           borderSide: BorderSide(width: 1, color: Colors.white),
  //         ),
  //         labelText: 'Username',
  //         contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
  //         labelStyle: TextStyle(color: Colors.white),
  //       ),
  //       style: const TextStyle(
  //           fontSize: 11, color: Colors.white, fontFamily: 'times'),
  //       textCapitalization: TextCapitalization.none,
  //       keyboardType: TextInputType.name,
  //       controller: usernameController,
  //       validator: (String? value) {
  //         if (value!.isEmpty) {
  //           return 'This field is required';
  //         }
  //         return null;
  //       },
  //       onSaved: (String? value) {
  //         user.username = value;
  //       },
  //     ),
  //   );
  // }

  Widget email() {
    return Container(
      width: 300,
      height: 50,
      child: TextFormField(
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          labelText: 'Email Address',
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelStyle: TextStyle(color: Colors.white),
        ),
        style: const TextStyle(
            fontSize: 11, color: Colors.white, fontFamily: 'times'),
        textCapitalization: TextCapitalization.none,
        keyboardType: TextInputType.name,
        controller: emailController,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Your Email Address is required';
          }
          if (!RegExp(
                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
              .hasMatch(value)) {
            return 'Please enter a valid email address';
          }

          return null;
        },
        onSaved: (String? value) {
          user.email = value!;
        },
      ),
    );
  }

  Widget password() {
    return Container(
      width: 300,
      height: 50,
      child: TextFormField(
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          labelText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelStyle: TextStyle(color: Colors.white),
        ),
        style: const TextStyle(
            fontSize: 11, color: Colors.white, fontFamily: 'times'),
        textCapitalization: TextCapitalization.none,
        keyboardType: TextInputType.name,
        cursorColor: Colors.white,
        controller: passController,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        obscureText: true,
        onSaved: (String? value) {
          user.password = value;
        },
      ),
    );
  }

  Widget loginBtn() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        minWidth: 150,
        onPressed: () => loginUser(),
        child: const Text(
          'Login',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
  }
}
