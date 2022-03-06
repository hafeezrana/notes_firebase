// import 'package:flutter/cupertino.dart';
// import 'package:note_firebase/services/firestore_service.dart';

// import '../models/user.dart';

// class ProfileProvider extends ChangeNotifier {
//   final firestoreService = FireStoreService();
//   String? _userName;
//   String? _address;
//   String? _contactNo;

//   String get username => _userName!;
//   String get address => _address!;
//   String get contactNo => _contactNo!;

//   set username(String value) {
//     _userName = value;
//     notifyListeners();
//   }

//   set address(String value) {
//     _address = value;
//     notifyListeners();
//   }

//   set contactNo(String value) {
//     _contactNo = value;
//     notifyListeners();
//   }

//   void loadUser(UserModel? user) {
//     if (user != null) {
//       UserModel(
//         userName: user.userName,
//         address: user.address,
//         contactNo: user.contactNo,
//       );
//     }
//   }

//   void editUser() async {
//     await firestoreService.editUser(
//       UserModel(
//         userName: _userName,
//         address: _address,
//         contactNo: _contactNo,
//       ),
//     );
//   }
// }
