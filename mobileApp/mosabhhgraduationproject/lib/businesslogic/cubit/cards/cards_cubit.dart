import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/general_state.dart';
import 'package:mosabhhgraduationproject/data/model/card.dart';
import 'package:mosabhhgraduationproject/data/repositoriy/cards_repo.dart';

part 'cards_state.dart';

class CardsCubit extends Cubit<GeneralState<List<CreditCard>>> {
  final CardsRepo cardsRepo;

  CardsCubit(this.cardsRepo) : super(InitialState());
  List<CreditCard>? cards;

  void addNewCards(CreditCard card) {
    cardsRepo.addCard(card).then((value) => {}, onError: (error) {});
  }

  void getAllCards() {
    emit(LoadingState());
    cardsRepo.getAllCards().then((cards) {
      if (cards.isEmpty) {
        emit(EmptyState());
      } else {
        this.cards = cards;
        emit(LoadedState(cards));
      }
    }, onError: (error) {
      emit(ErrorState("sth went wrong"));
    });
  }

  void markAsDefultCard(int id) {
    cardsRepo.markAsDefultCard(id).then((value) {
      int? index = cards?.indexWhere((element) => element.id == id);
      cards?[index ?? 0].isDefault = true;
      emit(LoadedState(cards!));
    }, onError: (error) {
      emit(ErrorState("sth went wrong"));
    });
  }
}
