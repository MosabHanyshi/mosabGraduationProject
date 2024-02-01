

import 'package:flutter/material.dart';
import 'package:mosabhhgraduationproject/config/app_data.dart';
import 'package:mosabhhgraduationproject/config/theme/colors.dart';
import 'package:mosabhhgraduationproject/data/model/product.dart';
import 'package:mosabhhgraduationproject/data/model/product_category.dart';
import 'package:mosabhhgraduationproject/ui/widgets/back_button.dart';
import 'package:mosabhhgraduationproject/ui/widgets/staggered_category_card.dart';


class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  List<ProductCategory> categories = [ProductCategory( ProductType.input,false,"ros")];

  List<ProductCategory> searchResults = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchResults = categories;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xffF9F9F9),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const MyBackButton(),
            const Align(
              alignment: Alignment(-1, 0),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Category List',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16.0),
              decoration:  BoxDecoration(
                border: Border.all(width: 1, color: Colors.black12),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search, color: Colors.black)),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    List<ProductCategory> tempList = [];
                    for (var category in categories) {
                      if (category.type!.name.toLowerCase().contains(value)) {
                        tempList.add(category);
                      }
                    }
                    setState(() {
                      searchResults.clear();
                      searchResults.addAll(tempList);
                    });
                    return;
                  } else {
                    setState(() {
                      print("____$searchResults");
                      searchResults = [ProductCategory( ProductType.input,false,"ros")];
                      print("_____${searchResults.length}");
                    });
                  }
                },
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: StaggeredCardCard(
                    begin: AppColors.randomColors[0],
                    end: AppColors.randomColors[1],
                    categoryName: searchResults[index].type!.name,
                    assetPath: searchResults[index]!.asset!,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
