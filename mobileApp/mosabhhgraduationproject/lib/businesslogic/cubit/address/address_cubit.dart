import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mosabhhgraduationproject/data/model/Address.dart';

import 'package:mosabhhgraduationproject/data/repositoriy/address_repo.dart';import 'package:mosabhhgraduationproject/businesslogic/cubit/general_state.dart';
import 'package:mosabhhgraduationproject/data/repositoriy/address_repo.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<GeneralState<List<Address>>> {
  final AddressRepo addressRepo;

  AddressCubit(this.addressRepo) : super(InitialState());
  List<Address> address = [];

  void getAllAddress() {
    emit(LoadingState());
    addressRepo.getAllAddress().then((address) {
      if (address.isEmpty) {
        emit(EmptyState());
      } else {
        emit(LoadedState(address));
        this.address = address;
      }
    }, onError: (error) {
      print("____weeee$error");
      emit(ErrorState("sth went wrong"));
    });
  }

  void addAddress(Address address) async {
    addressRepo.addAddress(address).then((value) {
      this.address.add(address);
      emit(LoadedState(this.address));
    }, onError: (error) {
      emit(ErrorState("sth went wrong"));
    });
  }
}
