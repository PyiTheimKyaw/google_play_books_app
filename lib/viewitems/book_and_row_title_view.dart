import 'package:flutter/material.dart';

class BookAAndTitleRowView extends StatelessWidget {
  const BookAAndTitleRowView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100,
          width: 65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(
                  "https://m.media-amazon.com/images/P/B07LDW9N57.01._SCLZZZZZZZ_SX500_.jpg",
                ),
                fit: BoxFit.cover),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Attract the Billionaire Life",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Thomas Jacob",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }
}