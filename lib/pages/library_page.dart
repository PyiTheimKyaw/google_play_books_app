// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/vos/book_vo_test.dart';
import 'package:google_play_books_app/dummy/dummy_data.dart';
import 'package:google_play_books_app/pages/add_new_shelf_page.dart';
import 'package:google_play_books_app/pages/book_details.dart';
import 'package:google_play_books_app/pages/review_shelf_page.dart';
import 'package:google_play_books_app/resources/colors.dart';
import 'package:google_play_books_app/resources/dimens.dart';
import 'package:google_play_books_app/resources/strings.dart';
import 'package:google_play_books_app/viewitems/sorting_view.dart';
import 'package:google_play_books_app/viewitems/view_list_view.dart';
import 'package:google_play_books_app/widgets/your_books_by_grid_section_view.dart';
import 'package:google_play_books_app/widgets/your_books_by_large_grid_section_view.dart';
import 'package:google_play_books_app/widgets/your_books_by_list_section_view.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool isGrid = false;
  List<BookVOTest> bookList = dummyBooks;
  String byType = "Author";
  String byView = "List";
  int bookCount = 1;
  List<String> dummyShelf = [];
  TextEditingController shelfName = TextEditingController();
  TextEditingController editShelfName = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    isGrid = true;
  }

  _buildTabContext(IndexedWidgetBuilder itemBuilder, int itemCount) =>
      ListView.builder(
        // physics: const ClampingScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      );

  navigateToBookDetails(BuildContext context, int i) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BookDetails(
                  bookList[i],
                  books: bookList,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
        child: TabBarView(controller: tabController, children: [
          YourBooksSectionView(
            bookList: bookList,
            byType: byType,
            byView: byView,
            onTapType: (value) {
              setState(() {
                byType = value!;
              });
              Navigator.pop(context);
            },
            onTapView: (value) {
              setState(() {
                byView = value!;
              });
              Navigator.pop(context);
            },
          ),

          ///Shelves
          ShelvesSectionView(
            booksList: bookList,
            dummyShelf: dummyShelf,
            shelfName: shelfName,
            bookCount: bookCount,
            editShelfName: editShelfName,
            onPressedCreate: () {
              dummyShelf.add(shelfName.text);
            },
          ),
        ]),
      ),
    );
  }
}

class YourBooksSectionView extends StatelessWidget {
  String byType;
  String byView;
  List<BookVOTest> bookList;
  final Function(String?) onTapType;
  final Function(String?) onTapView;

  YourBooksSectionView(
      {required this.byType,
      required this.byView,
      required this.bookList,
      required this.onTapType,
      required this.onTapView});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: Colors.black26,
          thickness: 1,
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
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
              ? YourBooksByListSectionView()
              : (byView == "Small Grid")
                  ? YourBooksByGridSectionView(
                      books: bookList,
                    )
                  : (byView == "Large Grid")
                      ? YourBooksByLargeGridSectionView(books: bookList)
                      : Container(),
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
  final List<BookVOTest> booksList;

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
