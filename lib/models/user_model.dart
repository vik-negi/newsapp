class UserModel {
  String name;
  String uid;
  String email;
  String countryCode;

  UserModel({
    required this.name,
    required this.email,
    this.countryCode = "in",
    required this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      countryCode: json['countryCode'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'countryCode': countryCode,
      'uid': uid,
    };
  }
}
