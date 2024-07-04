import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soil_nutrient/homepage.dart';
import 'Api_Connect.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> loginUser(
    BuildContext context, String email, String password) async {
  print('Email: $email');
  print('Password: $password');

  final apiUrl = Uri.parse(ApiConnect.login);

  try {
    final response = await http.post(
      apiUrl,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Simpan email ke shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);

      // Pindah ke halaman Home
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Home()),
      );

      Fluttertoast.showToast(
        msg: 'Login Berhasil',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );

      // Cetak email yang disimpan di SharedPreferences
      printStoredEmail();
    } else if (response.statusCode == 401) {
      print('Invalid credentials');
      Fluttertoast.showToast(
        msg: 'Email atau password salah',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      print('Login failed');
      Fluttertoast.showToast(
        msg: 'Gagal Login',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  } catch (e) {
    print('Error: $e');
    Fluttertoast.showToast(
      msg: 'Terjadi kesalahan, silakan coba lagi',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}

Future<void> printStoredEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? storedEmail = prefs.getString('email');
  if (storedEmail != null) {
    print('Stored Email: $storedEmail');
  } else {
    print('Email not found in SharedPreferences');
  }
}

Future<void> registerUser(
    String username, String email, String password) async {
  final apiUrl = Uri.parse(ApiConnect.register);

  final response = await http.post(
    apiUrl,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'first_name': username,
      'email': email,
      'password': password,
    }),
  );
  if (response.statusCode == 201) {
    print('Registrasi berhasil');
    Fluttertoast.showToast(
      msg: 'Registrasi berhasil',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color.fromARGB(255, 172, 255, 174),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  } else {
    print('Registrasi gagal');
    Fluttertoast.showToast(
      msg: 'Registrasi Gagal',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color.fromARGB(255, 255, 125, 116),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

class Land {
  final int id;
  final double averageNatrium;
  final double averageFosfor;
  final double averageKalium;
  final double averagePh;
  final double averageMoisture;
  final double averageTemperature;

  Land({
    required this.id,
    required this.averageNatrium,
    required this.averageFosfor,
    required this.averageKalium,
    required this.averagePh,
    required this.averageMoisture,
    required this.averageTemperature,
  });

  factory Land.fromJson(Map<String, dynamic> json) {
    return Land(
      id: json['id'],
      averageNatrium: json['average_natrium'].toDouble(),
      averageFosfor: json['average_fosfor'].toDouble(),
      averageKalium: json['average_kalium'].toDouble(),
      averagePh: json['average_ph'].toDouble(),
      averageMoisture: json['average_moisture'].toDouble(),
      averageTemperature: json['average_temperature'].toDouble(),
    );
  }
}

class ApiService {
  static Future<List<Land>> fetchLands() async {
    try {
      // Dapatkan email dari SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('email');

      // Pastikan email tidak null
      if (email == null) {
        throw Exception('Email not found in SharedPreferences');
      }

      // Buat URI dengan menambahkan email ke ApiConnect.lands
      Uri apiUrl = Uri.parse('${ApiConnect.lands}/?email=$email');

      // Lakukan permintaan HTTP GET
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['lands'];
        return responseData.map((json) => Land.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in fetchLands: $e');
      throw Exception('Failed to fetch data');
    }
  }
}
