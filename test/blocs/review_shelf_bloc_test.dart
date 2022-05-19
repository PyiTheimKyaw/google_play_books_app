import 'package:flutter_test/flutter_test.dart';
import 'package:google_play_books_app/blocs/review_shelf_bloc.dart';

import '../data.models/book_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Review shelf bloc test", () {
    ReviewShelfBloc? reviewShelfBloc;
    setUp(() {
      reviewShelfBloc =
          ReviewShelfBloc(getMockBook(), 0, "", BookModelImplMock());
    });
    test("Fetch books from shelf list test", () {
      expect(reviewShelfBloc?.reviewShelfBooks?.contains(getMockBook().first),
          true);
    });
  });
}
