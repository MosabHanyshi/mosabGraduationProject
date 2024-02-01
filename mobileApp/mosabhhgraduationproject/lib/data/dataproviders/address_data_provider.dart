import 'package:mosabhhgraduationproject/data/model/Address.dart';
import 'package:mosabhhgraduationproject/database/app_database.dart';
import 'package:postgres/postgres.dart';

class AddressDataProvider{
  Future<void> addAdress(Address address) async {
    try {
      final conn = await AppDatabase.instance().getConnectionInstance();
      await conn?.execute(
          Sql.named('INSERT INTO public.address(name, id, place, lat, lang)VALUES ( @name,@id, @place, @lat, @lang);'), parameters: {
        'id': address.id,
        'name': address.name,
        'place':address.placeName,
        'lat':address.Lat,
        'lang':address.Lng,
      });
    } catch (exc) {
      print("Error: $exc");
    }
  }

  Future<List<dynamic>> getAllAddress() async {
    List<Map<String, dynamic>> address = [];
    try {
      final conn = await AppDatabase.instance().getConnectionInstance();
      final response = await conn?.execute(Sql.named('SELECT * FROM "address"'));
      response?.forEach((element) {
        address.add(element.toColumnMap());
      });
      print("___________${address}");
    } catch (exc) {
      print("Error: $exc");
    }
    return address;
  }
}