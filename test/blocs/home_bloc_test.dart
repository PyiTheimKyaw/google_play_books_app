// @dart=2.9
import 'package:flutter_test/flutter_test.dart';
import 'package:google_play_books_app/blocs/home_bloc.dart';

import '../data.models/book_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Home Bloc test", () {
    HomeBloc homeBloc;
    setUp(() {
      homeBloc = HomeBloc(BookModelImplMock());
    });
    test("Fetch category list", () {
      expect(
          homeBloc?.categoriesList
              ?.contains(getMockBookListForViewMore().first),
          true);
    });

    test("Fetch recent book", () {
      expect(homeBloc?.recentBooks?.contains(getMockBook().first), true);
    });
  });
}
