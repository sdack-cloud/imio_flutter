import 'package:imio_flutter/generated/json/base/json_convert_content.dart';
import 'package:imio_flutter/data/model/auth_entity.dart';

AuthEntity $AuthEntityFromJson(Map<String, dynamic> json) {
  final AuthEntity authEntity = AuthEntity();
  final String? accessToken = jsonConvert.convert<String>(json['access_token']);
  if (accessToken != null) {
    authEntity.accessToken = accessToken;
  }
  final String? refreshToken = jsonConvert.convert<String>(
      json['refresh_token']);
  if (refreshToken != null) {
    authEntity.refreshToken = refreshToken;
  }
  final String? scope = jsonConvert.convert<String>(json['scope']);
  if (scope != null) {
    authEntity.scope = scope;
  }
  final String? tokenType = jsonConvert.convert<String>(json['token_type']);
  if (tokenType != null) {
    authEntity.tokenType = tokenType;
  }
  final String? error = jsonConvert.convert<String>(json['error']);
  if (error != null) {
    authEntity.error = error;
  }
  final int? expiresIn = jsonConvert.convert<int>(json['expires_in']);
  if (expiresIn != null) {
    authEntity.expiresIn = expiresIn;
  }
  return authEntity;
}

Map<String, dynamic> $AuthEntityToJson(AuthEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['access_token'] = entity.accessToken;
  data['refresh_token'] = entity.refreshToken;
  data['scope'] = entity.scope;
  data['token_type'] = entity.tokenType;
  data['error'] = entity.error;
  data['expires_in'] = entity.expiresIn;
  return data;
}

extension AuthEntityExtension on AuthEntity {
  AuthEntity copyWith({
    String? accessToken,
    String? refreshToken,
    String? scope,
    String? tokenType,
    String? error,
    int? expiresIn,
  }) {
    return AuthEntity()
      ..accessToken = accessToken ?? this.accessToken
      ..refreshToken = refreshToken ?? this.refreshToken
      ..scope = scope ?? this.scope
      ..tokenType = tokenType ?? this.tokenType
      ..error = error ?? this.error
      ..expiresIn = expiresIn ?? this.expiresIn;
  }
}