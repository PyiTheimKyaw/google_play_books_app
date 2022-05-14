// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_play_books_app/blocs/review_shelf_bloc.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/book_vo_test.dart';
import 'package:google_play_books_app/pages/library_page.dart';
import 'package:google_play_books_app/resources/colors.dart';
import 'package:google_play_books_app/resources/dimens.dart';
import 'package:google_play_books_app/viewitems/sorting_view.dart';
import 'package:google_play_books_app/viewitems/view_list_view.dart';
import 'package:google_play_books_app/widgets/your_books_by_grid_section_view.dart';
import 'package:google_play_books_app/widgets/your_books_by_large_grid_section_view.dart';
import 'package:google_play_books_app/widgets/your_books_by_list_section_view.dart';
import 'package:google_play_books_app/widgets/your_books_section_view.dart';
import 'package:provider/provider.dart';

class ReviewShelfPage extends StatefulWidget {
  String shelfName;
  TextEditingController editShelfName = TextEditingController();
  Function() editShelf;
  Function deleteShelf;
  List<BookVO> booksList;

  ReviewShelfPage(
      {required this.shelfName,
      required this.editShelfName,
      required this.editShelf,
      required this.deleteShelf,
      required this.booksList});

  @override
  State<ReviewShelfPage> createState() => _ReviewShelfPageState();
}

class _ReviewShelfPageState extends State<ReviewShelfPage> {
  bool isGrid = false;

  String byType = "Author";
  String byView = "List";

  bool isRename = false;
  String? name;

  _buildTabContext(IndexedWidgetBuilder itemBuilder, int itemCount) =>
      ListView.builder(
        // physics: const ClampingScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReviewShelfBloc>.value(
      value: ReviewShelfBloc(widget.booksList),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 120,
          elevation: 3,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          leadingWidth: 500,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding:
                const EdgeInsets.only(left: MARGIN_MEDIUM_2, top: MARGIN_SMALL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    (!isRename)
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back))
                        : GestureDetector(
                            onTap: () {
                              widget.editShelf();
                              setState(() {
                                isRename = false;
                              });
                            },
                            child: Icon(Icons.download_done_rounded),
                          ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                (!isRename)
                    ? Text(
                        widget.shelfName,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      )
                    : TextField(
                        controller: widget.editShelfName,
                        onChanged: (name) {
                          setState(() {
                            this.name = name;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: widget.shelfName,
                          hintStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        )),
                Visibility(
                  visible: !isRename,
                  child: Text(
                    '${widget.booksList.length} book',
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
                              onTap: () {
                                widget.deleteShelf();
                              },
                            )
                          ])
                ],
              ),
            ),
          ],
        ),
        body: Consumer<ReviewShelfBloc>(
          builder: (context, bloc, child) => (bloc.reviewShelfBooks?.isEmpty ??
                  false)
              ? Center(
                  child: Text(
                      "Tap the menu icon on a book cover , then select 'Add to Shelf'",style: TextStyle(color: ICON_COLOR,fontSize: 14),),
                )
              : YourBooksSectionView(
                  isLibrary: false,
                  selectedCategoriesList: bloc.selectedCategoriesStringList,
                  categoriesStringList: bloc.categoriesStringList ?? [],
                  recentBooksList: (bloc.booksByCategory.isEmpty)
                      ? (bloc.selectedCategoriesStringList.isNotEmpty)
                          ? null
                          : bloc.reviewShelfBooks
                      : bloc.booksByCategory,
                  byType: bloc.byType,
                  byView: bloc.byView,
                  onTapType: (value) {
                    ReviewShelfBloc bloc = Provider.of(context, listen: false);
                    bloc.sortByType(value, context);
                  },
                  onTapView: (value) {
                    ReviewShelfBloc bloc = Provider.of(context, listen: false);
                    bloc.sortByView(value, context);
                  },
                  onSelectCategory: (index) {
                    bloc.selectOrUnselectCategory(index);
                  },
                  onSelectedCategory: (index) {
                    bloc.unselectCategory(index);
                  },
                  onTapClose: () {
                    bloc.clearCategories();
                  },
                ),
        ),
      ),
    );
  }
}
