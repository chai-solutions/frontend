import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static Env? _instance;

  Env._();

  factory Env() {
    if (_instance == null) {
      throw Exception('environment has not been initialized with Env.init()');
    }

    return _instance!;
  }

  static Future<Env> init() async {
    if (_instance == null) {
      var instance = Env._();
      await instance._loadEnv();
      _instance = instance;
    }

    return _instance!;
  }

  String get baseURL => _str('BASE_URL');

  Future<void> _loadEnv() async {
    await dotenv.load();
  }

  String _str(String name) {
    final result = dotenv.env[name];
    if (result == null) {
      throw Exception('environment variable $name is not set');
    }
    return result;
  }
}
