import 'package:flutter/material.dart';
import 'package:google_play_books_app/resources/colors.dart';
import 'package:google_play_books_app/resources/dimens.dart';

class ViewListView extends StatelessWidget {
   ViewListView({
    Key? key,

     required this.view,
  }) : super(key: key);


  final String view;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("View: "+view),
        SizedBox(
          width: MARGIN_SMALL / 2,
        ),
        Icon(Icons.list_alt ,color: ICON_COLOR,size: MARGIN_MEDIUM_2+2,),
      ],
    );
  }
}