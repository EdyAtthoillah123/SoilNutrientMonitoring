import 'dart:ffi';

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
  final apiUrl = Uri.parse('http://192.168.1.13:8000/api/register/');

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
      backgroundColor: Color.fromARGB(255, 255, 125, 116),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

Future<void> loginUser(
  BuildContext context, String email, String password) async {
  print('Email: $email'); // Mencetak email
  print('Password: $password'); // Mencetak password

  final apiUrl = Uri.parse('http://192.168.1.13:8000/api/login/');

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
        MaterialPageRoute(builder: (context) => Home()),
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

class Berita {
  final int id;
  final String image;
  final String judul;
  final String deskripsi;
  final String tanggal;

  Berita(
      {required this.id,
      required this.judul,
      required this.deskripsi,
      required this.tanggal,
      required this.image});

  factory Berita.fromJson(Map<String, dynamic> json) {
    return Berita(
      id: json['id'],
      image: json['image'],
      judul: json['title'],
      deskripsi: json['description'],
      tanggal: json['created_at'],
    );
  }
}

Future<List<Berita>> fetchBerita() async {
  final response = await http.get(Uri.parse(ApiConnect.berita));

  if (response.statusCode == 200) {
    final List<dynamic> responseData = json.decode(response.body);
    final List<Berita> users =
        responseData.map((json) => Berita.fromJson(json)).toList();
    return users;
  } else {
    throw Exception('Failed to fetch data');
  }
}

class ImageTanaman {
  final int id;
  final String image;
  final String tanaman;

  ImageTanaman({required this.id, required this.image, required this.tanaman});

  factory ImageTanaman.fromJson(Map<String, dynamic> json) {
    return ImageTanaman(
      id: json['id'],
      image: json['imagepath'],
      tanaman: json['tanaman'],
    );
  }
}

Future<List<ImageTanaman>> fetchImage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String email = prefs.getString('email') ?? '';

  final response = await http.get(Uri.parse(ApiConnect.rekap + '/' + '$email'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    final List<dynamic> userImages =
        responseData['user']; // Ambil daftar gambar dari respons JSON
    final List<ImageTanaman> images =
        userImages.map((json) => ImageTanaman.fromJson(json)).toList();
    return images;
  } else {
    throw Exception('Failed to fetch data');
  }
}
