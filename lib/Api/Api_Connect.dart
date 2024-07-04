import 'package:shared_preferences/shared_preferences.dart';

class ApiConnect {
  static const host = "http://192.168.1.28:8000/";
  static const hostConnect = '$host' + "api";

  static const register = "$hostConnect/api/register";

  static const login = "$hostConnect/api/login/";

  static const lands = "$hostConnect/api/showland/";
}
