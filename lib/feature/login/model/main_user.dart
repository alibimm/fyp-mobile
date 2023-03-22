import 'package:fyp_mobile/feature/login/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'main_user.g.dart';

@JsonSerializable()
@CopyWith()
class MainUser {
  final String? accessToken;
  final User? user;

  MainUser({this.accessToken, this.user});

  factory MainUser.fromJson(Map<String, dynamic> json) => _$MainUserFromJson(json);
  Map<String, dynamic> toJson() => _$MainUserToJson(this);
}
