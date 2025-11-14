import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:imio_flutter/data/model/auth_entity.dart';
import 'package:imio_flutter/utils/exception.dart';

class AuthApiClient {
  AuthApiClient({String? host, int? port, Dio? client})
      : _host = host ?? 'auth',
        _port = port ?? 9999,
        _client = client ?? Dio() {
    _client.interceptors.add(LogInterceptor(responseBody: false));
  }

  final String _host;
  final int _port;
  final Dio _client;

  final emailReg = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$');
  final phoneReg = RegExp(r'^1[3-9]\d{9}$');

  Future<AuthEntity> login(String username, String password) async {
    final formData = FormData.fromMap({
      'username': username,
      'password': password,
      'grant_type': 'urn:ietf:params:oauth:grant-type:password',
      'scope': 'openid,userinfo'
    });
    var options = Options(headers: {
      "Authorization": "Basic MTIxOjI0ZGVlM2RlYjc3NDQ4ZGNiZTliZTk1Mzc3NGFiYWJl"
    });
    var response = await _client.post("http://39.100.72.181:9000/oauth2/token",
        data: formData, options: options);
    if (response.statusCode == 200 && response.data != null) {
      var data = response.data as Map<String, dynamic>;
      if (data['error'] != null) {
        var message2 = data['error_description'] as String;
        throw BusinessException(
            message2.contains("Bad password") ? "密码错误" : message2);
      }
      return $AuthEntityFromJson(data);
    }
    throw BusinessException("请求失败：${response.statusCode}");
  }

  Future<void> logout(String token) async {
    final formData = FormData.fromMap({
      'token': token,
      'token_type_hint': 'refresh_token',
    });
    var options = Options(headers: {
      "Authorization": "Basic MTIxOjI0ZGVlM2RlYjc3NDQ4ZGNiZTliZTk1Mzc3NGFiYWJl"
    });
    var response = await _client.post("http://39.100.72.181:9000/oauth2/revoke",
        data: formData, options: options);
    if (response.statusCode == 200 && response.data != null) {
      return;
    }
    throw BusinessException("请求失败：${response.statusCode}");
  }

  Future<String> register(String username, String password) async {
    Map<String,dynamic>  da = {
      'password': password,
    };
    if (emailReg.hasMatch(username)) {
      da['email'] = username;
    } else if (phoneReg.hasMatch(username)) {
      da['mobile'] = username;
    }
    if (da['email'] == null && da["mobile"] == null) {
      throw BusinessException("账号类型未确定");
    }
    final formData = FormData.fromMap(da);
    var options = Options(headers: {
      "Authorization": "Basic MTIxOjI0ZGVlM2RlYjc3NDQ4ZGNiZTliZTk1Mzc3NGFiYWJl"
    });
    var response = await _client.post(
        "http://39.100.72.181:9000/register/account",
        data: formData,
        options: options);
    if (response.statusCode == 200 && response.data != null) {
      var data = response.data as Map<String, dynamic>;
      if (!data['success']) {
        throw BusinessException(data['message']);
      }
      var data2 = data["data"];
      if (data2 == null) {
        throw BusinessException(data['message']);
      }
      return data2["account"];
    }
    throw BusinessException("请求失败：${response.statusCode}");
  }
}
