import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tdev_futter_task/common/app_constant/app_constant.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snackbar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/subscription_model.dart';
import '../views/payment_success_view.dart';
import '../views/payment_view.dart';

class SubscriptionPlanController extends GetxController {
  var isLoading = false.obs;
  var selectedPlan = (-1).obs;
  var plans = <SubscriptionPlanDatum>[].obs;
  var selectedPlanDetails = Rx<SubscriptionPlanDatum?>(null);

  @override
  void onInit() {
    fetchSubscriptionPlans();
    super.onInit();
  }

  Future<void> fetchSubscriptionPlans() async {
    try {
      isLoading.value = true;

      final token = await LocalStorage.getData(key: AppConstant.token);

      final response = await BaseClient.getRequest(
        api: Api.allSubscriptionPlan,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final jsonData = await BaseClient.handleResponse(response);
      final model = SubscriptionPlanModel.fromJson(jsonData);

      plans.assignAll(model.data);
    } catch (e) {
      debugPrint("Error fetching subscription plans: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createPaymentSession({
    required String planId,
  }) async {
    try {
      isLoading.value = true;
      String token = LocalStorage.getData(key: AppConstant.token);

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var body = {
        'plan_id' : planId.toString(),
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
          api: Api.subscribe,
          body: jsonEncode(body),
          headers: headers,
        ),
      );

      if (responseBody != null) {
        Get.to(() => PaymentView(paymentUrl: responseBody["data"]["url"]));
      } else {
        Get.snackbar("Error", "Failed to create payment session");
      }
    } catch (e) {
      debugPrint("Error, Failed to create payment $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> paymentResults({required String paymentLink}) async {
    try {
      isLoading.value = true;
      String token = LocalStorage.getData(key: AppConstant.token);

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var response =
      await BaseClient.getRequest(api: paymentLink, headers: headers);

      var responseBody = await BaseClient.handleResponse(response);

      if (responseBody['status'] == true) {
        Get.offAll(() => PaymentSuccessView());
      } else {
        debugPrint("Error on Payment Result: $responseBody['message'] ");
      }
    } catch (e) {
      debugPrint("Error on Payment Result: $e");
      kSnackBar(
        message: "Error on Payment Result: $e",
        bgColor: AppColors.orange,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void selectPlan(int index) {
    selectedPlan.value = index;
    selectedPlanDetails.value = plans[index];
  }
}
