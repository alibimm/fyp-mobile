import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
// ignore: depend_on_referenced_packages
import 'package:copy_with_extension/copy_with_extension.dart';

part 'user.g.dart';

@JsonSerializable()
@CopyWith()
class User extends Equatable {
  @JsonKey(name: 'email')
  final String email;
  final String userId;

  const User({this.email = '', this.userId = ''});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [email];
}
