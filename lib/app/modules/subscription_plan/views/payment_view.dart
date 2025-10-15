import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../controllers/subscription_plan_controller.dart';

class PaymentView extends StatefulWidget {
  final String? paymentUrl;

  const PaymentView({super.key, this.paymentUrl});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  WebViewController? _controller;
  final SubscriptionPlanController subscriptionPlanController = Get.put(SubscriptionPlanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Payment", style: titleStyle),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: widget.paymentUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
        onPageStarted: (String url) {
          debugPrint('Page start loading: $url');
        },
        onPageFinished: (String url) {
          debugPrint('Page finished loading: $url');
          if (url.contains("payment-success")) {
            subscriptionPlanController.paymentResults(paymentLink: url);
            debugPrint('::::::::::::: if condition ::::::::::::::::');
          }
        },
      ),
    );
  }
}