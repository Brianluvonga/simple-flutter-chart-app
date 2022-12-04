import 'package:chartapp/api/notifiers/user_notifier.dart';
import 'package:chartapp/api/user_api.dart';
import 'package:chartapp/components/constants/constants.dart';
import 'package:chartapp/components/models/user_model.dart';
import 'package:chartapp/screens/login_screen.dart';
import 'package:chartapp/screens/msg_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  UserModel user = UserModel();

  ColorConstants color = ColorConstants();
  FontSizeConstants size = FontSizeConstants();

  // push auth details to database

  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    initializeCurrentUser(authNotifier);
    super.initState();
  }

  Future<void> registerUserToApp() async {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      formKey.currentState!.save();
      AuthNotifier authNotifier =
          Provider.of<AuthNotifier>(context, listen: false);
      registerUser(user, authNotifier);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  Future<void> regUser() async {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      try {
        formKey.currentState!.save();

        AuthNotifier authNotifier =
            Provider.of<AuthNotifier>(context, listen: false);
        registerUser(user, authNotifier);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.red[600],
            content: const Text("Registration Successful", style: TextStyle()),
          ),
        );
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.black,
            content: Text(
                "Registration Not Successful, invalid credentials or poor internet connection"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Screen', style: size.sizeC),
        centerTitle: true,
        backgroundColor: color.colorD,
      ),
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
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
                    regBtn()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget username() {
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
          labelText: 'Username',
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelStyle: TextStyle(color: Colors.white),
        ),
        style: const TextStyle(
            fontSize: 11, color: Colors.white, fontFamily: 'times'),
        textCapitalization: TextCapitalization.none,
        keyboardType: TextInputType.name,
        // controller: usernameController,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        onSaved: (String? value) {
          user.username = value;
        },
      ),
    );
  }

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

  Widget regBtn() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        minWidth: 150,
        onPressed: () => registerUserToApp(),
        child: const Text(
          'Register',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
  }
}
