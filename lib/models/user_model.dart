class UserModel {
  int id;
  String firstName;
  String lastName;

  String phone;
  String? imageUrl;

  get name => '$firstName $lastName';

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'image_url': imageUrl,
    };
  }
}
