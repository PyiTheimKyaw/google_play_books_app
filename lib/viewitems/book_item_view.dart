// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/resources//dimens.dart';
import 'package:google_play_books_app/resources/colors.dart';
import 'package:google_play_books_app/viewitems/book_and_row_title_view.dart';
import 'package:google_play_books_app/viewitems/more_button_view.dart';

// ListTile listTile(Icon icon, String title, BuildContext context) {
//   return ListTile(
//     // contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
//     minVerticalPadding: 12,
//     leading: icon,
//     title: Text(
//       title,
//       style: _textStyle,
//     ),
//     onTap: () {
//       Navigator.pop(context);
//     },
//   );
// }



class BookItemView extends StatelessWidget {
  const BookItemView({
    Key? key,
    required this.booksList,
  }) : super(key: key);

  final BookVO booksList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 187,
      width: 170,
      child: Stack(
        children: [
          BookImageView(booksList: booksList),
          MoreButtonAndDownloadOrReadButtonSectionView(),
        ],
      ),
    );
  }
}

class MoreButtonAndDownloadOrReadButtonSectionView extends StatelessWidget {
  const MoreButtonAndDownloadOrReadButtonSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MoreButtonView(),
            Spacer(),
            DownloadOrReadButtonView(),
          ],
        ),
      ),
    );
  }
}

class DownloadOrReadButtonView extends StatelessWidget {
  const DownloadOrReadButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 25,
        height: 25,
        color: Colors.black87,
        child: Center(
            child: Icon(
          Icons.download_done_outlined,
          color: Colors.white,
        )));
  }
}



class BookImageView extends StatelessWidget {
  const BookImageView({
    Key? key,
    required this.booksList,
  }) : super(key: key);

  final BookVO booksList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(booksList.imageUrl),
            fit: BoxFit.cover,
          )),
    );
  }
}
