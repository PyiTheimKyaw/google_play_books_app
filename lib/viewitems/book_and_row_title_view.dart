// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';

class BookAAndTitleRowView extends StatelessWidget {
  BookVO? book;


  BookAAndTitleRowView({required this.book});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BookImageView(book: book),
        SizedBox(
          width: 16,
        ),
        Expanded(child: BookTitleAndAuthorView(book: book)),
      ],
    );
  }
}

class BookTitleAndAuthorView extends StatelessWidget {
  const BookTitleAndAuthorView({
    Key? key,
    required this.book,
  }) : super(key: key);

  final BookVO? book;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          book?.title ?? "",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          book?.author ?? "",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
        ),
      ],
    );
  }
}

class BookImageView extends StatelessWidget {
  const BookImageView({
    Key? key,
    required this.book,
  }) : super(key: key);

  final BookVO? book;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            image: NetworkImage(
              book?.bookImage ?? "",
            ),
            fit: BoxFit.cover),
      ),
    );
  }
}