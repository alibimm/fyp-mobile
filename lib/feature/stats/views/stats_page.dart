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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Statistics', style: TextStyle(color: AppColor.mainTextColor)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: context.height * 0.5,
              child: BlocBuilder<TransactionCubit, TransactionState>(builder: (context, state) {
                if (state is! TransactionLoaded) {
                  return const PlaceholderView(title: 'Stats');
                }
                final transactions = state.transactions;
                transactions.sort((a, b) {
                  if (a.date == null) return -1;
                  if (b.date == null) return 1;
                  return b.date!.compareTo(a.date!);
                });
                final expenses = transactions.where((tr) => tr.type == TransactionType.expense).toList();
                final split = expenses.length * 0.4;

                final partExpenses = expenses.sublist(0, split.toInt());
                // final income = transactions.where((tr) => tr.type == TransactionType.income).toList();
                final prediction = transactions.where((tr) => tr.type == TransactionType.transfer).toList();

                return LineChart(
                  swapAnimationDuration: const Duration(milliseconds: 150),
                  swapAnimationCurve: Curves.linear,
                  LineChartData(
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        tooltipBgColor: Colors.white,
                        tooltipBorder: const BorderSide(color: AppColor.primaryColor),
                      ),
                    ),
                    gridData: FlGridData(
                      show: false,
                    ),
                    borderData: FlBorderData(
                      show: false,
                      border: Border.all(
                        color: const Color(0xff37434d),
                        width: 1,
                      ),
                    ),
                    // minY: 0.0,
                    lineBarsData: [
                      LineChartBarData(
                        // gradient: const LinearGradient(colors: AppColor.primaryGradient),
                        color: AppColor.darkPrimaryColor,
                        barWidth: 2,
                        spots: expenses.length < 10
                            ? expenses.map((tr) => FlSpot(tr.date?.millisecondsSinceEpoch.toDouble() ?? 0.0, tr.amount)).toList()
                            : partExpenses.map((tr) => FlSpot(tr.date?.millisecondsSinceEpoch.toDouble() ?? 0.0, tr.amount)).toList(),
                        dotData: FlDotData(
                          show: false,
                        ),
                        isCurved: true,
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [AppColor.primaryColor, Colors.transparent],
                          ),
                        ),
                      ),
                      if (_visible)
                        LineChartBarData(
                            color: AppColor.primaryColor,
                            // gradient: const LinearGradient(colors: AppColor.primaryGradient),
                            barWidth: 2,
                            spots: prediction.map((tr) => FlSpot(tr.date?.millisecondsSinceEpoch.toDouble() ?? 0.0, tr.amount)).toList(),
                            dotData: FlDotData(
                              show: false,
                            ),
                            dashArray: [5, 5]),
                    ],
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
