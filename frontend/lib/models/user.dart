class User {
  final String id;
  final String email;
  final String password;
  final String name;
  final String? phoneNumber;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
     id: json['id']?.toString() ?? '',
    email: json['email'] as String? ?? '',
    password: json['password'] as String? ?? '',   
    name: json['name'] as String? ?? '',
    phoneNumber: json['phoneNumber'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }
}