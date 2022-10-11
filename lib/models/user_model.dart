class UserModel {
  int id;
  String name;
  String address;
  String phone;
  String? imageUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    this.imageUrl,
  });

  factory UserModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'image_url': imageUrl,
    };
  }
}
