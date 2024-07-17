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

Future<void> postLocation(String location) async {
  final apiUrl =
      Uri.parse(ApiConnect.createland); // Replace with your API endpoint
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? email = prefs.getString('email');
  final response = await http.post(
    apiUrl,
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'lokasi': location,
      'email': email,
    }),
  );
  if (response.statusCode == 201) {
    print('Berhasil Ditambahkan');
    Fluttertoast.showToast(
      msg: 'Berhasil Ditambahkan',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color.fromARGB(255, 172, 255, 174),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  } else {
    print('Gagal Ditambahkan');
    Fluttertoast.showToast(
      msg: 'Gagal Ditamabhkan',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color.fromARGB(255, 255, 125, 116),
      textColor: Colors.white,
      fontSize: 16.0,
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

// land.dart
class Land {
  final int id;
  final String lokasi;
  final double averageNitrogen;
  final double averageFosfor;
  final double averageKalium;
  final double averagePh;
  final double averageMoisture;
  final double averageTemperature;
  final String recommendation;
  final String category_nitrogen;
  final String category_fosfor;
  final String category_kalium;
  final String category_ph;

  Land({
    required this.id,
    required this.lokasi,
    required this.averageNitrogen,
    required this.averageFosfor,
    required this.averageKalium,
    required this.averagePh,
    required this.averageMoisture,
    required this.averageTemperature,
    required this.recommendation,
    required this.category_nitrogen,
    required this.category_fosfor,
    required this.category_kalium,
    required this.category_ph,
  });

  // Factory method to create a Land instance from JSON data
  factory Land.fromJson(Map<String, dynamic> json) {
    return Land(
      id: json['id'],
      lokasi: json['lokasi'],
      averageNitrogen: (json['average_nitrogen'] ?? 0).toDouble(),
      averageFosfor: (json['average_fosfor'] ?? 0).toDouble(),
      averageKalium: (json['average_kalium'] ?? 0).toDouble(),
      averagePh: (json['average_ph'] ?? 0).toDouble(),
      averageMoisture: (json['average_moisture'] ?? 0).toDouble(),
      averageTemperature: (json['average_temperature'] ?? 0).toDouble(),
      recommendation: (json['recommendation']).toString(),
      category_kalium: (json['category_kalium']).toString(),
      category_fosfor: (json['category_fosfor']).toString(),
      category_nitrogen: (json['category_nitrogen']).toString(),
      category_ph: (json['category_ph']).toString(),
    );
  }

  // Method to convert a Land instance to JSON data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lokasi': lokasi,
      'average_nitrogen': averageNitrogen,
      'average_fosfor': averageFosfor,
      'average_kalium': averageKalium,
      'average_ph': averagePh,
      'average_moisture': averageMoisture,
      'average_temperature': averageTemperature,
      'recommendation': recommendation, // Corrected key
      'category_nitrogen': category_nitrogen,
      'category_fosfor': category_fosfor,
      'category_kalium': category_kalium,
      'category_ph': category_ph,
    };
  }
}

// class Land {
//   final int id;
//   final String lokasi;
//   final double averageNitrogen;
//   final double averageFosfor;
//   final double averageKalium;
//   final double averagePh;
//   final double averageMoisture;
//   final double averageTemperature;

//   Land({
//     required this.id,
//     required this.lokasi,
//     required this.averageNitrogen,
//     required this.averageFosfor,
//     required this.averageKalium,
//     required this.averagePh,
//     required this.averageMoisture,
//     required this.averageTemperature,
//   });

//   factory Land.fromJson(Map<String, dynamic> json) {
//     return Land(
//       id: json['id'],
//       lokasi: json['lokasi'].toString(),
//       averageNitrogen: json['average_nitrogen'].toDouble(),
//       averageFosfor: json['average_fosfor'].toDouble(),
//       averageKalium: json['average_kalium'].toDouble(),
//       averagePh: json['average_ph'].toDouble(),
//       averageMoisture: json['average_moisture'].toDouble(),
//       averageTemperature: json['average_temperature'].toDouble(),
//     );
//   }
// }

// detail_land.dart
// detail_land.dart
class DetailLand {
  final int id;
  final int landId;
  final double nitrogen;
  final double fosfor;
  final double kalium;
  final double ph;
  final double moisture;
  final double temperature;

  DetailLand({
    required this.id,
    required this.landId,
    required this.nitrogen,
    required this.fosfor,
    required this.kalium,
    required this.ph,
    required this.moisture,
    required this.temperature,
  });

  factory DetailLand.fromJson(Map<String, dynamic> json) {
    return DetailLand(
      id: json['id'] ?? 0,
      landId: json['land'] ?? 0,
      nitrogen: (json['nitrogen'] ?? 0).toDouble(),
      fosfor: (json['fosfor'] ?? 0).toDouble(),
      kalium: (json['kalium'] ?? 0).toDouble(),
      ph: (json['ph'] ?? 0).toDouble(),
      moisture: (json['moisture'] ?? 0).toDouble(),
      temperature: (json['temperature'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'land': landId,
      'nitrogen': nitrogen,
      'fosfor': fosfor,
      'kalium': kalium,
      'ph': ph,
      'moisture': moisture,
      'temperature': temperature,
    };
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

  static Future<List<DetailLand>> fetchLandDetails(int landId) async {
    final response =
        await http.get(Uri.parse('${ApiConnect.detaillands}/$landId/'));

    if (response.statusCode == 200) {
      print('Berhasil');
      List<dynamic> data = json.decode(response.body);
      print(data);
      return data.map((json) => DetailLand.fromJson(json)).toList();
    } else {
      print('Gagal');
      throw Exception('Failed to load land details');
    }
  }
}
