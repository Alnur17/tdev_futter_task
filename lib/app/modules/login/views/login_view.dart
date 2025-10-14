import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdev_futter_task/app/modules/signup/views/signup_view.dart';
import 'package:tdev_futter_task/common/app_images/app_images.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_loader.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
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
                  controller: loginController.emailTEController,
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
                Obx(() {
                  return CustomTextField(
                    controller: loginController.passwordTEController,
                    hintText: 'Password',
                    preIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Image.asset(
                        AppImages.lock,
                        scale: 4,
                      ),
                    ),
                    sufIcon: GestureDetector(
                      onTap: () {
                        loginController.togglePasswordVisibility();
                      },
                      child: Image.asset(
                        loginController.isPasswordVisible.value
                            ? AppImages.eye
                            : AppImages.eyeClose,
                        scale: 4,
                      ),
                    ),
                    obscureText: !loginController.isPasswordVisible.value,
                  );
                }),
                sh12,
                Row(
                  children: [
                    Obx(() {
                        return GestureDetector(
                          onTap: () {
                            loginController.toggleCheckboxVisibility();
                          },
                          child: Image.asset(
                            loginController.isCheckboxVisible.value
                                ? AppImages.checkBoxFilled :AppImages.checkBox,
                            scale: 4,
                          ),
                        );
                      }
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
                Obx(
                  () => loginController.isLoading.value
                      ? CustomLoader(color: AppColors.white)
                      : CustomButton(
                          text: 'Login',
                          onPressed: () {
                            loginController.userLogin();
                          },
                          backgroundColor: AppColors.blueLight,
                        ),
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
                        Get.off(() => SignupView());
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
