import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tdev_futter_task/app/modules/login/views/login_view.dart';

import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../views/verify_otp_view.dart';

class SignupController extends GetxController {
  var isLoading = false.obs;

  final TextEditingController nameTEController = TextEditingController();
  final TextEditingController phoneTEController = TextEditingController();
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  final TextEditingController confirmPassTEController = TextEditingController();

  Future<void> registerUser() async {
    try {
      isLoading(true);

      if (passwordTEController.text.trim().length < 6) {
        Get.snackbar('Error', 'Confirm Password must be at least 6 characters');
        return;
      }

      if (passwordTEController.text.trim() !=
          confirmPassTEController.text.trim()) {
        Get.snackbar('Error', 'Passwords do not match');
        return;
      }

      final body = {
        "username": nameTEController.text.trim(),
        "email": emailTEController.text.trim(),
        "phone": phoneTEController.text.trim(),
        "password": passwordTEController.text.trim(),
        "terms": true,
      };

      final header = {
        "Content-Type": "application/json",
      };

      final response = await BaseClient.postRequest(
        api: Api.register,
        body: jsonEncode(body),
        headers: header,
      );

      final data = await BaseClient.handleResponse(response);
      debugPrint('Response data: $data');

      if (data != null && data['success'] == true) {
        final String otp = data['data']['otp'].toString();
        LocalStorage.saveData(key: AppConstant.otp, data: otp);
        String getOtp = LocalStorage.getData(key: AppConstant.otp);
        Get.offAll(() => VerifyOtpView(
              email: emailTEController.text.trim(),
              otp: getOtp,
            ));
      } else {
        Get.snackbar('Error', data?['message'] ?? 'Failed to signup');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> otpVerify({
    required String email,
    required String otp,
  }) async {
    final url = Api.verifyOtp;
    final requestBody = {
      "email": email,
      "otp": otp,
    };

    try {
      final response = await BaseClient.postRequest(
        api: url,
        body: jsonEncode(requestBody),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      final responseData = await BaseClient.handleResponse(response);

      if (responseData != null && responseData['success'] == true) {
        Get.snackbar('Success', 'OTP verified successfully!');
        Get.offAll(() => LoginView());
      } else {
        Get.snackbar('Error', responseData['message'] ?? 'Invalid OTP');
      }
    } catch (e) {
      log('OTP Verification Error: $e');
      Get.snackbar('Error', 'Failed to verify OTP. Please try again.');
    }
  }Future<void> resendOtp({
    required String email,
  }) async {
    final url = Api.resendOtp;
    final requestBody = {
      "email": email,
    };

    try {
      final response = await BaseClient.postRequest(
        api: url,
        body: jsonEncode(requestBody),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      final responseData = await BaseClient.handleResponse(response);

      if (responseData != null && responseData['success'] == true) {
        Get.snackbar('Success', 'OTP resend successfully!');
        //Get.offAll(() => LoginView());
      } else {
        Get.snackbar('Error', responseData['message'] ?? 'Invalid OTP');
      }
    } catch (e) {
      log('OTP resend Error: $e');
      Get.snackbar('Error', 'Failed to resend OTP. Please try again.');
    }
  }

  final List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  var otp = ''.obs;

  void onChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
    otp.value = controllers.map((e) => e.text).join();
  }

  @override
  void onClose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.onClose();
  }
}
