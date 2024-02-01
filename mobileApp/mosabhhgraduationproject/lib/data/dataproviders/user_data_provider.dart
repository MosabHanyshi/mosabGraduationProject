import 'package:mosabhhgraduationproject/data/model/user.dart';
import 'package:mosabhhgraduationproject/database/app_database.dart';
import 'package:postgres/postgres.dart';

class UserDataProvider {
  Future<dynamic> getCurrentUser(String email,String pass) async {
    Map<String, dynamic>? user;
    try {
      final conn = await AppDatabase.instance().getConnectionInstance();
      final response = await conn?.execute(Sql.named('SELECT * FROM public."users" WHERE user_email=@email AND user_password=@pass'),parameters: {
        'email':email,
      'pass':pass
      });

      response?.forEach((element) {

        user = element.toColumnMap();
      });
    } catch (exc) {
      print("Error: $exc");
    }
    return user;
  }

  Future<void> addUser(User user) async {
    try {
      final conn = await AppDatabase.instance().getConnectionInstance();
      await conn?.execute(
          Sql.named('INSERT INTO public."users"(user_id,user_email, phone,user_password, "firstName", "lastName")VALUES (@id, @email, @phone,@pass, @firstName, @lastName);'), parameters: {
        'id': user.id,
        'firstName':user.firstName,
        'lastName': user.lastName,
        'email':user.email,
        'phone':user.phone,
        'pass':user.pass
      });
    } catch (exc) {
      print("Error: $exc");
    }
  }

  Future<void> updateUserInfo(User user) async {
    try {
      final conn = await AppDatabase.instance().getConnectionInstance();
      await conn?.execute(
          Sql.named('UPDATE public."users"SET user_email=@email, phone=@phone, "firstName"=@firstName, "lastName"=@lastName, "pic"=@pic WHERE id=@id ;'), parameters: {
        'id': user.id,
        'firstName':user.firstName,
        'lastName': user.lastName,
        'email':user.email,
        'phone':user.phone,
        'pic':user.pic
      });
    } catch (exc) {
      print("Error: $exc");
    }
  }

  Future<void> updateUserpass(int id,String pass) async {
    print("_____wee_$pass");
    try {
      final conn = await AppDatabase.instance().getConnectionInstance();
      await conn?.execute(
          Sql.named('UPDATE public."users"SET user_password=@pass WHERE user_id=@id ;'), parameters: {
        'id': id,
        'pass':pass,
      });
    } catch (exc) {
      print("Error: $exc");
    }
  }

}
