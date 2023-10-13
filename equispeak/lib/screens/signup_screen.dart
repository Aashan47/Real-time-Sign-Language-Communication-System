import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_app/components/components.dart';
import 'package:login_app/screens/home_screen.dart';
import 'package:login_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_app/constants.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String id = 'signup_screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  late String _email;
  late String _password;
  late String _confirmPass;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, HomeScreen.id);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LoadingOverlay(
          isLoading: _saving,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const TopScreenImage(screenImageName: 'signup.jpg'),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue, // Your primary color
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    textField: TextField(
                      onChanged: (value) {
                        _email = value;
                      },
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      decoration: kTextInputDecoration.copyWith(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    textField: TextField(
                      obscureText: true,
                      onChanged: (value) {
                        _password = value;
                      },
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      decoration: kTextInputDecoration.copyWith(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    textField: TextField(
                      obscureText: true,
                      onChanged: (value) {
                        _confirmPass = value;
                      },
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      decoration: kTextInputDecoration.copyWith(
                        hintText: 'Confirm Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomBottomScreen(
                    textButton: 'Sign Up',
                    heroTag: 'signup_btn',
                    question: 'Have an account?',
                    buttonPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      setState(() {
                        _saving = true;
                      });
                      if (_confirmPass == _password) {
                        try {
                          await _auth.createUserWithEmailAndPassword(
                              email: _email, password: _password);

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Sign up successful!'),
                                duration: Duration(seconds: 4),
                              ),
                            );

                            signUpAlert(
                              context: context,
                              title: 'GOOD JOB',
                              desc: 'Go login now',
                              btnText: 'Login Now',
                              onPressed: () {
                                setState(() {
                                  _saving = false;
                                  Navigator.popAndPushNamed(
                                      context, SignUpScreen.id);
                                });
                                Navigator.pushNamed(context, LoginScreen.id);
                              },
                            ).show();
                          }
                        } catch (e) {
                          signUpAlert(
                            context: context,
                            onPressed: () {
                              SystemNavigator.pop();
                            },
                            title: 'SOMETHING WRONG',
                            desc: 'Close the app and try again',
                            btnText: 'Close Now',
                          ).show();
                        }
                      } else {
                        showAlert(
                          context: context,
                          title: 'WRONG PASSWORD',
                          desc:
                              'Make sure that you write the same password twice',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ).show();
                      }
                    },
                    questionPressed: () async {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
