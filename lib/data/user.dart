import 'dart:typed_data';

class User {
  final int? id;

  String? name, email, password, noTelp, fullName;
  Uint8List? profilePicture;

  User(
      {this.id,
      this.name,
      this.email,
      this.fullName,
      this.noTelp,
      this.password,
      this.profilePicture});
}
