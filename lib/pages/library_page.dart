// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_play_books_app/blocs/library_bloc.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/pages/add_new_shelf_page.dart';
import 'package:google_play_books_app/pages/review_shelf_page.dart';
import 'package:google_play_books_app/resources/colors.dart';
import 'package:google_play_books_app/resources/dimens.dart';
import 'package:google_play_books_app/resources/strings.dart';
import 'package:google_play_books_app/viewitems/sorting_view.dart';
import 'package:google_play_books_app/viewitems/view_list_view.dart';
import 'package:google_play_books_app/widgets/your_books_by_grid_section_view.dart';
import 'package:google_play_books_app/widgets/your_books_by_large_grid_section_view.dart';
import 'package:google_play_books_app/widgets/your_books_by_list_section_view.dart';
import 'package:provider/provider.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  int bookCount = 1;
  List<String>? dummyShelf;
  TextEditingController shelfName = TextEditingController();
  TextEditingController editShelfName = TextEditingController();
  List<BookVO>? recentBooks;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LibraryBloc>.value(
      value: LibraryBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 2,
          bottom: TabBar(
            controller: tabController,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black38,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(
                text: YOUR_BOOKS,
              ),
              Tab(
                text: SHELVES,
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          // padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: TabBarView(controller: tabController, children: [
            Consumer<LibraryBloc>(
              builder: (context, bloc, child) => YourBooksSectionView(
                selectedCategoriesList: bloc.selectedCategoriesStringList,
                categoriesStringList: bloc.categoriesStringList ?? [],
                recentBooksList: (bloc.booksByCategory.isEmpty)
                    ? (bloc.selectedCategoriesStringList.isNotEmpty)? null :bloc.recentBooks
                    : bloc.booksByCategory,
                byType: bloc.byType,
                byView: bloc.byView,
                onTapType: (value) {
                  LibraryBloc bloc = Provider.of(context, listen: false);
                  bloc.sortByType(value, context);
                },
                onTapView: (value) {
                  LibraryBloc bloc = Provider.of(context, listen: false);
                  bloc.sortByView(value, context);
                },
                onSelected: (bool value) {
                  bloc.selectOrUnselectBool(value);
                },
                onSelectCategory: (index) {
                  bloc.selectOrUnselectCategory(index);
                  print(
                      "Book category => ${bloc.categoriesStringList?[index]}");
                },
                onSelectedCategoryList: (bool value){
                // bloc.unselectBool(value);
                  },
                onSelectedCategory: (index){
                  bloc.unselectCategory(index);
                },
                onTapClose: (){
                  bloc.clearCategories();
                },
              ),
            ),

            ///Shelves
            // Container(),
            ShelvesSectionView(
              booksList: recentBooks ?? [],
              dummyShelf: dummyShelf ?? [],
              shelfName: shelfName,
              bookCount: bookCount,
              editShelfName: editShelfName,
              onPressedCreate: () {
                dummyShelf?.add(shelfName.text);
              },
            ),
          ]),
        ),
      ),
    );
  }
}

class YourBooksSectionView extends StatelessWidget {
  String byType;
  String byView;
  List<BookVO>? recentBooksList;
  final Function(String?) onTapType;
  final Function(String?) onTapView;
  final List<String?>? categoriesStringList;
  final List<String?>? selectedCategoriesList;
  final ValueChanged<bool> onSelected;
  final ValueChanged<bool> onSelectedCategoryList;
  final Function(int) onSelectCategory;
  final Function(int) onSelectedCategory;
  final Function onTapClose;

  YourBooksSectionView({
    required this.byType,
    required this.byView,
    required this.recentBooksList,
    required this.onTapType,
    required this.onTapView,
    required this.categoriesStringList,
    required this.onSelected,
    required this.onSelectedCategoryList,
    required this.onSelectCategory,
    required this.selectedCategoriesList,
    required this.onSelectedCategory,
    required this.onTapClose,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: Colors.black26,
          thickness: 1,
        ),
        Container(
          height: 70,
          width: double.infinity,
          child: Row(
            children: [
              Flexible(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Row(
                      children: [
                        Visibility(
                            visible: selectedCategoriesList?.isNotEmpty ?? false,
                            child: GestureDetector(
                                onTap: (){
                                  onTapClose();
                                },
                                child: Icon(Icons.close))),
                        ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            ...List.generate(
                              selectedCategoriesList?.length ?? 0,
                              (index) => CategoryItem(
                                isSelectedCategory: true,
                                  categoriesStringList:
                                      selectedCategoriesList?[index],
                                  onSelected: (isSelect) {
                                  onSelectedCategoryList(isSelect);
                                  onSelectedCategory(index);
                                    // onSelected(isSelect);
                                    // onSelectCategory(index);
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        ...List.generate(
                            categoriesStringList?.length ?? 0,
                            (index) => CategoryItem(
                                onSelected: (isSelect) {
                                  onSelected(isSelect);
                                  onSelectCategory(index);
                                },
                                categoriesStringList:
                                    categoriesStringList?[index]))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // CategoriesView(
        //   categoriesStringList: categoriesStringList,
        //   onSelected: onSelected,
        //   isSelected: isSelected,
        // ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
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

class CategoryItem extends StatefulWidget {
  const CategoryItem({
    Key? key,
    required this.categoriesStringList,
    required this.onSelected,
    this.isSelectedCategory=false,
  }) : super(key: key);

  final String? categoriesStringList;
  final ValueChanged<bool> onSelected;
  final bool isSelectedCategory;

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.onSelected(isSelected);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(MARGIN_MEDIUM),
        child: Chip(
          elevation: 0.4,
          backgroundColor: (widget.isSelectedCategory) ? Colors.blue:Colors.white,
          shape: StadiumBorder(
            side: BorderSide(
              color: Color.fromRGBO(234, 234, 234, 1.0),
            ),
          ),
          label: Text(
            widget.categoriesStringList ?? "",
            style: TextStyle(color: ICON_COLOR),
          ),
        ),
      ),
    );
  }
}

class CategoriesView extends StatelessWidget {
  final List<String?>? categoriesStringList;
  final ValueChanged<int> onSelected;
  final bool isSelected;

  CategoriesView(
      {required this.categoriesStringList,
      required this.onSelected,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          scrollDirection: Axis.horizontal,
          itemCount: categoriesStringList?.length ?? 0,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                onSelected(index);
              },
              child: CategoriesItemView(
                isSelected: isSelected,
                categoriesStringList: categoriesStringList?[index],
                index: index,
              ),
            );
          }),
    );
  }
}

class CategoriesItemView extends StatelessWidget {
  final bool isSelected;
  final String? categoriesStringList;
  final int index;

  CategoriesItemView(
      {required this.isSelected,
      required this.categoriesStringList,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: (isSelected) ? Border.all(width: 2, color: Colors.black) : null,
      ),
      child: Text(
        categoriesStringList ?? "",
      ),
    );
    //   Chip(
    //   elevation: 0.4,
    //   backgroundColor: (isSelected == true) ? Colors.blue : Colors.white,
    //   shape: StadiumBorder(
    //     side: BorderSide(
    //       color: Color.fromRGBO(234, 234, 234, 1.0),
    //     ),
    //   ),
    //   label: Text(
    //     categoriesStringList ?? "",
    //     style: TextStyle(color: ICON_COLOR),
    //   ),
    // );
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

class ShelvesSectionView extends StatefulWidget {
  const ShelvesSectionView({
    Key? key,
    required this.dummyShelf,
    required this.shelfName,
    required this.bookCount,
    required this.editShelfName,
    required this.onPressedCreate,
    required this.booksList,
  }) : super(key: key);

  final List<String> dummyShelf;
  final TextEditingController shelfName;
  final int bookCount;
  final TextEditingController editShelfName;
  final Function onPressedCreate;
  final List<BookVO> booksList;

  @override
  State<ShelvesSectionView> createState() => _ShelvesSectionViewState();
}

class _ShelvesSectionViewState extends State<ShelvesSectionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width / 3,
        height: 50,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddNewShelfPage(
                          shelfNameList: widget.dummyShelf,
                          shelfName: widget.shelfName,
                          onPressedCreate: () {
                            widget.onPressedCreate();
                          },
                        )));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.create), Text("Create New")],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.dummyShelf.length,
        itemBuilder: (BuildContext context, int index) {
          return (widget.dummyShelf.isNotEmpty)
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReviewShelfPage(
                                  booksList: widget.booksList,
                                  shelfName: widget.dummyShelf[index],
                                  editShelfName: widget.editShelfName,
                                  editShelf: () {
                                    setState(() {
                                      widget.dummyShelf[index] =
                                          widget.editShelfName.text;
                                    });
                                  },
                                  deleteShelf: () {
                                    setState(() {
                                      widget.dummyShelf.removeAt(index);
                                    });
                                  },
                                )));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: Colors.white)),
                    height: 100,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              height: 67,
                              width: 70,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://th.bing.com/th/id/OIP.T0yAGl5mXcZHC5Pt5Uc3igHaHa?pid=ImgDet&rs=1"),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SizedBox(
                              width: MARGIN_MEDIUM,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.dummyShelf[index]),
                                Text("${widget.bookCount} book"),
                              ],
                            ),
                            Spacer(),
                            Icon(Icons.navigate_next),
                          ],
                        ),
                        Divider(
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                )
              : Container();
        },
      ),
    );
  }
}
