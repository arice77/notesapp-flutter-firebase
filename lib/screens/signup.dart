import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:real_time_db/firebase_service.dart';
import 'package:real_time_db/screens/home_screen.dart';
import 'package:real_time_db/screens/shared_preference.dart';

class LoginScreen extends StatefulWidget {
  static const routeNmae = '/login-scren';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _passControler = TextEditingController();
  final UniqueKey _email = UniqueKey();
  final UniqueKey _pass = UniqueKey();
  bool _isLoading = false;

  bool _isSignUp = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_isSignUp)
                  TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'User Name', border: OutlineInputBorder())),
                TextFormField(
                    key: _email,
                    controller: _emailControler,
                    decoration: const InputDecoration(
                        hintText: 'Email', border: OutlineInputBorder())),
                TextFormField(
                  key: _pass,
                  controller: _passControler,
                  decoration: const InputDecoration(
                      hintText: 'Password', border: OutlineInputBorder()),
                ),
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isLoading = !_isLoading;
                          });
                          if (_isSignUp) {
                            FirestoreService()
                                .signUp(_emailControler.text,
                                    _passControler.text, context)
                                .then((value) {
                              setState(() {
                                _isLoading = !_isLoading;
                              });
                              if (value == true) {
                                SharedPreferenceService().setLoginStatus();
                                Navigator.of(context)
                                    .pushReplacementNamed(HomeScren.routeName);
                              }
                            });
                          } else {
                            FirestoreService()
                                .logIn(_emailControler.text,
                                    _passControler.text, context)
                                .then((value) {
                              setState(() {
                                _isLoading = !_isLoading;
                              });
                              if (value == true) {
                                SharedPreferenceService().setLoginStatus();

                                Navigator.of(context)
                                    .pushReplacementNamed(HomeScren.routeName);
                              }
                            });
                          }
                        },
                        child: Text(_isSignUp ? 'Sign Up' : 'Login')),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        _isSignUp
                            ? 'Already have an account?'
                            : "Don't have an account?",
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _isSignUp = !_isSignUp;
                            });
                          },
                          child: Text(_isSignUp ? 'Login' : 'Sign Up'))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
