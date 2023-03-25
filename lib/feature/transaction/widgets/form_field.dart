import 'package:flutter/material.dart';
import 'package:fyp_mobile/common/utils/extensions.dart';
import 'package:fyp_mobile/common/utils/style.dart';

class TransactionFormField extends StatelessWidget {
  const TransactionFormField({super.key, required this.title, required this.field});
  final String title;
  final Widget field;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title.toUpperCase(), style: AppStyles.formTitleStyle),
        4.0.vSpace,
        field,
      ],
    );
  }
}
