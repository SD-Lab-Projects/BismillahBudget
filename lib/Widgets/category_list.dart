import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utility/icons_list.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key, required this.onChanged}) : super(key: key);

  final ValueChanged<String?> onChanged;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  String currentCategory = "";
  late ScrollController scrollController;
  late AppIcons appIcons;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    appIcons = AppIcons();
    addDefaultCategory();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void addDefaultCategory() {
    var addCat = {
      "name": "all",
      "icon": FontAwesomeIcons.cartPlus,
    };
    appIcons.homeExpensesCategories.insert(0, addCat);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: ListView.builder(
        controller: scrollController,
        itemCount: appIcons.homeExpensesCategories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var data = appIcons.homeExpensesCategories[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                currentCategory = data['name'];
                widget.onChanged(data['name']);
              });
            },
            child: Container(
              width: 130,
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: currentCategory == data['name']
                    ? Colors.blue.shade900
                    : Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      data['icon'] as IconData,
                      size: 10,
                      color: currentCategory == data['name']
                          ? Colors.white
                          : Colors.blue.shade900,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      data['name'] as String,
                      style: TextStyle(
                        color: currentCategory == data['name']
                            ? Colors.white
                            : Colors.blue.shade900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
