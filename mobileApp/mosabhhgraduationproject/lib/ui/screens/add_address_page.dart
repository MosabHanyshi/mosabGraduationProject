import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/address/address_cubit.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/general_state.dart';
import 'package:mosabhhgraduationproject/config/theme/colors.dart';
import 'package:mosabhhgraduationproject/data/model/Address.dart';
import 'package:mosabhhgraduationproject/ui/screens/mapScreen.dart';
import 'package:mosabhhgraduationproject/ui/widgets/address_card.dart';

class AddAddressPage extends StatefulWidget {
  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  @override
  void initState() {
    BlocProvider.of<AddressCubit>(context).getAllAddress();

    super.initState();
  }

  TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Address> addresss = [Address("Home", false, Icons.home, 0, 0, "Nablus,Rafidya street")];
    String? mplace="";
    double? lat=1;
    double? lag=1;
    Address? addredss=null;
    Widget finishButton = InkWell(
      onTap: () {
        Address test=Address("Home", false, Icons.home, 32.227264171567036, 35.22528201341629, "Nablus,Rafidya street")!;

        BlocProvider.of<AddressCubit>(context).addAddress(
            test);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('address added successfully ')),
        );
      },
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 5),
            blurRadius: 10.0,
          )
        ], borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text("Finish",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
          title: const Text(
            'Add Address',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontFamily: "Montserrat",
                fontSize: 18.0),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  height: 150,
                  child: BlocBuilder<AddressCubit, GeneralState<List<Address>>>(
                    builder: (context, state) {
                      if (state is LoadedState) {
                        return ListView.builder(
                          itemCount:
                              ((state as LoadedState).data as List<Address>)
                                  .length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 5),
                            child: AdressCard(
                              address: ((state as LoadedState).data
                                  as List<Address>)[index],
                            ),
                          ),
                        );
                      } else {
                        return Text("");
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: MediaQuery.of(context).size.height - 210,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 15.0,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text("Add Address Name"),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: address,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 3, color: Colors.blue),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          // Set border for focused state
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 3, color: Colors.blue),
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Select Address"),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.78,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius:
                                BorderRadius.all(new Radius.circular(10.0)),
                          ),
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 10),
                          child: Text(mplace.isEmpty ? "" : mplace,
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.start),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: AppColors.transparentBlue3,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              highlightColor: Colors.orange,
                              color: Colors.orange,
                              icon: FaIcon(
                                Icons.gps_fixed,
                                color: AppColors.primaryBlue,
                              ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => MapScreen()),
                                  ).then((result) {
                                    print("______$result");
                                    if (result != null) {
                                      setState(() {
                                        Address add = result;
                                        mplace = add.placeName ?? "";
                                        lag = add.Lng;
                                        lat = add.Lat;
                                        addredss=result as Address;
                                        print("______$mplace");
                                        print("______$lag");
                                      });
                                    }
                                  });
                                },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, bottom: 20, top: 20),
                          child: finishButton),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
/*
* Rafidya street, ,Nablus,
LatLng(32.227264171567036, 35.22528201341629)
* lcd,resspberry
لقد أرسلت
key bad
* Mosab Hanyshi
* mosab.hanaiysha@stu.najah.edu
*
*
*
* **/