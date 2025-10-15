class SubscriptionPlanModel {
  SubscriptionPlanModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<SubscriptionPlanDatum> data;

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json){
    return SubscriptionPlanModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<SubscriptionPlanDatum>.from(json["data"]!.map((x) => SubscriptionPlanDatum.fromJson(x))),
    );
  }

}

class SubscriptionPlanDatum {
  SubscriptionPlanDatum({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.price,
    required this.charge,
    required this.durationDays,
    required this.dataLimit,
  });

  final int? id;
  final String? name;
  final String? slug;
  final String? description;
  final int? price;
  final int? charge;
  final int? durationDays;
  final int? dataLimit;

  factory SubscriptionPlanDatum.fromJson(Map<String, dynamic> json){
    return SubscriptionPlanDatum(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      description: json["description"],
      price: json["price"],
      charge: json["charge"],
      durationDays: json["duration_days"],
      dataLimit: json["data_limit"],
    );
  }

}
