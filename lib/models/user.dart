import 'dart:convert';

class UserModel {
  final String? userName;
  final String? address;
  final String? contactNo;
  UserModel({
    this.userName,
    this.address,
    this.contactNo,
  });

  UserModel copyWith({
    String? userName,
    String? address,
    String? contactNo,
  }) {
    return UserModel(
      userName: userName ?? this.userName,
      address: address ?? this.address,
      contactNo: contactNo ?? this.contactNo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'address': address,
      'contactNo': contactNo,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: map['userName'],
      address: map['address'],
      contactNo: map['contactNo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'Users(userName: $userName, address: $address, contactNo: $contactNo)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.userName == userName &&
        other.address == address &&
        other.contactNo == contactNo;
  }

  @override
  int get hashCode => userName.hashCode ^ address.hashCode ^ contactNo.hashCode;
}
