import 'package:get/get.dart';

class SubscriptionPlanController extends GetxController {
  var selectedPlan = (-1).obs;

  void selectPlan(int index) {
    selectedPlan.value = index;
  }
}
