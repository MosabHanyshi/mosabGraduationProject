import 'package:get/get.dart';
import 'package:mosabhhgraduationproject/data/dataproviders/user_data_provider.dart';
import 'package:mosabhhgraduationproject/data/model/user.dart';

class UserRepo {
  final UserDataProvider userDataProvider;

  UserRepo(this.userDataProvider);

  Future<User?> getCurrentUser(String email, String pass) async {
    final user = await userDataProvider.getCurrentUser(email, pass);
    return user == null ? null : User.fromJson(user as Map<String, dynamic>);
  }

  Future<void> addUser(User user) async {
    await userDataProvider.addUser(user);
  }

  Future<void> updateUserInfo(User user) async {
    await userDataProvider.updateUserInfo(user);
  }

  Future<void> updateUserPass(int id, String pass) async {
    await userDataProvider.updateUserpass(id, pass);
  }
}
