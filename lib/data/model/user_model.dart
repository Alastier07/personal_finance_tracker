class UserModel {
  final String id;
  final String email;
  final String name;
  final String avatar;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      avatar: json['avatar'],
    );
  }
}
