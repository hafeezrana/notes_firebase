import 'dart:convert';

class Users {
  final String userName;
  final String? address;
  final String contactNo;
  Users({
    required this.userName,
    this.address,
    required this.contactNo,
  });

  Users copyWith({
    String? userName,
    String? address,
    String? contactNo,
  }) {
    return Users(
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

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      userName: map['userName'],
      address: map['address'],
      contactNo: map['contactNo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source));

  @override
  String toString() =>
      'Users(userName: $userName, address: $address, contactNo: $contactNo)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Users &&
        other.userName == userName &&
        other.address == address &&
        other.contactNo == contactNo;
  }

  @override
  int get hashCode => userName.hashCode ^ address.hashCode ^ contactNo.hashCode;
}
