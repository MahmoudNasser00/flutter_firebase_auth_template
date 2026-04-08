class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String image;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String uid) {
    return UserModel(
      uid: uid,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "email": email, "phone": phone, "image": image};
  }
}
