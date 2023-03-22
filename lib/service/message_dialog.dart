import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class MessageDialog extends Cubit<Message> {
  MessageDialog() : super(const Message());

  Future show({
    required String message,
    String? title,
    String? image,
    VoidCallback? onTap,
    int seconds = 3,
  }) async {
    final StringBuffer msg = StringBuffer();
    if (message.startsWith('Exception:')) {
      msg.write(message.replaceFirst('Exception:', '').trim());
    } else if (message.startsWith('Exception')) {
      msg.write('Internal Error');
    } else if (message.startsWith('FormatEx')) {
      msg.write(
          'The server is temporary not available. Please try it again later.');
    } else {
      msg.write(message);
    }
    emit(Message(
      title: title,
      subtitle: msg.toString(),
      image: image,
      onTap: onTap,
    ));
    await Future.delayed(Duration(seconds: seconds));
    emit(const Message());
  }

  Future hide() async => emit(const Message());
}

class Message extends Equatable {
  final String? title;
  final String? subtitle;
  final String? image;
  final VoidCallback? onTap;

  const Message({this.title, this.subtitle, this.image, this.onTap});

  @override
  List<Object?> get props => [title, subtitle, image, onTap];
}
