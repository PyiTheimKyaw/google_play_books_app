// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/shelf_vo.dart';
import 'package:google_play_books_app/pages/add_new_shelf_page.dart';
import 'package:google_play_books_app/pages/review_shelf_page.dart';
import 'package:google_play_books_app/resources/dimens.dart';

class ShelvesSectionView extends StatelessWidget {
  const ShelvesSectionView({
    Key? key,
    required this.shelfName,
    required this.bookCount,
    required this.editShelfName,
    required this.onPressedCreate,
    required this.booksList,
    required this.shelfList,

    this.addToShelf,
    this.toViewShelfDetails = true,
  }) : super(key: key);

  final List<ShelfVO>? shelfList;
  final TextEditingController shelfName;
  final int bookCount;
  final TextEditingController editShelfName;
  final Function(String) onPressedCreate;
  final List<BookVO> booksList;
  final bool toViewShelfDetails;
  final Function(String,int)? addToShelf;

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
                          shelfName: shelfName,
                          onPressedCreate: onPressedCreate,
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
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: shelfList?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                (toViewShelfDetails)
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReviewShelfPage(
                              index:index,
                                  booksList: shelfList?[index].books ?? [],
                                  shelfName: shelfList?[index].shelfName ?? "",
                                  editShelfName: editShelfName,
                                )))
                    : addToShelf!((shelfList?[index].shelfName ?? ""),index);
              },
              child: ShelfBookListItemView(
                shelfList: shelfList,
                toViewShelfDetails: toViewShelfDetails,
                index: index,
              ),
            );
          },
        ),
      ),
    );
  }
}

class ShelfBookListItemView extends StatelessWidget {
  const ShelfBookListItemView({
    Key? key,
    required this.shelfList,
    required this.toViewShelfDetails,
    required this.index,
  }) : super(key: key);

  final List<ShelfVO>? shelfList;
  final bool toViewShelfDetails;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: MARGIN_SMALL, horizontal: MARGIN_MEDIUM_2),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.white)),
      height: 110,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ((shelfList?[index].books)?.isNotEmpty ?? false)
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      height: 67,
                      width: 70,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                shelfList?[index].books?[0].bookImage ?? ""),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      height: 67,
                      width: 60,
                      color: Colors.black12,
                    ),
              SizedBox(
                width: MARGIN_MEDIUM,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(shelfList?[index].shelfName ?? ""),
                  Text((shelfList?[index].books?.isEmpty ?? false)? "empty" : "${shelfList?[index].books?.length ?? 0} books"),
                ],
              ),
              Spacer(),
              Visibility(
                  visible: toViewShelfDetails,
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.blue,
                    size: 18,
                  )),
            ],
          ),
          Divider(
            color: Colors.black26,
          ),
        ],
      ),
    );
  }
}
