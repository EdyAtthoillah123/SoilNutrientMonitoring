import 'package:shared_preferences/shared_preferences.dart';

class ApiConnect {
  static const host = "http://192.168.1.28:8000";

  static const register = "$host/api/register";

  static const login = "$host/api/login/";

  static const lands = "$host/api/showland";
}
