import 'package:equatable/equatable.dart';

class ReviewModel extends Equatable {
  final int? id;
  final int? orderId;
  final Client? client;
  final double? rate;
  final String? review;
  final String? rateAt;

  const ReviewModel({
    this.id,
    this.orderId,
    this.client,
    this.rate,
    this.review,
    this.rateAt,
  });

  // fromJson method
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as int?,
      orderId: json['order_id'] as int?,
      client: json["client"]!=null?Client.fromJson(json["client"]):null,
      rate: json['rate'].toDouble(),
      review: json['review'] as String?,
      rateAt: json['rate_at'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, orderId, client, rate, review, rateAt,];
}

class Total extends Equatable {
  final int? count;
  final double? rate;

  const Total({this.count, this.rate});

  // fromJson method
  factory Total.fromJson(Map<String, dynamic> json) {
    return Total(
      count: json['count'] as int?,
      rate: (json['rate'] as num?)?.toDouble(),
    );
  }

  @override
  List<Object?> get props => [count, rate];
}

class ReviewsModel extends Equatable {
  final Total? total;
  final List<ReviewModel>? reviews;

  const ReviewsModel({this.total, this.reviews});

  // fromJson method
  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return ReviewsModel(
      total: json['total'] != null ? Total.fromJson(json['total']) : null,
      reviews: json['reviews'] != null
          ? (json['reviews'] as List)
          .map((review) => ReviewModel.fromJson(review))
          .toList()
          : null,
    );
  }

  @override
  List<Object?> get props => [total, reviews,];
}

class Client extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? mobile;
  final String? avatar;

  const Client({this.id, this.name, this.email, this.mobile, this.avatar});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      avatar: json['avatar'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, name, email, mobile, avatar];
}
