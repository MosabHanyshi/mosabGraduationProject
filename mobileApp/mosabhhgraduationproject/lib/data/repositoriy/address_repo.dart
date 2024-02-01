import 'package:mosabhhgraduationproject/data/dataproviders/address_data_provider.dart';
import 'package:mosabhhgraduationproject/data/model/Address.dart';

class AddressRepo {


  final AddressDataProvider addressDataProvider;

  AddressRepo(this.addressDataProvider);

  Future<List<Address>> getAllAddress() async {
    final address = await addressDataProvider.getAllAddress();
    return address.map((address) =>
        Address.fromJson(address as Map<String, dynamic>)).toList();
  }

  Future<void> addAddress(Address address) async {
    await addressDataProvider.addAdress(address);
  }
}