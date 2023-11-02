import 'package:json_annotation/json_annotation.dart';

part 'credential.g.dart';

@JsonSerializable()
class Credential {
  String idUser;
  String? phone;
  String? email;
  String? password;
  // 0 la khach hang, 1 la nha cung cap, 2 la nhan vien
  int role;

  Credential({
    required this.idUser,
    this.phone,
    this.email,
    this.password,
    required this.role,
  });

  factory Credential.fromJson(Map<String, dynamic> json) =>
      _$CredentialFromJson(json);

  Map<String, dynamic> toJson() => _$CredentialToJson(this);
}
