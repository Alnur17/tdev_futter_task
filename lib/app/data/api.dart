class Api {
  /// base url

  static const baseUrl = "https://flutter-api.tdevs.co/api/v1";


  ///auth
  static const login = "$baseUrl/login"; //
  static const register = "$baseUrl/register"; //
  static const verifyOtp = "$baseUrl/otp/verify"; //
  static const resendOtp = "$baseUrl/otp/resend"; //
  static const logout = "$baseUrl/logout"; //


  ///Subscription plans
  static const String allSubscriptionPlan = "$baseUrl/subscription-plans"; //

  ///buy Subscription
  static const String subscribe = "$baseUrl/subscribe"; //

  ///Get user data
  static const String user = "$baseUrl/user"; //

}
