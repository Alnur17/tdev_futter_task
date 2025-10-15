import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tdev_futter_task/app/data/api.dart';
import 'package:tdev_futter_task/app/data/base_client.dart';
import 'package:tdev_futter_task/app/modules/login/views/login_view.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snackbar.dart';
import '../model/user_info_model.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var userInfo = Rxn<UserInfoModel>();

  @override
  void onInit() {
    super.onInit();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    try {
      isLoading.value = true;

      String token = LocalStorage.getData(key: AppConstant.token);

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var response = await BaseClient.getRequest(
        api: Api.user,
        headers: headers,
      );

      var data = await BaseClient.handleResponse(response);

      userInfo.value = UserInfoModel.fromJson(data);
    } catch (e) {
      debugPrint("Error fetching user info: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;

      String token = LocalStorage.getData(key: AppConstant.token);

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var response = await BaseClient.postRequest(
        api: Api.logout,
        headers: headers,
      );

      var data = await BaseClient.handleResponse(response);

      if (data != null) {

        LocalStorage.removeData(key: AppConstant.token,);

        kSnackBar(
          message: data['message'] ?? 'Logout successful!',
          bgColor: AppColors.green,
        );
        Get.offAll(() => LoginView());
      } else {
        kSnackBar(message: data['message'], bgColor: AppColors.red);
      }
    } catch (e) {
      debugPrint("Error in logout: $e");
    } finally {
      isLoading.value = false;
    }
  }


}
