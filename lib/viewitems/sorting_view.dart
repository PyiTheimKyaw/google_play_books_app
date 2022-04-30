import 'package:flutter/material.dart';
import 'package:google_play_books_app/resources/colors.dart';

class SortingView extends StatelessWidget {
  const SortingView({
    Key? key,
    required this.val,
  }) : super(key: key);

  final String val;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Sort by: " + val),
        SizedBox(
          width: 4,
        ),
        Icon(
          Icons.menu,color: ICON_COLOR,
        ),
      ],
    );
  }
}