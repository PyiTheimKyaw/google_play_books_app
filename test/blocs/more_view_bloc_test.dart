import 'package:flutter_test/flutter_test.dart';
import 'package:google_play_books_app/blocs/more_view_bloc.dart';

import '../data.models/book_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("More View Bloc test", () {
    MoreViewBloc? moreViewBloc;
    setUp(() {
      moreViewBloc = MoreViewBloc("", 0, BookModelImplMock());
    });

    test("Fetch View More list test", () {
      expect(
          moreViewBloc?.categoryList
              ?.contains(getMockBookListForViewMore().first),
          true);
    });
  });
}
