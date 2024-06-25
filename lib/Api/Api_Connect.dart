import 'package:shared_preferences/shared_preferences.dart';

class ApiConnect {
  static const host = "http://192.168.170.97:8000/";
  static const hostConnect = '$host' + "api";

  static const register = "$hostConnect/register";

  static const login = "$hostConnect/login";

  static const image = "$hostConnect/images";

  static const rekap = "$hostConnect/rekap";

  static const berita = "$hostConnect/berita";
}
