import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tdev_futter_task/common/app_color/app_colors.dart';

import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        titleSpacing: 20,
        title: Row(
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
                child: Image.network(AppImages.profileImage),
              ),
            ),
            sw8,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sultan',
                  style: h3,
                ),
                sh5,
                Text(
                  'sultan******@gmail.com',
                  style: h5,
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(8),
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
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            sh100,
            Container(
              padding: EdgeInsets.all(20),
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.goldenLight,
              border: Border.all(color: AppColors.golden)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.crown,
                    scale: 4,
                  ),
                  sh12,
                  Text('Subscription: Active (Pro Plan)',style: h3,),
                  Text('Next Billing: 08 Oct 2026',style: h5),
                ],
              ),
            ),
            sh150,
            CustomButton(
              text: 'Logout',
              onPressed: () {

              },
              backgroundColor: AppColors.redFaded,
              textColor: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
