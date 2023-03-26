import 'package:flutter/material.dart';
import 'package:fyp_mobile/common/utils/app_color.dart';
import 'package:fyp_mobile/common/utils/extensions.dart';
import 'package:fyp_mobile/common/utils/style.dart';
import 'package:fyp_mobile/feature/wallet/model/account.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({super.key, required this.account});
  final Account account;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.primaryItemColor,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppColor.backgroundElementGradient,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 4),
            spreadRadius: 0,
            blurRadius: 4,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(account.accountName, style: AppStyles.backgroundColorTextStyle.copyWith(fontSize: 16)),
              6.0.vSpace,
              Text('\$${account.balance}', style: AppStyles.backgroundColorTextStyle.copyWith(fontSize: 30, fontWeight: FontWeight.bold)),
            ],
          ),
          16.0.vSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white.withOpacity(0.15),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_upward,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      8.0.hSpace,
                      Text(
                        'Income',
                        style: AppStyles.backgroundColorTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  6.0.vSpace,
                  Text('\$547', style: AppStyles.backgroundColorTextStyle.copyWith(fontSize: 20)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white.withOpacity(0.15),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_upward,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      8.0.hSpace,
                      Text(
                        'Expenses',
                        style: AppStyles.backgroundColorTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  6.0.vSpace,
                  Text('\$236', style: AppStyles.backgroundColorTextStyle.copyWith(fontSize: 20)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
