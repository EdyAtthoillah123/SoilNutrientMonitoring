import 'package:flutter/material.dart';
import 'login.dart';
import 'package:flutter/gestures.dart';
import 'Api/Api_Service.dart';
import 'package:fluttertoast/fluttertoast.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  void _goToLogin() {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50.0),
                Text(
                  'Daftar',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Silahkan Daftar untuk melanjutkan',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 30.0),
                Form(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Nama',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 8), // Spasi antara teks Nama dan input field
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Masukkan nama',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
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
                      SizedBox(
                          height:
                              10), // Spasi antara teks Email dan input field
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
                      SizedBox(height: 10),
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
                      SizedBox(
                          height:
                              10), // Spasi antara input nama dan input password
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password', // Label untuk input password
                          border: OutlineInputBorder(),
                        ),
                        obscureText:
                            true, // Mengubah teks input menjadi titik-titik untuk menyembunyikan password
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),

                      SizedBox(
                          height:
                              30.0), // Add space between the form fields and button
                      SizedBox(
                        width: 220,
                        child: ElevatedButton(
                          onPressed: () {
                            String name = nameController.text;
                            String email = emailController.text;
                            String password = passwordController.text;
                            registerUser(name, email, password);
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
                            'Daftar',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text.rich(
                        TextSpan(
                          text: 'Sudah memiliki akun? ',
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Masuk',
                              style: TextStyle(color: Colors.green),
                              recognizer: TapGestureRecognizer()
                                ..onTap = _goToLogin,
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
    );
  }
}
