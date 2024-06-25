import 'package:flutter/material.dart';
import 'homepage.dart';
import 'register.dart';
import 'package:flutter/gestures.dart';
import 'Api/Api_Service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _goToRegister() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => RegisterScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  SizedBox(height: 50.0),
                  Text(
                    'Masuk',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 10.0),

                  // Subtitle
                  Text(
                    'Silahkan masuk untuk melanjutkan',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 30.0),

                  // Form
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Email Field
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Masukkan email',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),

                        // Password Field
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Masukkan password',
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0),

                        // Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Lupa kata sandi?',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.0),

                        // Login Button
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 220,
                                child: ElevatedButton(
                                  onPressed: () {
                                    String email = emailController.text;
                                    String password = passwordController.text;
                                    loginUser(context, email, password);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF2E5F4C),
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Masuk',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text.rich(
                                TextSpan(
                                  text: 'Belum memiliki akun? ',
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: 'Daftar',
                                      style: TextStyle(color: Colors.green),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = _goToRegister,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
