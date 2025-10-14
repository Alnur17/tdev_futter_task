import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tdev_futter_task/app/modules/login/views/login_view.dart';
import 'package:tdev_futter_task/app/modules/signup/views/verify_otp_view.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailTEController = TextEditingController();
    final phoneTEController = TextEditingController();
    final nameTEController = TextEditingController();
    final passwordTEController = TextEditingController();
    final confirmPasswordTEController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
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
                sh50,
                Text(
                  'Create Account',
                  style: h2.copyWith(fontSize: 20),
                ),
                sh16,
                CustomTextField(
                  controller: nameTEController,
                  hintText: 'Full Name',
                  preIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Image.asset(
                      AppImages.person,
                      scale: 4,
                    ),
                  ),
                ),
                sh16,
                CustomTextField(
                  controller: phoneTEController,
                  hintText: 'Phone No',
                  preIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Image.asset(
                      AppImages.phone,
                      scale: 4,
                    ),
                  ),
                ),
                sh16,
                CustomTextField(
                  controller: emailTEController,
                  hintText: 'qxpay@gamil.com',
                  preIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Image.asset(
                      AppImages.email,
                      scale: 4,
                    ),
                  ),
                ),
                sh16,
                CustomTextField(
                  controller: passwordTEController,
                  hintText: 'Password',
                  preIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Image.asset(
                      AppImages.unLock,
                      scale: 4,
                    ),
                  ),
                ),
                sh16,
                CustomTextField(
                  controller: confirmPasswordTEController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                  preIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Image.asset(
                      AppImages.lock,
                      scale: 4,
                    ),
                  ),
                  sufIcon: Image.asset(
                    AppImages.eye,
                    scale: 4,
                  ),
                ),
                sh24,
                CustomButton(
                  text: 'Next',
                  onPressed: () {
                    Get.offAll(()=> VerifyOtpView());
                  },
                  backgroundColor: AppColors.blueLight,
                ),
                sh30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: h5.copyWith(color: AppColors.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.off(() => LoginView());
                      },
                      child: Text(
                        'Login',
                        style: h5.copyWith(
                          color: AppColors.blueLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                sh24,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
