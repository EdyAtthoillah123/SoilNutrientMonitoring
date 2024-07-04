import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soil_nutrient/homepage.dart';
import 'Api_Connect.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      backgroundColor: const Color.fromARGB(
          255, 172, 255, 174), // Warna latar belakang toast
      textColor: Colors.white, // Warna teks toast
      fontSize: 16.0, // Ukuran teks toast
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
      // Login berhasil
      final data = jsonDecode(response.body);
      // Navigasi ke halaman Home
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Home()),
      );
      // Tampilkan pesan login berhasil
      Fluttertoast.showToast(
        msg: 'Login Berhasil',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else if (response.statusCode == 401) {
      // Kredensial tidak valid
      print('Invalid credentials');
      Fluttertoast.showToast(
        msg: 'Email atau password salah',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      // Respons lainnya
      print('Login failed');
      Fluttertoast.showToast(
        msg: 'Gagal Login',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  } catch (e) {
    // Tangani kesalahan jaringan atau server
    print('Error: $e');
    Fluttertoast.showToast(
      msg: 'Terjadi kesalahan, silakan coba lagi',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}

Future<List<Land>> fetchLands() async {
  final response = await http.get(Uri.parse(ApiConnect.lands));

  if (response.statusCode == 200) {
    final List<dynamic> landsJson = json.decode(response.body)['lands'];
    return landsJson.map((json) => Land.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load lands');
  }
}

Future<void> fetchAndSetLands(
    Function(List<Land>) setLands, Function(bool) setLoading) async {
  try {
    final fetchedLands = await fetchLands();
    setLands(fetchedLands);
  } catch (e) {
    print('Error fetching lands: $e');
  } finally {
    setLoading(false);
  }
}
