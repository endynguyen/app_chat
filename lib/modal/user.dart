import 'package:cloud_firestore/cloud_firestore.dart';

class UserChat {
  String email;
  String name;
  UserChat({
    required this.email,
    required this.name,
  });

  List<UserChat> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;

      return UserChat(
        name: dataMap['name'],
        email: dataMap['email'],
      );
    }).toList();
  }
}
