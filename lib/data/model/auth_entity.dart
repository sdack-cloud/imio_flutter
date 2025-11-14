import 'package:imio_flutter/generated/json/base/json_field.dart';
import 'package:imio_flutter/generated/json/auth_entity.g.dart';
import 'dart:convert';
export 'package:imio_flutter/generated/json/auth_entity.g.dart';

@JsonSerializable()
class AuthEntity {
	@JSONField(name: 'access_token')
	String? accessToken = '';
	@JSONField(name: 'refresh_token')
	String? refreshToken = '';
	String? scope = '';
	@JSONField(name: 'token_type')
	String? tokenType = '';
	String? error = '';
	@JSONField(name: 'expires_in')
	int? expiresIn = 0;

	AuthEntity();

	factory AuthEntity.fromJson(Map<String, dynamic> json) => $AuthEntityFromJson(json);

	Map<String, dynamic> toJson() => $AuthEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}