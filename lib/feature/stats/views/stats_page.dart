import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/common/utils/app_color.dart';
import 'package:fyp_mobile/common/utils/extensions.dart';
import 'package:fyp_mobile/common/utils/tools.dart';
import 'package:fyp_mobile/common/widgets/button.dart';
import 'package:fyp_mobile/common/widgets/placeholder_view.dart';
import 'package:fyp_mobile/feature/transaction/model/transaction.dart';
import 'package:fyp_mobile/feature/transaction/service/cubit/transaction_cubit.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  bool _visible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: context.height * 0.5,
              child: BlocBuilder<TransactionCubit, TransactionState>(builder: (context, state) {
                if (state is! TransactionLoaded) {
                  return const PlaceholderView(title: 'Stats');
                }
                final transactions = state.transactions;
                print("ALIBI: ${transactions.length}");
                final expenses = transactions.where((tr) => tr.type == TransactionType.expense).toList();
                final split = expenses.length * 0.7;
                final partExpenses = expenses.sublist(split.toInt());
                final income = transactions.where((tr) => tr.type == TransactionType.income).toList();
                final prediction = transactions.where((tr) => tr.type == TransactionType.transfer).toList();


                return LineChart(
                  swapAnimationDuration: const Duration(milliseconds: 150),
                  swapAnimationCurve: Curves.linear,
                  LineChartData(
                    // minY: 0.0,
                    lineBarsData: [
                      LineChartBarData(
                        // gradient: const LinearGradient(colors: AppColor.primaryGradient),
                        color: AppColor.expenseColor,
                        barWidth: 2,
                        spots: partExpenses.map((tr) => FlSpot(tr.date?.millisecondsSinceEpoch.toDouble() ?? 0.0, tr.amount)).toList(),
                        dotData: FlDotData(
                          show: false,
                        ),
                      ),
                      if (_visible)
                        LineChartBarData(
                          color: AppColor.transferColor,
                          // gradient: const LinearGradient(colors: AppColor.primaryGradient),
                          barWidth: 2,
                          spots: prediction.map((tr) => FlSpot(tr.date?.millisecondsSinceEpoch.toDouble() ?? 0.0, tr.amount)).toList(),
                          dotData: FlDotData(
                            show: false,
                          ),
                        ),
                    ],
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          getTitlesWidget: (value, meta) {
                            final month = DateTime.fromMillisecondsSinceEpoch(value.toInt()).month;
                            final text = Tools.getMonthName(month - 1);
                            return Text(text);
                          },
                          interval: 2629800000,
                          showTitles: true,
                        ),
                      ),
                      topTitles: AxisTitles(),
                    ),
                  ),
                );
              }),
            ),
            16.0.vSpace,
            CustomButton(
              title: 'Predict',
              onTap: () => setState(() => _visible = !_visible),
            ),
          ],
        ),
      ),
    );
  }
}
