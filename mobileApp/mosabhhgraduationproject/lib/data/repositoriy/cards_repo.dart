import 'package:mosabhhgraduationproject/data/dataproviders/card_data_provider.dart';
import 'package:mosabhhgraduationproject/data/model/card.dart';

class CardsRepo{
  final CardDataProvider cardDataProvider;

  CardsRepo(this.cardDataProvider);

  Future<List<CreditCard>> getAllCards() async {
    final cards = await cardDataProvider.getAllCard();
    print("_______card${cards}");
    cards.map((card) => CreditCard.fromJson(card as Map<String, dynamic>)).toList().forEach((element) {
      print("_______element${element.number}");
    });
    print("_________map${cards.map((card) => CreditCard.fromJson(card as Map<String, dynamic>)).toList()}");
    return cards.map((card) => CreditCard.fromJson(card as Map<String, dynamic>)).toList();
  }
  Future<void> addCard(CreditCard card) async {
    await cardDataProvider.addCard(card);
  }

  Future<void> markAsDefultCard(int id) async {
    await cardDataProvider.markAsDefultCard(id);
  }
}