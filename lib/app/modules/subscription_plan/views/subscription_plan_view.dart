import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../controllers/subscription_plan_controller.dart';
import '../../../../common/app_images/app_images.dart';

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
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator(color: AppColors.blueLight,));
            }

            if (controller.plans.isEmpty) {
              return const Center(child: Text('No subscription plans found.'));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sh16,
                Text('Pricing', style: h2),
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
                  child: Column(
                    children: List.generate(controller.plans.length, (index) {
                      final plan = controller.plans[index];
                      return Column(
                        children: [
                          _buildPlanTile(
                            index: index,
                            title: plan.name ?? 'Unnamed Plan',
                            price:
                                '\$${plan.price ?? 0} / ${plan.durationDays ?? 0} days',
                            tag: index == 0 ? 'Most Popular' : null,
                          ),
                          if (index != controller.plans.length - 1)
                            const Divider(height: 1),
                        ],
                      );
                    }),
                  ),
                ),
                sh24,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Details',
                      style: h3.copyWith(color: AppColors.grey)),
                ),
                sh8,
                Obx(() {
                  final selected = controller.selectedPlanDetails.value;
                  if (selected == null) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.silver,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text('Please select a plan',
                            style: h4.copyWith(color: AppColors.grey)),
                      ),
                    );
                  }
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.silver,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _buildDetailRow('Plan Name:', selected.name ?? ''),
                        sh8,
                        _buildDetailRow(
                            'Duration:', '${selected.durationDays ?? 0} Days'),
                        sh8,
                        _buildDetailRow('Amount:', '\$${selected.price ?? 0}'),
                        sh8,
                        _buildDetailRow('Charge:', '\$${selected.charge ?? 0}'),
                      ],
                    ),
                  );
                }),
                sh20,
                CustomButton(
                  text: 'Pay Now',
                  onPressed: () {
                    if (controller.selectedPlan.value == -1) {
                      Get.snackbar('Warning', 'Please select a plan first');
                      return;
                    }

                    final selectedPlan = controller.selectedPlanDetails.value;
                    if (selectedPlan != null && selectedPlan.id != null) {
                      controller.createPaymentSession(
                          planId: selectedPlan.id.toString());
                    } else {
                      Get.snackbar('Error', 'Invalid plan selected');
                    }
                  },
                  backgroundColor: AppColors.blueLight,
                  textColor: AppColors.white,
                ),
              ],
            );
          }),
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
    final controller = Get.find<SubscriptionPlanController>();
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
            sw8,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: h3),
                Text(price, style: h4.copyWith(color: AppColors.grey)),
              ],
            ),
            const Spacer(),
            if (tag != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(tag, style: h6.copyWith(color: AppColors.white)),
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
