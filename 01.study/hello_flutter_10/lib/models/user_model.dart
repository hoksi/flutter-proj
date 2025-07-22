class User {
  final String name;
  final int age;
  final String email;

  User({
    required this.name,
    required this.age,
    required this.email,
  });

  // 선택 사항: JSON 데이터로부터 User 객체를 생성하는 팩토리 생성자
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      age: json['age'],
      email: json['email'],
    );
  }

  // 선택 사항: User 객체를 JSON 데이터로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'email': email,
    };
  }

  // 선택 사항: 객체의 내용을 문자열로 표현 (디버깅 용이)
  @override
  String toString() {
    return 'User(name: $name, age: $age, email: $email)';
  }
}
