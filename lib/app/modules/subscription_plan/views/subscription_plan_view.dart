import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tdev_futter_task/app/modules/subscription_plan/views/payment_success_view.dart';
import 'package:tdev_futter_task/common/app_images/app_images.dart';
import 'package:tdev_futter_task/common/widgets/custom_button.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../controllers/subscription_plan_controller.dart';

class SubscriptionPlanView extends StatelessWidget {
  SubscriptionPlanView({super.key});

  final controller = Get.put(SubscriptionPlanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sh16,
              Text(
                'Pricing',
                style: h2,
              ),
              sh5,
              Text(
                'Get unlimited access to all features',
                style: h4.copyWith(color: AppColors.grey),
              ),
              sh24,
              Container(
                decoration: BoxDecoration(
                  color: AppColors.silver,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Obx(
                  () => Column(
                    children: [
                      _buildPlanTile(
                        index: 0,
                        title: 'Gold Plan',
                        price: '\$10.99 / month',
                      ),
                      Divider(),
                      _buildPlanTile(
                        index: 1,
                        title: 'Diamond Plan',
                        price: '\$100.99 / month',
                        tag: 'Most Popular',
                      ),
                      Divider(),
                      _buildPlanTile(
                        index: 2,
                        title: 'Basic Plan',
                        price: '\$4.99 / month',
                      ),
                    ],
                  ),
                ),
              ),

              sh24,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Details',
                  style: h3.copyWith(color: AppColors.grey),
                ),
              ),
              sh8,
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.silver,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildDetailRow('Plan Name:', 'Premium'),
                    sh8,
                    _buildDetailRow('Duration:', '1 Month'),
                    sh8,
                    _buildDetailRow('Amount:', '\$29.99'),
                    sh8,
                    _buildDetailRow('Charge:', '\$10'),
                  ],
                ),
              ),
              sh20,
              CustomButton(
                text: 'Pay Now',
                onPressed: () {
                  Get.to(()=> PaymentSuccessView());
                },
                backgroundColor: AppColors.blueLight,
                textColor: AppColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanTile({
    required int index,
    required String title,
    required String price,
    String? tag,
  }) {
    final isSelected = controller.selectedPlan.value == index;

    return GestureDetector(
      onTap: () => controller.selectPlan(index),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Image.asset(
              isSelected ? AppImages.checkBoxFilled : AppImages.checkBox,
              scale: 4,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: h3,
                ),
                Text(
                  price,
                  style: h4.copyWith(color: AppColors.grey),
                ),
              ],
            ),
            Spacer(),
            if (tag != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Most Popular',
                  style: h6.copyWith(color: AppColors.white)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: h4.copyWith(fontWeight: FontWeight.bold)),
        Text(value, style: h4.copyWith(color: AppColors.grey)),
      ],
    );
  }
}
