import 'package:flutter/material.dart';

import '../app_images/app_images.dart';

class CustomBackgroundImage extends StatelessWidget {
  final Widget child;
  final String? backImage;

  const CustomBackgroundImage({
    super.key,
    required this.child,
    this.backImage = AppImages.subscriptionBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height *.3,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(backImage!),fit: BoxFit.contain),
      ),
      child: child,
    );
  }
}