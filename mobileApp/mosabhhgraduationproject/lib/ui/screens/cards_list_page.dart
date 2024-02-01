import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/cards/cards_cubit.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/general_state.dart';
import 'package:mosabhhgraduationproject/config/route/app_routes.dart';
import 'package:mosabhhgraduationproject/config/theme/colors.dart';
import 'package:mosabhhgraduationproject/data/model/card.dart';
import 'package:mosabhhgraduationproject/ui/widgets/card_view.dart';
import 'package:mosabhhgraduationproject/ui/widgets/progressBar.dart';

class CardListPage extends StatefulWidget {
  const CardListPage({super.key});

  @override
  _CardListPageState createState() => _CardListPageState();
}

class _CardListPageState extends State<CardListPage> {
  bool haveAddedOrSelectCard = false;
  List<CreditCard> cards = [];

  @override
  void initState() {
    BlocProvider.of<CardsCubit>(context).getAllCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(haveAddedOrSelectCard),
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                ),
                const Text(
                  'My Cards',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  textAlign: TextAlign.start,
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: OutlinedButton(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(
                        context, AppRoutes.addNewCard);
                    if (result != null) {
                      setState(() {
                        cards.add(result);
                        haveAddedOrSelectCard = true;
                      });
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    shadowColor: Colors.grey,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: Size.zero,
                    side: const BorderSide(color: AppColors.primaryBlue),
                    // Set this
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    foregroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text("Add new Card"),
                ),
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.only(left: 16.0),
            //   decoration:  BoxDecoration(
            //     border: Border.all(width: 1, color: Colors.black12),
            //     borderRadius: const BorderRadius.all(Radius.circular(10)),
            //     color: Colors.white,
            //   ),
            //   child: TextField(
            //     controller: searchController,
            //     decoration: const InputDecoration(
            //         border: InputBorder.none,
            //         hintText: 'Search',
            //         prefixIcon: Icon(Icons.search, color: Colors.black)),
            //     onChanged: (value) {
            //       if (value.isNotEmpty) {
            //         List<ProductCategory> tempList = [];
            //         for (var category in categories) {
            //           if (category.type.name.toLowerCase().contains(value)) {
            //             tempList.add(category);
            //           }
            //         }
            //         setState(() {
            //           searchResults.clear();
            //           searchResults.addAll(tempList);
            //         });
            //         return;
            //       } else {
            //         setState(() {
            //           print("____$searchResults");
            //           searchResults = List.from(AppData.categories);
            //           print("_____${searchResults.length}");
            //           print("_____${AppData.categories.length}");
            //         });
            //       }
            //     },
            //   ),
            // ),
            BlocBuilder<CardsCubit, GeneralState<List<CreditCard>>>(
              builder: (context, state) {
                if (state is LoadingState) {
                  // Show loading indicator
                  return const ProgressBar();
                } else if (state is LoadedState) {
                  cards = (state as LoadedState).data;
                  bool hasDefult = ((state as LoadedState).data
                              as List<CreditCard>).firstWhereOrNull((element) => element.isDefault == true)?.isDefault??false;
                  return Flexible(
                    child: ListView.builder(
                      itemCount: cards.length,
                      itemBuilder: (_, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                        ),
                        child: SizedBox(
                          height: 160,
                          child: CardView(
                              onCardPressed: () {
                                haveAddedOrSelectCard=true;
                                BlocProvider.of<CardsCubit>(context)
                                    .markAsDefultCard(cards[index].id ?? 0);
                              },
                              isDefult:(cards[index].isDefault ?? false),
                              cardNumber: addSpacesToNumber(
                                  cards[index].number.toString()),
                              ccv: cards[index].cvv.toString(),
                              color: cards[index].color!.color!),
                        ),
                      ),
                    ),
                  );
                } else if (state is EmptyState) {
                  // Handle case when there are no products
                  return const Text('No products available.');
                } else if (state is ErrorState) {
                  // Handle error state
                  return Text('Error: ${(state as ErrorState).error}');
                } else {
                  return Text('Unhandled state: $state');
                }
              },
            )
          ],
        ),
      ),
    );
  }

  String addSpacesToNumber(String number) {
    List<String> chunks = [];

    for (int i = 0; i < number.length; i += 4) {
      int endIndex = i + 4;
      if (endIndex > number.length) {
        endIndex = number.length;
      }
      chunks.add(number.substring(i, endIndex));
    }

    return chunks.join(' ');
  }
}
