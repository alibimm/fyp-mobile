import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/common/utils/app_color.dart';
import 'package:fyp_mobile/common/utils/extensions.dart';
import 'package:fyp_mobile/common/utils/style.dart';
import 'package:fyp_mobile/common/widgets/button.dart';
import 'package:fyp_mobile/feature/transaction/service/cubit/transaction_cubit.dart';
import 'package:fyp_mobile/feature/transaction/widgets/form_field.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _dateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  late String _selectedCategory;
  late DateTime _selectedDate;

  final List<String> categories = [
    'Entertainment',
    'Groceries',
    'Transport',
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = categories[0];
    _selectedDate = DateTime.now();
  }

  void createOnTapped() {
    try {
      final double amount = double.parse(_valueController.text);
      BlocProvider.of<TransactionCubit>(context).createTransaction(amount, _selectedCategory, _selectedDate);
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 22),
            blurRadius: 35,
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TransactionFormField(
            title: 'Category',
            field: DropdownButton<String>(
              value: _selectedCategory,
              items: [
                for (final category in categories)
                  DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  ),
              ],
              onChanged: (String? value) {
                if (value == null) return;
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
          ),
          16.0.vSpace,
          TransactionFormField(
            title: 'Amount',
            field: TextField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              controller: _valueController,
              decoration: InputDecoration(
                hintText: '00.00',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColor.floatingActionButtonColor),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusColor: AppColor.floatingActionButtonColor,
                prefixIcon: const Icon(
                  Icons.monetization_on_outlined,
                  color: AppColor.floatingActionButtonColor,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _valueController.clear();
                  },
                  child: Container(
                    height: 24,
                    width: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        'Clear',
                        style: AppStyles.formTitleStyle.copyWith(color: AppColor.floatingActionButtonColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          16.0.vSpace,
          TransactionFormField(
            title: 'Date',
            field: TextField(
              controller: _dateController,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.calendar_today),
                suffixIconColor: AppColor.floatingActionButtonColor,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColor.floatingActionButtonColor),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusColor: AppColor.floatingActionButtonColor,
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2100),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: AppColor.floatingActionButtonColor,
                          onPrimary: Colors.white,
                          onSurface: AppColor.floatingActionButtonColor,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: AppColor.floatingActionButtonColor,
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (pickedDate != null) {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  setState(() {
                    _selectedDate = pickedDate;
                    _dateController.text = formattedDate;
                  });
                }
              },
            ),
          ),
          20.0.vSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                title: 'Create',
                onTap: createOnTapped,
              ),
            ],
          )
        ],
      ),
    );
  }
}
