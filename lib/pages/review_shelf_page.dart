// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_play_books_app/blocs/review_shelf_bloc.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/resources/colors.dart';
import 'package:google_play_books_app/resources/dimens.dart';
import 'package:google_play_books_app/widgets/your_books_section_view.dart';
import 'package:provider/provider.dart';

class ReviewShelfPage extends StatelessWidget {
  String shelfName;
  int index;
  TextEditingController editShelfName = TextEditingController();

  List<BookVO> booksList;

  ReviewShelfPage(
      {required this.shelfName,
      required this.editShelfName,
      required this.index,
      required this.booksList});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReviewShelfBloc>.value(
      value: ReviewShelfBloc(booksList, index, shelfName),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 120,
          elevation: 3,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          leadingWidth: 500,
          automaticallyImplyLeading: false,
          leading: Consumer<ReviewShelfBloc>(
            builder: (context, bloc, child) => Padding(
              padding: const EdgeInsets.only(
                  left: MARGIN_MEDIUM_2, top: MARGIN_SMALL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      (!bloc.isRename)
                          ? GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back))
                          : GestureDetector(
                              onTap: () {
                                bloc.editShelf(shelfName, editShelfName.text);
                              },
                              child: Icon(Icons.download_done_rounded),
                            ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  (!bloc.isRename)
                      ? Text(
                          (editShelfName.text == "")
                              ? bloc.shelfName ?? ""
                              : editShelfName.text,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        )
                      : TextField(
                          controller: editShelfName,
                          onChanged: (name) {},
                          decoration: InputDecoration(
                            hintText: bloc.shelfName,
                            hintStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          )),
                  Visibility(
                    visible: !bloc.isRename,
                    child: Text(
                      '${bloc.reviewShelfBooks?.length} book',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
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
                  Consumer<ReviewShelfBloc>(
                    builder: (context, bloc, child) => PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text("Rename Shelf"),
                                value: 1,
                                onTap: () {
                                  bloc.boolIsRename();
                                },
                              ),
                              PopupMenuItem(
                                child: Text("Delete Shelf"),
                                value: 2,
                                onTap: () {
                                  bloc.deleteShelf();
                                  Navigator.pop(context);
                                },
                              )
                            ]),
                  )
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
                    "Tap the menu icon on a book cover , then select 'Add to Shelf'",
                    style: TextStyle(color: ICON_COLOR, fontSize: 14),
                  ),
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
