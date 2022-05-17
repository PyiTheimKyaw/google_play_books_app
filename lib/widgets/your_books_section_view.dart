// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/resources/colors.dart';
import 'package:google_play_books_app/resources/dimens.dart';
import 'package:google_play_books_app/viewitems/sorting_view.dart';
import 'package:google_play_books_app/viewitems/view_list_view.dart';
import 'package:google_play_books_app/widgets/your_books_by_grid_section_view.dart';
import 'package:google_play_books_app/widgets/your_books_by_large_grid_section_view.dart';
import 'package:google_play_books_app/widgets/your_books_by_list_section_view.dart';

class YourBooksSectionView extends StatelessWidget {
  String byType;
  String byView;
  List<BookVO>? recentBooksList;
  final Function(String?) onTapType;
  final Function(String?) onTapView;
  final List<String?>? categoriesStringList;
  final List<String?>? selectedCategoriesList;
  final Function(int) onSelectCategory;
  final Function(int) onSelectedCategory;
  final Function onTapClose;
  final bool isLibrary;

  YourBooksSectionView({
    required this.byType,
    required this.byView,
    required this.recentBooksList,
    required this.onTapType,
    required this.onTapView,
    required this.categoriesStringList,
    required this.onSelectCategory,
    required this.selectedCategoriesList,
    required this.onSelectedCategory,
    required this.onTapClose,
    this.isLibrary = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: isLibrary,
          child: Divider(
            color: Colors.black26,
            thickness: 1,
          ),
        ),
        CategoriesItemSectionView(
            selectedCategoriesList: selectedCategoriesList,
            onTapClose: onTapClose,
            onSelectedCategory: onSelectedCategory,
            categoriesStringList: categoriesStringList,
            onSelectCategory: onSelectCategory),
        SizedBox(
          height: MARGIN_SMALL,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: Column(
              children: [
                Row(
                  children: [
                    SortingSectionView(
                      val: byType,
                      onTap: () {
                        buildShowModalBottomSheetForSorting(context);
                      },
                    ),
                    Spacer(),
                    SortingViewListSectionView(
                      view: byView,
                      opTap: () {
                        buildShowModalBottomSheetForSortingView(context);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                Expanded(
                  child: (byView == "List")
                      ? YourBooksByListSectionView(
                          bookList: recentBooksList,
                        )
                      : (byView == "Small Grid")
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: YourBooksByGridSectionView(
                                category: [],
                                isViewMore: false,
                                books: recentBooksList,
                              ),
                            )
                          : (byView == "Large Grid")
                              ? YourBooksByLargeGridSectionView(
                                  books: recentBooksList)
                              : Container(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> buildShowModalBottomSheetForSorting(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
                  height: 40,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sort By",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )),
              Divider(
                thickness: 1,
              ),
              RadioWithText(
                value: "Author",
                val: byType,
                onTap: onTapType,
              ),
              RadioWithText(
                value: "Recent",
                val: byType,
                onTap: onTapType,
              ),
              RadioWithText(
                value: "Title",
                val: byType,
                onTap: onTapType,
              ),
            ],
          );
        });
  }

  Future<dynamic> buildShowModalBottomSheetForSortingView(
      BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
                  height: 40,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sort By",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )),
              Divider(
                thickness: 1,
              ),
              RadioWithText(
                value: "List",
                val: byView,
                onTap: onTapView,
              ),
              RadioWithText(
                value: "Small Grid",
                val: byView,
                onTap: onTapView,
              ),
              RadioWithText(
                value: "Large Grid",
                val: byView,
                onTap: onTapView,
              ),
            ],
          );
        });
  }
}

class CategoriesItemSectionView extends StatelessWidget {
  const CategoriesItemSectionView({
    Key? key,
    required this.selectedCategoriesList,
    required this.onTapClose,
    required this.onSelectedCategory,
    required this.categoriesStringList,
    required this.onSelectCategory,
  }) : super(key: key);

  final List<String?>? selectedCategoriesList;
  final Function onTapClose;

  final Function(int p1) onSelectedCategory;
  final List<String?>? categoriesStringList;

  final Function(int p1) onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      child: Row(
        children: [
          Flexible(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              children: [
                ClearButtonAndSelectedCategoriesSectionView(
                  key: Key("Clear"),
                    selectedCategoriesList: selectedCategoriesList,
                    onTapClose: onTapClose,
                    onSelectedCategory: onSelectedCategory),
                AllCategoriesListView(
                    categoriesStringList: categoriesStringList,
                    onSelectCategory: onSelectCategory),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ClearButtonAndSelectedCategoriesSectionView extends StatelessWidget {
  const ClearButtonAndSelectedCategoriesSectionView({
    Key? key,
    required this.selectedCategoriesList,
    required this.onTapClose,
    required this.onSelectedCategory,
  }) : super(key: key);

  final List<String?>? selectedCategoriesList;
  final Function onTapClose;
  final Function(int p1) onSelectedCategory;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClearCategoriesView(
            selectedCategoriesList: selectedCategoriesList,
            onTapClose: onTapClose),
        SelectedCategoriesListView(
            selectedCategoriesList: selectedCategoriesList,
            onSelectedCategory: onSelectedCategory),
      ],
    );
  }
}

class AllCategoriesListView extends StatelessWidget {
  const AllCategoriesListView({
    Key? key,
    required this.categoriesStringList,
    required this.onSelectCategory,
  }) : super(key: key);

  final List<String?>? categoriesStringList;
  final Function(int p1) onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: [
        ...List.generate(
            categoriesStringList?.length ?? 0,
            (index) => CategoryItem(
                index: index,
                onTap: onSelectCategory,
                categoriesStringList: categoriesStringList?[index]))
      ],
    );
  }
}

class SelectedCategoriesListView extends StatelessWidget {
  const SelectedCategoriesListView({
    Key? key,
    required this.selectedCategoriesList,
    required this.onSelectedCategory,
  }) : super(key: key);

  final List<String?>? selectedCategoriesList;

  final Function(int p1) onSelectedCategory;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: [
        ...List.generate(
          selectedCategoriesList?.length ?? 0,
          (index) => CategoryItem(
            isSelectedCategory: true,
            categoriesStringList: selectedCategoriesList?[index],
            onTap: onSelectedCategory,
            index: index,
          ),
        ),
      ],
    );
  }
}

class ClearCategoriesView extends StatelessWidget {
  const ClearCategoriesView({
    Key? key,
    required this.selectedCategoriesList,
    required this.onTapClose,
  }) : super(key: key);

  final List<String?>? selectedCategoriesList;
  final Function onTapClose;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: selectedCategoriesList?.isNotEmpty ?? false,
        child: GestureDetector(
            onTap: () {
              onTapClose();
            },
            child: Icon(Icons.close)));
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.categoriesStringList,
    this.isSelectedCategory = false,
    required this.onTap,
    required this.index,
  }) : super(key: key);

  final String? categoriesStringList;
  final Function(int) onTap;
  final bool isSelectedCategory;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: Container(
        key: Key("$index"),
        padding: const EdgeInsets.all(2),
        child: Chip(
          elevation: 0.6,
          backgroundColor: (isSelectedCategory)
              ? Color.fromRGBO(3, 121, 201, 1.0)
              : Colors.white,
          shape: StadiumBorder(
            side: BorderSide(
              color: Color.fromRGBO(234, 234, 234, 1.0),
            ),
          ),
          label: Text(
            categoriesStringList ?? "",
            style: TextStyle(
                color: (isSelectedCategory) ? Colors.white : ICON_COLOR),
          ),
        ),
      ),
    );
  }
}

class SortingViewAndTypeSectionView extends StatelessWidget {
  const SortingViewAndTypeSectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class RadioWithText extends StatelessWidget {
  String value;
  String val;
  Function(String?) onTap;

  RadioWithText({required this.value, required this.val, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
          key: Key(value),
          fillColor: MaterialStateColor.resolveWith(
              (states) => Colors.lightBlueAccent),
          autofocus: true,
          value: value,
          groupValue: val,
          onChanged: (value) {
            onTap(value);
          },
          activeColor: Colors.green,
        ),
        Text(value),
      ],
    );
  }
}

class SortingViewListSectionView extends StatelessWidget {
  String view;
  Function opTap;

  SortingViewListSectionView({required this.view, required this.opTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ViewListView(
        view: view,
      ),
      onTap: () {
        opTap();
      },
    );
  }
}

class SortingSectionView extends StatelessWidget {
  Function onTap;
  String val;

  SortingSectionView({required this.onTap, required this.val});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SortingView(val: val),
      onTap: () {
        onTap();
      },
    );
  }
}
