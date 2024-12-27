import '../../../core.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  final String token;

  RegisterResponse({required this.token});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
