class UserInfoModel {
  UserInfoModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory UserInfoModel.fromJson(Map<String, dynamic> json){
    return UserInfoModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.address,
    required this.isAdmin,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.activeSubscription,
  });

  final int? id;
  final dynamic name;
  final String? username;
  final String? email;
  final String? phone;
  final dynamic address;
  final bool? isAdmin;
  final DateTime? emailVerifiedAt;
  final DateTime? createdAt;
  final ActiveSubscription? activeSubscription;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["id"],
      name: json["name"],
      username: json["username"],
      email: json["email"],
      phone: json["phone"],
      address: json["address"],
      isAdmin: json["is_admin"],
      emailVerifiedAt: DateTime.tryParse(json["email_verified_at"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      activeSubscription: json["active_subscription"] == null ? null : ActiveSubscription.fromJson(json["active_subscription"]),
    );
  }

}

class ActiveSubscription {
  ActiveSubscription({
    required this.id,
    required this.userId,
    required this.subscriptionPlanId,
    required this.startsAt,
    required this.endsAt,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.subscriptionPlan,
  });

  final int? id;
  final int? userId;
  final int? subscriptionPlanId;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final SubscriptionPlan? subscriptionPlan;

  factory ActiveSubscription.fromJson(Map<String, dynamic> json){
    return ActiveSubscription(
      id: json["id"],
      userId: json["user_id"],
      subscriptionPlanId: json["subscription_plan_id"],
      startsAt: DateTime.tryParse(json["starts_at"] ?? ""),
      endsAt: DateTime.tryParse(json["ends_at"] ?? ""),
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      subscriptionPlan: json["subscription_plan"] == null ? null : SubscriptionPlan.fromJson(json["subscription_plan"]),
    );
  }

}

class SubscriptionPlan {
  SubscriptionPlan({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.price,
    required this.charge,
    required this.durationDays,
    required this.dataLimit,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? slug;
  final String? description;
  final int? price;
  final String? charge;
  final int? durationDays;
  final int? dataLimit;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json){
    return SubscriptionPlan(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      description: json["description"],
      price: json["price"],
      charge: json["charge"],
      durationDays: json["duration_days"],
      dataLimit: json["data_limit"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}
