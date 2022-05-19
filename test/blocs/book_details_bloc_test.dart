// @dart=2.9

import 'package:flutter_test/flutter_test.dart';
import 'package:google_play_books_app/blocs/book_details_bloc.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';

import '../data.models/book_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Book Details Bloc Test", () {
    BookDetailsBloc bookDetailsBloc;
    setUp(() {
      bookDetailsBloc = BookDetailsBloc(
          BookVO(
            "",
            null,
            null,
            "Bill Browder",
            null,
            null,
            null,
            null,
            null,
            "",
            null,
            "The author of “Red Notice” tells his story of becoming Vladimir Putin’s enemy by uncovering a \$230 million tax refund scheme.",
            null,
            "0.00",
            "1982153288",
            "9781982153281",
            null,
            "Simon & Schuster",
            null,
            null,
            null,
            "FREEZING ORDER",
            null,
            null,
            null,
            null,
            null,
            null,
            null,
          ),
          BookModelImplMock());
    });

    test("Fetch categories list test", () {
      expect(
          bookDetailsBloc.categoriesList
              ?.contains(getMockBookListForViewMore().first),
          true);
    });

    test("Fetch overview  test", () {
      expect(bookDetailsBloc.overview, getMockOverview());
    });
  });
}
