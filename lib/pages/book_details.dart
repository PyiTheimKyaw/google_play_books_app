// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/resources/colors.dart';
import 'package:google_play_books_app/resources/dimens.dart';
import 'package:google_play_books_app/viewitems/book_item_view.dart';
import 'package:google_play_books_app/viewitems/categories_label_and_more_view.dart';
import 'package:google_play_books_app/widgets/title_and_horizontal_books_list_view.dart';

Icon icon(IconData icon) {
  return Icon(
    icon,
    color: ICON_COLOR,
  );
}

class BookDetails extends StatelessWidget {
  final List<BookVO> books;
  final BookVO book;

  BookDetails(this.book, {required this.books});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: ICON_COLOR),
        backgroundColor: Colors.white,
        actions: [
          icon(Icons.search),
          SizedBox(
            width: 8,
          ),
          icon(Icons.bookmark_add_outlined),
          SizedBox(
            width: 8,
          ),
          icon(Icons.more_vert),
          SizedBox(
            width: MARGIN_MEDIUM_2,
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_MEDIUM_3),
                child: BookDetailsSectionView(book: book),
              ),
              AboutBookTypeAndReviewSectionView(),
              SizedBox(
                height: MARGIN_LARGE,
              ),
              ButtonSectionView(),
              SizedBox(
                height: MARGIN_LARGE,
              ),
              AboutEbooksSectionView(books: books),
              AboutTheAuthorSectionView(books: books),
              GoogleBooksHorizontalListSectionView(
                books: books,
                booksCategoriesLabel: "Similar Ebooks",
                navigateToDetails: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetails(
                        book,
                        books: books,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AboutBookTypeAndReviewSectionView extends StatelessWidget {
  const AboutBookTypeAndReviewSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: MARGIN_MEDIUM_2, horizontal: MARGIN_MEDIUM_2),
      width: MediaQuery.of(context).size.width,
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text("4.6"),
                  icon(
                    Icons.star,
                  ),
                ],
              ),
              Text("24 reviews"),
            ],
          ),
          VerticalDivider(
            color: ICON_COLOR,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon(Icons.bookmark_add_outlined),
              Text("ebook"),
            ],
          ),
          VerticalDivider(
            color: ICON_COLOR,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("256"),
              Text("Pages"),
            ],
          ),
          VerticalDivider(
            color: ICON_COLOR,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon(Icons.favorite_border_rounded),
              Text("Eligible"),
            ],
          ),
        ],
      ),
    );
  }
}

class AboutTheAuthorSectionView extends StatelessWidget {
  const AboutTheAuthorSectionView({
    Key? key,
    required this.books,
  }) : super(key: key);

  final List<BookVO> books;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: MediaQuery.of(context).size.height / 5,
      child: Column(
        children: [
          CategoriesLabelAndMoreView(
              books: books, booksCategoriesLabel: "About the author"),
          Text(
            "Project Hail Mary is a 2021 science fiction novel by American novelist Andy Weir. Set in "
            "the near future, the novel centers on junior high (middle) school-teacher-turned-astronaut "
            "Ryland Grace, who wakes up from a coma afflicted with amnesia. He gradually remembers that he was sent "
            "to the Tau ",
            style: TextStyle(letterSpacing: 0.5),
          ),
        ],
      ),
    );
  }
}

class AboutEbooksSectionView extends StatelessWidget {
  const AboutEbooksSectionView({
    Key? key,
    required this.books,
  }) : super(key: key);

  final List<BookVO> books;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: MediaQuery.of(context).size.height / 5,
      child: Column(
        children: [
          CategoriesLabelAndMoreView(
              books: books, booksCategoriesLabel: "About this eBook"),
          Text(
            "Project Hail Mary is a 2021 science fiction novel by American novelist Andy Weir. Set in "
            "the near future, the novel centers on junior high (middle) school-teacher-turned-astronaut "
            "Ryland Grace, who wakes up from a coma afflicted with amnesia. He gradually remembers that he was sent "
            "to the Tau ",
            style: TextStyle(letterSpacing: 0.5),
          ),
        ],
      ),
    );
  }
}

class ButtonSectionView extends StatelessWidget {
  const ButtonSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BookDetailsScreenButtonView(
          isFreeSample: true,
          buttonLabel: "Free Sample",
        ),
        BookDetailsScreenButtonView(
          buttonLabel: "Buy \$189",
        ),
      ],
    );
  }
}

class BookDetailsSectionView extends StatelessWidget {
  const BookDetailsSectionView({
    Key? key,
    required this.book,
  }) : super(key: key);

  final BookVO book;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BookItemView(
          booksList: book,
        ),
        SizedBox(
          width: 16,
        ),
        BookDetailsView(),
      ],
    );
  }
}

class BookDetailsView extends StatelessWidget {
  const BookDetailsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: 190,
        height: MediaQuery.of(context).size.height / 4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "The Home Edit: A Guide to Organizing and Realizing Your House Goals",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              "Clea Shearer and Joanna Teplin",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            Text(
              "Clarkson Potter",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}

class BookDetailsScreenButtonView extends StatelessWidget {
  final bool isFreeSample;
  final String buttonLabel;

  BookDetailsScreenButtonView(
      {this.isFreeSample = false, required this.buttonLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width / 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: (isFreeSample) ? Colors.white : Colors.blue,
        border: Border.all(width: 1, color: Colors.black26),
      ),
      child: Center(
          child: Text(
        buttonLabel,
        style: TextStyle(
            color: (isFreeSample) ? Colors.blue : Colors.white,
            fontWeight: FontWeight.w600),
      )),
    );
  }
}
