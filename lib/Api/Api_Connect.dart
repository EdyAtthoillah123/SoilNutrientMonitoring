import 'package:shared_preferences/shared_preferences.dart';

class ApiConnect {
  static const host = "http://192.168.1.27:8000";

  static const register = "$host/api/register";

  static const login = "$host/api/login/";

  static const lands = "$host/api/showland";

  static const detaillands = "$host/api/lands";

  static const createland = "$host/api/lands/"; 

  static const createdetailland = "$host/api/detail-lands/"; 
}
