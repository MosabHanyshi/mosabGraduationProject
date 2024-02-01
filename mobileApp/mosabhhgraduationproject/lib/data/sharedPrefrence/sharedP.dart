import 'dart:convert';

import 'package:mosabhhgraduationproject/data/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedP{

  Future<User?> getCachedUser() async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    String? json=sharedPreferences.getString('USER_KEY');
    if(json==null){
      return null;
    }
    return User.fromJson(jsonDecode(json));
  }

  Future<void> saveUser(User user) async {
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    sharedPreferences.setString('USER_KEY', jsonEncode(user.toJson()));
  }

  Future<void> updatePass(String pass) async {
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    getCachedUser().then((value) =>
    {
    sharedPreferences.setString('USER_KEY', jsonEncode(value?.copyWith(pass: pass)))


    });
  }

  Future<void> clearPrefrense() async {
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    sharedPreferences.clear();

  }


}