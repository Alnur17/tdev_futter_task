import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snackbar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../../subscription_plan/views/subscription_plan_view.dart';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;
  var isCheckboxVisible = false.obs;
  var isLoading = false.obs;

  final emailTEController = TextEditingController();
  final passwordTEController = TextEditingController();


  @override
  void onClose() {
    emailTEController.dispose();
    passwordTEController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  void toggleCheckboxVisibility() {
    isCheckboxVisible.toggle();
  }

  Future<void> userLogin() async {
    final email = emailTEController.text.trim();
    final password = passwordTEController.text.trim();
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (email.isEmpty) {
      kSnackBar(message: 'Please enter your email address', bgColor: AppColors.orange);
      return;
    }

    if (!emailRegex.hasMatch(email)) {
      kSnackBar(message: 'Please enter a valid email (e.g. user@example.com)', bgColor: AppColors.orange);
      return;
    }

    if (password.isEmpty || password.length < 6) {
      kSnackBar(message: 'Password must be at least 6 characters', bgColor: AppColors.orange);
      return;
    }

    try {
      isLoading.value = true;

      var body = {
        'email': emailTEController.text.trim(),
        'password': passwordTEController.text.trim(),
      };

      var headers = {
        'Content-Type': 'application/json',
      };

      final response = await BaseClient.postRequest(
        api: Api.login,
        body: jsonEncode(body),
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);

      if (result != null) {
        final String token = result['data']['api_token'].toString();
        LocalStorage.saveData(key: AppConstant.token, data: token);

        kSnackBar(
          message: result['message'] ?? 'Login successful!',
          bgColor: AppColors.green,
        );
        Get.offAll(() => SubscriptionPlanView());
      } else {
        kSnackBar(message: result['message'], bgColor: AppColors.red);
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: AppColors.orange);
    } finally {
      isLoading.value = false;
    }
  }
}
