import 'package:flutter/material.dart';
import 'package:login_app/components/components.dart';
import 'package:login_app/constants.dart';
import 'package:login_app/screens/welcome.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:login_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_app/screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String _email;
  late String _password;
  bool _saving = false;

  // Variable to track whether the password reset link has been sent
  bool _passwordResetLinkSent = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, HomeScreen.id);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LoadingOverlay(
          isLoading: _saving,
          color: Colors.black,
          progressIndicator: CircularProgressIndicator(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const TopScreenImage(screenImageName: 'login.jpg'),
                  SizedBox(height: 20),
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue, // Your primary color
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
                  CustomBottomScreen(
                    textButton: 'Login',
                    heroTag: 'login_btn',
                    question: 'Forgot password?',
                    buttonPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      setState(() {
                        _saving = true;
                      });
                      try {
                        await _auth.signInWithEmailAndPassword(
                            email: _email, password: _password);

                        if (context.mounted) {
                          setState(() {
                            _saving = false;
                            Navigator.popAndPushNamed(context, LoginScreen.id);
                          });
                          Navigator.pushNamed(context, MainScreen.id);
                        }
                      } catch (e) {
                        signUpAlert(
                          context: context,
                          onPressed: () {
                            setState(() {
                              _saving = false;
                            });
                            Navigator.popAndPushNamed(context, LoginScreen.id);
                          },
                          title: 'WRONG PASSWORD OR EMAIL',
                          desc: 'Confirm your email and password and try again',
                          btnText: 'Try Now',
                        ).show();
                      }
                    },
                    questionPressed: () {
                      signUpAlert(
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: _email);
                            setState(() {
                              _passwordResetLinkSent = true;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Password reset link sent to $_email'),
                                duration: Duration(seconds: 4),
                              ),
                            );
                          } catch (e) {
                            // Handle error
                            // ...
                          }
                        },
                        title: 'Reset Password',
                        desc: 'Lets reset your password',
                        btnText: 'Reset',
                        context: context,
                      ).show();
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
