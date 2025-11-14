import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:imio_flutter/data/model/auth_entity.dart';
import 'package:imio_flutter/utils/exception.dart';

/**
 * 你的api接口定义在这里
 */

class ApiClient {
  ApiClient({String? host, int? port, Dio? client})
      : _host = host ?? 'localhost',
        _port = port ?? 9999,
        _client = client ?? Dio() {
    _client.interceptors.add(LogInterceptor(responseBody: false));
  }

  final String _host;
  final int _port;
  final Dio _client;

  final emailReg = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$');
  final phoneReg = RegExp(r'^1[3-9]\d{9}$');

}
