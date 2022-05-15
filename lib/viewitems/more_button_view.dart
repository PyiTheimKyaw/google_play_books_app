import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/pages/add_book_to_shelf_page.dart';
import 'package:google_play_books_app/resources/colors.dart';
import 'package:google_play_books_app/resources/dimens.dart';
import 'package:google_play_books_app/viewitems/book_and_row_title_view.dart';

class MoreButtonView extends StatelessWidget {
  bool isLibrary;
  BookVO? book;

  MoreButtonView({this.isLibrary = false, required this.book});

  Text text(String text) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
    );
  }

// TextStyle _textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 12);

  Icon _icon(IconData icon) {
    return Icon(
      icon,
      color: ICON_COLOR,
      size: 25,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_MEDIUM_2),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            // left: MARGIN_MEDIUM_2,
                            top: MARGIN_MEDIUM_3,
                            bottom: MARGIN_MEDIUM_2),
                        child: BookAAndTitleRowView(
                          book: book,
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black26,
                      ),
                      SizedBox(
                        height: MARGIN_MEDIUM,
                      ),
                      IconListTileView(
                        icon: _icon(Icons.list_alt),
                        text: text("Open Series"),
                      ),
                      SizedBox(
                        height: MARGIN_MEDIUM_2,
                      ),
                      IconListTileView(
                        icon: _icon(Icons.download_rounded),
                        text: text("Download"),
                      ),
                      SizedBox(
                        height: MARGIN_MEDIUM_2,
                      ),
                      IconListTileView(
                        icon: _icon(Icons.delete),
                        text: text("Delete from library"),
                      ),
                      SizedBox(
                        height: MARGIN_MEDIUM_2,
                      ),
                      IconListTileView(
                        icon: _icon(Icons.download_done_outlined),
                        text: text("Mark as Finished"),
                      ),
                      SizedBox(
                        height: MARGIN_MEDIUM_2,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddBookToShelfPage(
                                            book: book,
                                          )))
                              .then((value) => Navigator.pop(context));
                        },
                        child: IconListTileView(
                          icon: _icon(Icons.add),
                          text: text("Add to shelf"),
                        ),
                      ),
                      SizedBox(
                        height: MARGIN_MEDIUM_2,
                      ),
                      IconListTileView(
                        icon: _icon(Icons.collections_bookmark_rounded),
                        text: text("About this eBook"),
                      ),
                    ],
                  ),
                );
              });
        },
        child: Icon(
          Icons.more_horiz,
          color: (!isLibrary) ? Colors.white : ICON_COLOR,
        ));
  }
}

class IconListTileView extends StatelessWidget {
  Icon icon;
  Text text;

  IconListTileView({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(
          width: MARGIN_MEDIUM,
        ),
        text,
      ],
    );
  }
}
