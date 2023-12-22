import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:period_app/model/user_model.dart';

class UserProvider extends ChangeNotifier {
  late String _userName = '';

  String get userName => _userName;

  Future<String> fetchUserNameFromHive() async {
    try {
      Box<UserModel> userBox = await Hive.openBox<UserModel>('userBox');
      UserModel? user = userBox.get('user');
      if (user != null) {
        _userName = user.name;
      } else {
        _userName = 'No name stored';
      }
      notifyListeners();
      return _userName; // Return the fetched user name
    } catch (error) {
      print('Error fetching data: $error');
      throw error;
    }
  }
}
