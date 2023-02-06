import 'package:fyp_mobile/feature/login/model/user.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
// ignore: depend_on_referenced_packages
import 'package:copy_with_extension/copy_with_extension.dart';

part 'main_user.g.dart';

@JsonSerializable()
@CopyWith()
class MainUser {
  final String? accessToken;
  final User? user;

  MainUser({this.accessToken, this.user});
  
  factory MainUser.fromJson(Map<String, dynamic> json) =>
      _$MainUserFromJson(json);
  Map<String, dynamic> toJson() => _$MainUserToJson(this);
}
