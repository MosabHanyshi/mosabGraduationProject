import 'package:mosabhhgraduationproject/data/model/card.dart';
import 'package:mosabhhgraduationproject/database/app_database.dart';
import 'package:postgres/postgres.dart';

class CardDataProvider{
  Future<void> addCard(CreditCard card) async {
    try {
      final conn = await AppDatabase.instance().getConnectionInstance();
      await conn?.execute(
          Sql.named('INSERT INTO public.cards(id, name, "number", month, year, cvc, color)VALUES (@id, @name, @number, @month, @year, @cvc, @color);'), parameters: {
        'id': card.id,
        'name': card.name,
        'number':card.number.toString(),
        'month':card.month,
        'year':card.year,
        'cvc':card.cvv,
        'color':card.color?.name
      });
    } catch (exc) {
      print("Error: $exc");
    }
  }

  Future<List<dynamic>> getAllCard() async {
    List<Map<String, dynamic>> cards = [];
    try {
      final conn = await AppDatabase.instance().getConnectionInstance();
      final response = await conn?.execute(Sql.named('SELECT * FROM "cards"'));
      response?.forEach((element) {
        cards.add(element.toColumnMap());
      });
      print("___________${cards}");
    } catch (exc) {
      print("Error: $exc");
    }
    return cards;
  }

  Future<void> markAsDefultCard(int id) async {
    try {
      final conn = await AppDatabase.instance().getConnectionInstance();
      await conn?.execute(
          Sql.named('UPDATE "cards" SET "isDefault" = false;'));
      await conn?.execute(
          Sql.named('UPDATE "cards" SET "isDefault" = @isDefault WHERE id=@id;'), parameters: {
        'isDefault': true,
        'id': id,
      });
    } catch (exc) {
      print("Error: $exc");
    }
  }
}