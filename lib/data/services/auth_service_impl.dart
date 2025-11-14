import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:imio_flutter/data/apis/auth_api_client.dart';
import 'package:imio_flutter/data/model/user.dart';
import 'package:imio_sdk_lite/imio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logging/logging.dart';

import '../../utils/exception.dart';
import 'auth_service.dart';
import 'shared_preferences_service.dart';

class AuthServiceImpl extends AuthService {
  final logger = Logger('AuthService');

  AuthServiceImpl({
    required IMIOClient client,
        required AuthApiClient authApiClient,
      required SharedPreferencesService sharedPreferencesService})
      : _authApiClient = authApiClient,
      _client = client,
        _sharedPreferencesService = sharedPreferencesService;

  final AuthApiClient _authApiClient;
  final SharedPreferencesService _sharedPreferencesService;

  IMIOClient _client;
  bool? _isAuthenticated;
  String? _authToken;
  String _account = "";
  UserModel? userModel;

  Future<void> _fetch() async {
    final result = await _sharedPreferencesService.fetchToken();
    if (result != null) {
      _authToken = result;
      _isAuthenticated = true;
      _account = await _sharedPreferencesService.fetchAccountId() ?? "";
      var splitToken = result.split(" ");
      _client.setToken(splitToken[1]);
    } else {
      _authToken = null;
      _isAuthenticated = false;
    }
    return;
  }

  @override
  Future<bool> get isAuthenticated async {
    if (_isAuthenticated != null) {
      if (_account.isEmpty) {
        await _fetch();
      }
      return _isAuthenticated!;
    }
    await _fetch();
    return _isAuthenticated ?? false;
  }

  @override
  Future<UserModel?> login({required String email, required String password}) async {
    try {
      var loginRes = await _authApiClient.login(email, password);
      if (loginRes.accessToken != null) {
        var token = "${loginRes.tokenType} ${loginRes.accessToken}";
        _authToken = token;
        _sharedPreferencesService.saveToken(token);
        _sharedPreferencesService.saveTokenRefresh(loginRes.refreshToken);
        var tokenDecoder = _tokenDecoder(loginRes.accessToken!);
        var userModel = UserModel();
        userModel.account = tokenDecoder['account'] as String;
        userModel.nickname = tokenDecoder['nickname'] as String;
        userModel.active = tokenDecoder['active'] as bool;
        userModel = userModel;
        _sharedPreferencesService.saveAccount(userModel.account);
        _client.setToken(loginRes.accessToken!);
        _isAuthenticated = true;
        return userModel;
      } else {
        throw (BusinessException( loginRes.error ?? "密码错误"));
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 302) {
        throw (BusinessException( "账户或密码不正确"));
      }
      throw (e);
    }
  }

  @override
  Future<void> logout() async {
    final result = await _sharedPreferencesService.fetchTokenRefresh();
    if (result != null) {
      await _authApiClient.logout(result);
    }
    _sharedPreferencesService.saveToken(null);
    _sharedPreferencesService.saveTokenRefresh(null);
    _sharedPreferencesService.saveAccount(null);
    _isAuthenticated = false;
    _authToken = null;
    userModel = null;
    _client.disconnect();
  }

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    if (_authToken != null) {

    }
    logger.warning("========================== refresh token ===");
  }

  Map<String, dynamic> _tokenDecoder(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return decodedToken;
  }

  @override
  // TODO: implement toast
  get toast => throw UnimplementedError();

  @override
  Future<String?> register({required String email, required String password}) async {
    var account = await _authApiClient.register(email, password);
    _account = account;
    notifyListeners();
  }

  @override
  String get account  {
    if (userModel != null) {
      return userModel!.account;
    }
    return (_account);
  }

  @override
  String? get token => _authToken;

  @override
  UserModel? get user => userModel;

}
