class FcmToken {
  final String? id;
  final String token;
  final String? userId;

  FcmToken({
    this.id,
    this.userId,
    required this.token,
  });

  factory FcmToken.fromJson(Map<String, dynamic> json, String id) {
    return FcmToken(
      id: id,
      token: json['token'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'userId': userId,
    };
  }
}
