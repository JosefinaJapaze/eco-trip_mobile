
class RegisterRequest {
  String name;
  String lastName;
  String gender;
  int age;
  String phone;
  String email;
  String password;

  RegisterRequest({
    required this.name,
    required this.lastName,
    required this.gender,
    required this.age,
    required this.phone,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastName': lastName,
      'gender': gender,
      'age': age,
      'phone': phone,
      'email': email,
      'password': password,
    };
  }
}