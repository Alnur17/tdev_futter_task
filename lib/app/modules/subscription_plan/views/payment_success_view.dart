import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdev_futter_task/app/modules/home/views/home_view.dart';
import 'package:tdev_futter_task/common/app_images/app_images.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_background_image.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../home/controllers/home_controller.dart';

class PaymentSuccessView extends StatefulWidget {
  const PaymentSuccessView({super.key});

  @override
  State<PaymentSuccessView> createState() => _PaymentSuccessViewState();
}

class _PaymentSuccessViewState extends State<PaymentSuccessView> {
  final HomeController hController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Obx(() {
          if (hController.isLoading.value) {
            return const Center(child: CircularProgressIndicator(color: AppColors.blueLight,));
          }

          final subscription = hController.userInfo.value?.data?.activeSubscription;
          final plan = subscription?.subscriptionPlan;

          // Calculate total amount = price + charge
          String amountPaid = 'N/A';
          if (plan != null) {
            final price = plan.price ?? 0;
            final charge = int.tryParse(plan.charge ?? '0') ?? 0;
            amountPaid = '\$${price + charge}';
          }

          return Column(
            children: [
              CustomBackgroundImage(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      sh100,
                      Image.asset(
                        AppImages.subscription,
                        scale: 4,
                      ),
                      sh20,
                      Text(
                        'Subscription Activated Successfully!',
                        style: h2.copyWith(fontSize: 20),
                      ),
                      sh8,
                      Text(
                        'Your Premium Plan is now active. Enjoy all exclusive features without limits.',
                        style: h5,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              sh30,
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.silver,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildDetailRow('Plan Name:', plan?.name ?? 'N/A'),
                    sh8,
                    _buildDetailRow('Duration:', '${plan?.durationDays ?? 0} Days'),
                    sh8,
                    _buildDetailRow('Amount Paid:', amountPaid),
                    sh8,
                    _buildDetailRow('Payment Method:', 'Visa •••• 1234'),
                    sh8,
                    _buildDetailRow(
                        'Next Billing Date:',
                        subscription?.endsAt != null
                            ? "${subscription!.endsAt!.day}-${subscription.endsAt!.month}-${subscription.endsAt!.year}"
                            : 'N/A'),
                  ],
                ),
              ),
              sh100,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  text: 'Go to Dashboard',
                  onPressed: () {
                    Get.offAll(() => HomeView()); // replace with your HomeView
                  },
                  backgroundColor: AppColors.blueLight,
                  textColor: AppColors.white,
                ),
              ),
            ],
          );
        }),
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
