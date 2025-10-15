import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdev_futter_task/app/modules/signup/controllers/signup_controller.dart';
import 'package:tdev_futter_task/common/widgets/custom_button.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';

class VerifyOtpView extends StatelessWidget {
  final String otp;
  final String email;

  VerifyOtpView({super.key, required this.otp, required this.email});

  final SignupController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    if (otp.isNotEmpty && otp.length == 6) {
      Future.microtask(() {
        for (int i = 0; i < 6; i++) {
          controller.controllers[i].text = otp[i];
        }
        controller.otp.value = otp;
      });
    }
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sh40,
            Center(
              child: Image.asset(
                AppImages.logo,
                scale: 4,
              ),
            ),
            sh150,
            Text('Verify Your Email', style: h2.copyWith(fontSize: 20)),
            sh8,
            Text(
              "OTP sent to $email",
              textAlign: TextAlign.center,
            ),
            sh24,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 60,
                  child: TextField(
                    controller: controller.controllers[index],
                    focusNode: controller.focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: h2.copyWith(fontSize: 20),
                    decoration: InputDecoration(
                      counterText: '',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: AppColors.blueLight),
                      ),
                    ),
                    onChanged: (value) => controller.onChanged(value, index),
                  ),
                );
              }),
            ),
            sh40,
            Obx( ()=> CustomButton(
                text: 'Verify',
                onPressed:  controller.isLoading.value
                    ? (){}
                    : () async {
                  String enteredOtp = controller.otp.value;

                  if (enteredOtp.length != 6) {
                    Get.snackbar('Error', 'Please enter a valid 6-digit OTP');
                    return;
                  }

                  await controller.otpVerify(
                    email: email,
                    otp: enteredOtp,
                  );
                },
                backgroundColor: AppColors.blueLight,
              ),
            ),
            sh16,
            CustomButton(
              text: 'Resend OTP',
              onPressed: () {
                controller.resendOtp(email: email);
              },
              backgroundColor: AppColors.silver,
              textColor: AppColors.black,
            ),
          ],
        ),
      ),
    );
  }
}
