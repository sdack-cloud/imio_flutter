

import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final logger = Logger('SharedPreferencesService');
  static const _tokenKey = 'TOKEN';
  static const _accountKey = 'ACCOUNT_ID';
  static const _tokenRefreshKey = 'REFRESH';


  Future<String?> fetchToken() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      logger.finer('Got token from SharedPreferences');
      return (sharedPreferences.getString(_tokenKey));
    } on Exception catch (e) {
      logger.warning('Failed to get token', e);
      return null;
    }
  }

  Future<String?> fetchTokenRefresh() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      logger.finer('Got token from SharedPreferences');
      return (sharedPreferences.getString(_tokenRefreshKey));
    } on Exception catch (e) {
      logger.warning('Failed to get token', e);
      return null;
    }
  }

  Future<String?> fetchAccountId() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      return (sharedPreferences.getString(_accountKey));
    } on Exception catch (e) {
      return null;
    }
  }

  Future<void> saveToken(String? token) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      if (token == null) {
        logger.finer('Removed token');
        await sharedPreferences.remove(_tokenKey);
      } else {
        logger.finer('Replaced token');
        await sharedPreferences.setString(_tokenKey, token);
      }
      return;
    } on Exception catch (e) {
      logger.warning('Failed to set token', e);
      return;
    }
  }

  Future<void> saveTokenRefresh(String? token) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      if (token == null) {
        logger.finer('Removed token');
        await sharedPreferences.remove(_tokenRefreshKey);
      } else {
        logger.finer('Replaced token');
        await sharedPreferences.setString(_tokenRefreshKey, token);
      }
      return;
    } on Exception catch (e) {
      logger.warning('Failed to set token', e);
      return;
    }
  }

  Future<void> saveAccount(String? token) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      if (token == null) {
        await sharedPreferences.remove(_accountKey);
      } else {
        await sharedPreferences.setString(_accountKey, token);
      }
      return;
    } on Exception catch (e) {
      return;
    }
  }

}