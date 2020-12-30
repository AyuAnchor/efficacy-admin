import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AdminFirebaseProvider with ChangeNotifier {
  Future<void> userSetup(Map<String, dynamic> adminCredentials) async {
    CollectionReference adminData =
        FirebaseFirestore.instance.collection('admins');

    print(adminData);

    final Map<String, String> _adminMap = {
      'adminName': adminCredentials['name'].toString(),
      'clubName': adminCredentials['club'].toString(),
      'uid': adminCredentials['uid'].toString(),
      'clubId': adminCredentials['clubId'].toString(),
    };
    adminData.add(_adminMap);
  }
}
