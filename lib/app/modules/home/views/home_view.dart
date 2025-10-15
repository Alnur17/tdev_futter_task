import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        titleSpacing: 20,
        title: Obx(() {
          final user = homeController.userInfo.value?.data;
          return Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.greenLight,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(100)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    // There is no image field in database, so i set it static
                    AppImages.profileImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              sw8,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.username?.toString() ?? 'User Name',
                    style: h3,
                  ),
                  sh5,
                  Text(
                    user?.email ?? 'user@example.com',
                    style: h5,
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.silver),
                  child: Image.asset(
                    AppImages.notification,
                    scale: 4,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
      body: Obx(() {
        if (homeController.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColors.blueLight,
          ));
        }

        final subscription =
            homeController.userInfo.value?.data?.activeSubscription;
        final plan = subscription?.subscriptionPlan;

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              sh100,
              Container(
                padding: const EdgeInsets.all(20),
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.goldenLight,
                  border: Border.all(color: AppColors.golden),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.crown,
                      scale: 4,
                    ),
                    sh12,
                    Text(
                      'Subscription: ${subscription != null ? 'Active (${plan?.name ?? 'N/A'})' : 'Inactive'}',
                      style: h3,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Next Billing: ${subscription?.endsAt != null ? '${subscription!.endsAt!.day}-${subscription.endsAt!.month}-${subscription.endsAt!.year}' : 'N/A'}',
                      style: h5,
                    ),
                  ],
                ),
              ),
              sh150,
              CustomButton(
                text: 'Logout',
                onPressed: () {
                  homeController.logout();
                },
                backgroundColor: AppColors.redFaded,
                textColor: AppColors.white,
              ),
            ],
          ),
        );
      }),
    );
  }
}
