// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_play_books_app/resources/colors.dart';
import 'package:google_play_books_app/resources/dimens.dart';
import 'package:google_play_books_app/viewitems/book_and_row_title_view.dart';
import 'package:google_play_books_app/viewitems/more_button_view.dart';

class YourBooksByListSectionView extends StatelessWidget {
  TextStyle _textStyle = TextStyle(
    fontWeight: FontWeight.bold,
  );

  YourBooksByListSectionView({Key? key}) : super(key: key);

  Icon _icon(IconData icon) {
    return Icon(
      icon,
      color: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            SizedBox(
              height: MARGIN_MEDIUM,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,s
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BookAAndTitleRowView(),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.,
                  children: [
                    Icon(Icons.download_outlined,color: ICON_COLOR,),
                    SizedBox(
                      width: 12,
                    ),
                    MoreButtonView(isLibrary: true,),
                  ],
                ),
              ],
            ),
          ],
        );
      },

    );
  }
}
