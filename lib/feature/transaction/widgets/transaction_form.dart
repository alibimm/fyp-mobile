import 'package:flutter/material.dart';
import 'package:fyp_mobile/common/utils/app_color.dart';
import 'package:fyp_mobile/common/utils/extensions.dart';
import 'package:fyp_mobile/common/utils/style.dart';
import 'package:fyp_mobile/feature/transaction/widgets/form_field.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _dateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

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
            field: DropdownButton<int>(
              items: const [DropdownMenuItem(child: Text('Entertainment'))],
              onChanged: (int? value) {},
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
          30.0.vSpace,
        ],
      ),
    );
  }
}
