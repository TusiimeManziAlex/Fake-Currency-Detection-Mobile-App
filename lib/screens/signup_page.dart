import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  late String firstname,secondname,email,password, confirmpassword;
  // form key for validating
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  // editting the controllers
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();

  // Boolean variable for CircularProgressIndicator.
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    // first name field
    final firstnameField = TextFormField(
      autofocus: false,
      controller: firstnameController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'First name',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
      ),
      validator: (value){
        if(value!.isEmpty)
        {
          return 'Please Enter Name';
        }
        return null;
      },
    );
    // last name field
    final lastnameField = TextFormField(
      autofocus: false,
      controller: lastnameController,
      // validator: (value){},
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Second name',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
      ),
      validator: (value){
        if(value!.isEmpty)
        {
          return 'Please Enter Second Name';
        }
        return null;
      },
    );
    // email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
      validator: (value){
        if(value!.isEmpty)
        {
          return 'Please Enter your email';
        }
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
          return 'Please Enter a valid Email';
        }
        return null;
      },
    );
    //password field
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        if (value.trim().length < 8) {
          return 'Password must be at least 8 characters in length';
        }
        // Return null if the entered password is valid
        return null;
      },
      onChanged: (value) => password = value,
    );
    //comfirm password field
    final comfirmpasswordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: confirmpasswordController,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Comfirm Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        if (value != password) {
          return 'Passwords do not match the entered password';
        }
        // Return null if the entered password is valid
        return null;
      },
      onChanged: (value) => confirmpassword = value,
    );
    // Reset Password button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        onPressed: () async {
          if(_formkey.currentState!.validate()) {
            try {
              await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);

              // show this pop up message to the user
              Fluttertoast.showToast(msg: "Account created successfully",
                  gravity: ToastGravity.CENTER, toastLength: Toast.LENGTH_LONG);

              //Success
              Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginPage()));
            } on FirebaseAuthException catch (error){
              Fluttertoast.showToast(msg: error.message ?? "Something went wrong",
                gravity: ToastGravity.TOP,toastLength: Toast.LENGTH_LONG,backgroundColor: Colors.white, textColor: Colors.red,

              );
            }
          }
        },
        child: Text(
          'Sign Up',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            //passing this to the root
            Navigator.of(context).pop();
          },
        ),
        title: Text('Create an account'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.teal,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage('assets/images/logo.png'),
                          radius: 28,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      firstnameField,
                      SizedBox(
                        height: 25,
                      ),
                      lastnameField,
                      SizedBox(
                        height: 25,
                      ),
                      emailField,
                      SizedBox(
                        height: 25,
                      ),
                      passwordField,
                      SizedBox(
                        height: 35,
                      ),
                      comfirmpasswordField,
                      SizedBox(
                        height: 25,
                      ),
                      signUpButton,
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Have an account already! "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()
                                  )
                              );
                            },
                            child: Text(
                              "Click here",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}


