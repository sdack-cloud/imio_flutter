

import 'package:flutter/foundation.dart';
import 'package:imio_flutter/data/model/user.dart';

abstract class AuthService extends ChangeNotifier {

  Future<bool> get isAuthenticated;

  UserModel? get user;

  String get account;

  String? get token;

  Future<UserModel?> login({required String email, required String password});

  Future<void> logout();

  Future<String?> register({required String email, required String password});


}