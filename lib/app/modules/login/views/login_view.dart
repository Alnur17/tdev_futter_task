import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdev_futter_task/app/modules/signup/views/signup_view.dart';
import 'package:tdev_futter_task/app/modules/subscription_plan/views/subscription_plan_view.dart';
import 'package:tdev_futter_task/common/app_images/app_images.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_textfield.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

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
                sh116,
                Text(
                  'Login!',
                  style: h2.copyWith(fontSize: 20),
                ),
                sh16,
                CustomTextField(
                  controller: emailController,
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
                  controller: passwordController,
                  hintText: 'Password',
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
                sh12,
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        AppImages.checkBox,
                        scale: 4,
                      ),
                    ),
                    sw8,
                    Expanded(
                      child: Text(
                        'Remember me',
                        style: h5.copyWith(color: AppColors.grey),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Forget password',
                        style: h5.copyWith(
                          color: AppColors.blueLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                sh24,
                CustomButton(
                  text: 'Login',
                  onPressed: () {
                    Get.offAll(()=> SubscriptionPlanView());
                  },
                  backgroundColor: AppColors.blueLight,
                ),
                sh30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account? ',
                      style: h5.copyWith(color: AppColors.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.off(()=> SignupView());
                      },
                      child: Text(
                        'Create One',
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
