// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_play_books_app/blocs/book_details_bloc.dart';
import 'package:google_play_books_app/data/model/book_model.dart';
import 'package:google_play_books_app/data/model/book_model_impl.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/book_vo_test.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';
import 'package:google_play_books_app/resources/colors.dart';
import 'package:google_play_books_app/resources/constant.dart';
import 'package:google_play_books_app/resources/dimens.dart';
import 'package:google_play_books_app/viewitems/book_item_view.dart';
import 'package:google_play_books_app/viewitems/categories_label_and_more_view.dart';
import 'package:google_play_books_app/viewitems/review.dart';
import 'package:google_play_books_app/widgets/title_and_horizontal_books_list_view.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

Icon icon(IconData icon) {
  return Icon(
    icon,
    color: ICON_COLOR,
  );
}

class BookDetails extends StatelessWidget {
  final List<BookVO>? books;
  final BookVO? book;
  List<CategoryVO>? category;
  String? bookTitle;
  String list;
  int categoryIndex;
  int bookIndex;

  BookDetails(
      {this.categoryIndex = 0,
      this.bookIndex = 0,
      required this.book,
      required this.books,
      required this.category,
      required this.bookTitle,
      required this.list});

  @override
  Widget build(BuildContext context) {
    _navigateToBookDetails(
      context,
      int? categoryIndex,
      int? title,
      String? bookTitle,
      BookVO? book,
      List<CategoryVO>? categoriesList,
    ) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BookDetails(
                    categoryIndex: categoryIndex ?? 0,
                    book:
                        categoriesList?[categoryIndex ?? 0].books?[title ?? 0],
                    books: [],
                    bookTitle: bookTitle,
                    category: categoriesList,
                    list: categoriesList?[categoryIndex ?? 0].listNameEncoded ??
                        "",
                  )));
    }

    List<double> ratings = [0.1, 0.3, 0.5, 0.7, 0.9];
    return ChangeNotifierProvider<BookDetailsBloc>.value(
      value: BookDetailsBloc(book!),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          iconTheme: IconThemeData(color: ICON_COLOR),
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop(true);
              },
              child: Icon(
                Icons.chevron_left,
                color: ICON_COLOR,
              )),
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
                  child: BookDetailsSectionView(
                    bookTitle: book?.title ?? "",
                    book: book,
                  ),
                ),
                AboutBookTypeAndReviewSectionView(),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                ButtonSectionView(),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                AboutEbooksSectionView(
                  book: book,
                  category: null,
                ),
                AboutTheAuthorSectionView(
                  category: null,
                ),
                RatingAndReviewsSectionView(ratings: ratings),
                Consumer<BookDetailsBloc>(
                  builder: (context, bloc, child) =>
                      GoogleBooksHorizontalListSectionView(
                    index: 1,
                    category: bloc.categoriesList?[categoryIndex],
                    categoryIndex: 1,
                    books: bloc.categoriesList?[categoryIndex].books,
                    booksCategoriesLabel: "Similar Ebooks",
                    navigateToDetails: (categoryIndex, index) {
                      BookDetailsBloc bloc =
                          Provider.of(context, listen: false);
                      _navigateToBookDetails(context, index, categoryIndex,
                          bookTitle, book, bloc.categoriesList);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => BookDetails(
                      //       book:  widget.book,
                      //       bookTitle: widget.bookTitle,
                      //       books: categoriesList?[0].books,
                      //       category: categoriesList,
                      //       list: "",
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RatingAndReviewsSectionView extends StatelessWidget {
  const RatingAndReviewsSectionView({
    Key? key,
    required this.ratings,
  }) : super(key: key);

  final List<double> ratings;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CategoriesLabelAndMoreView(
            index: 1,
            booksCategoriesLabel: "Rating And Reviews",
            category: null,
          ),
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "4.5",
                          style: TextStyle(
                            fontSize: 48.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SmoothStarRating(
                        starCount: 5,
                        rating: 4.5,
                        size: 15.0,
                        color: Colors.blue,
                        borderColor: Colors.blue,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        "52 Total",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: ICON_COLOR,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: 270.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Text(
                          "${index + 1}",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(width: 8.0),
                        LinearPercentIndicator(
                          lineHeight: 8.0,
                          // linearStrokeCap: LinearStrokeCap.roundAll,
                          width: MediaQuery.of(context).size.width / 1.7,
                          animation: true,
                          animationDuration: 2500,
                          percent: ratings[index],
                          progressColor: Colors.blue,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
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
  AboutTheAuthorSectionView({
    Key? key,
    required this.category,
  }) : super(key: key);

  CategoryVO? category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: MediaQuery.of(context).size.height / 5,
      child: Column(
        children: [
          CategoriesLabelAndMoreView(
            index: 1,
            booksCategoriesLabel: "About the author",
            category: category,
          ),
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
  AboutEbooksSectionView({
    Key? key,
    required this.category,
    required this.book,
  }) : super(key: key);

  CategoryVO? category;
  BookVO? book;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      // height: MediaQuery.of(context).size.height / 5,
      child: Column(
        children: [
          CategoriesLabelAndMoreView(
            index: 1,
            booksCategoriesLabel: "About this eBook",
            category: category,
          ),
          Text(
            book?.description ?? "",
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
  BookDetailsSectionView({
    Key? key,
    required this.bookTitle,
    required this.book,
  }) : super(key: key);

  String? bookTitle;
  BookVO? book;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BookItemView(
          book: book,
          bookTitle: bookTitle,
        ),
        SizedBox(
          width: 16,
        ),
        BookDetailsView(
          book: book,
        ),
      ],
    );
  }
}

class BookDetailsView extends StatelessWidget {
  BookDetailsView({
    Key? key,
    required this.book,
  }) : super(key: key);
  BookVO? book;

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
              book?.title ?? "",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              book?.author ?? "",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            Text(
              book?.contributor ?? "",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
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
