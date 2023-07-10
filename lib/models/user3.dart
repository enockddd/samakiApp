class Users3 {
  final String? user_id;
  final String? email;
  final String? username;
  final String? profile_picture;
  final String? token;

  Users3({
    required this.user_id,
    required this.email,
    required this.username,
    required this.profile_picture,
    this.token,
  });

  factory Users3.fromJson(Map<String, dynamic> json) {
    return Users3(
      user_id: json['user_id'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      profile_picture: json['profile_picture'] as String?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'email': email,
      'username': username,
      'profile_picture': profile_picture,
      'token': token,
    };
  }
}
