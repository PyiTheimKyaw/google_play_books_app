// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/vos/book_vo_test.dart';
import 'package:google_play_books_app/pages/library_page.dart';
import 'package:google_play_books_app/resources/dimens.dart';
import 'package:google_play_books_app/viewitems/sorting_view.dart';
import 'package:google_play_books_app/viewitems/view_list_view.dart';
import 'package:google_play_books_app/widgets/your_books_by_grid_section_view.dart';
import 'package:google_play_books_app/widgets/your_books_by_large_grid_section_view.dart';
import 'package:google_play_books_app/widgets/your_books_by_list_section_view.dart';

class ReviewShelfPage extends StatefulWidget {
   String shelfName;
   TextEditingController editShelfName = TextEditingController();
   Function editShelf;
   Function deleteShelf;
   List<BookVOTest> booksList;
  ReviewShelfPage({required this.shelfName,required this.editShelfName,required this.editShelf,required this.deleteShelf,required this.booksList});

  @override
  State<ReviewShelfPage> createState() => _ReviewShelfPageState();
}

class _ReviewShelfPageState extends State<ReviewShelfPage> {
  bool isGrid = false;

  String byType = "Author";
  String byView="List";

  bool isRename = false;


  _buildTabContext(IndexedWidgetBuilder itemBuilder, int itemCount) =>
      ListView.builder(
        // physics: const ClampingScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        elevation: 3,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        leadingWidth: 200,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding:
              const EdgeInsets.only(left: MARGIN_MEDIUM_2, top: MARGIN_SMALL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (!isRename)
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back))
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.editShelf();
                          widget.shelfName=widget.editShelfName.text;
                          isRename=false;
                        });
                      },
                      child: Icon(Icons.download_done_rounded),
                    ),
              SizedBox(
                height: 20,
              ),
              (!isRename)
                  ? Text(
                      widget.shelfName,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  : TextField(
                      controller: widget.editShelfName,
                      decoration: InputDecoration(
                        hintText: "Shelf name",
                        hintStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      )),
              Visibility(
                visible: !isRename,
                child: Text(
                  '1 book',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(bottom: 58.0, right: MARGIN_MEDIUM_2),
            child: Row(
              children: [
                Icon(Icons.search),
                SizedBox(
                  width: 12,
                ),
                PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text("Rename Shelf"),
                            value: 1,
                            onTap: () {
                              setState(() {
                                isRename = true;
                              });
                            },
                          ),
                          PopupMenuItem(
                            child: Text("Delete Shelf"),
                            value: 2,
                            onTap: (){
                              widget.deleteShelf();
                              Navigator.pop(context);
                            },
                          )
                        ])
              ],
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_MEDIUM_2),
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
              child: (byView=="List")
                  ? YourBooksByListSectionView()
                  : (byView=="Small Grid") ?YourBooksByGridSectionView(
                books: widget.booksList,
              ): (byView=="Large Grid")? YourBooksByLargeGridSectionView(books: widget.booksList):Container(),
            ),
          ],
        ),
      ),
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
                  onTap: (value) {
                    setState(() {
                      byType = value!;
                    });
                    Navigator.pop(context);
                  }),
              RadioWithText(
                  value: "Recent",
                  val: byType,
                  onTap: (value) {
                    setState(() {
                      byType = value!;
                    });
                    Navigator.pop(context);
                  }),
              RadioWithText(
                  value: "Title",
                  val: byType,
                  onTap: (value) {
                    setState(() {
                      byType = value!;
                    });
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }
  Future<dynamic> buildShowModalBottomSheetForSortingView(BuildContext context) {
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
                  onTap: (value) {
                    setState(() {
                      byView = value!;
                    });
                    Navigator.pop(context);
                  }),
              RadioWithText(
                  value: "Small Grid",
                  val: byView,
                  onTap: (value) {
                    setState(() {
                      byView = value!;
                    });
                    Navigator.pop(context);
                  }),
              RadioWithText(
                  value: "Large Grid",
                  val: byView,
                  onTap: (value) {
                    setState(() {
                      byView = value!;
                    });
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }
}
