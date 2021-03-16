class User {
  final String? name;

  final String? password;
  final String? email;
  final String? cellphone;
  final String? photoUrl;
  final int? points;
  final String? token;

  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  const User({
    this.name,
    this.password,
    this.email,
    this.cellphone,
    this.photoUrl,
    this.points,
    this.token,
  });

  User copyWith({
    String? name,
    String? password,
    String? email,
    String? cellphone,
    String? photoUrl,
    int? points,
    String? token,
  }) {
    if ((name == null || identical(name, this.name)) &&
        (password == null || identical(password, this.password)) &&
        (email == null || identical(email, this.email)) &&
        (cellphone == null || identical(cellphone, this.cellphone)) &&
        (photoUrl == null || identical(photoUrl, this.photoUrl)) &&
        (points == null || identical(points, this.points)) &&
        (token == null || identical(token, this.token))) {
      return this;
    }

    return new User(
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
      cellphone: cellphone ?? this.cellphone,
      photoUrl: photoUrl ?? this.photoUrl,
      points: points ?? this.points,
      token: token ?? this.token,
    );
  }

  @override
  String toString() {
    return 'User{name: $name, password: $password, email: $email, cellphone: $cellphone, photoUrl: $photoUrl, points: $points, token: $token}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          password == other.password &&
          email == other.email &&
          cellphone == other.cellphone &&
          photoUrl == other.photoUrl &&
          points == other.points &&
          token == other.token);

  @override
  int get hashCode =>
      name.hashCode ^
      password.hashCode ^
      email.hashCode ^
      cellphone.hashCode ^
      photoUrl.hashCode ^
      points.hashCode ^
      token.hashCode;

  factory User.fromMap(Map<String, dynamic> map) {
    return new User(
      name: map['name'] as String?,
      password: map['password'] as String?,
      email: map['email'] as String?,
      cellphone: map['cellphone'] as String?,
      photoUrl: map['photoUrl'] as String?,
      points: map['points'] as int?,
      token: map['token'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'name': this.name,
      'password': this.password,
      'email': this.email,
      'cellphone': this.cellphone,
      'photoUrl': this.photoUrl,
      'points': this.points,
      'token': this.token,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
