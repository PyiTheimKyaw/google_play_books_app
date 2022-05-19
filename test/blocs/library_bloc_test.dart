import 'package:flutter_test/flutter_test.dart';
import 'package:google_play_books_app/blocs/library_bloc.dart';

import '../data.models/book_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Library bloc test", () {
    LibraryBloc? libraryBloc;
    setUp(() {
      libraryBloc = LibraryBloc(BookModelImplMock());
    });
    test("Fetch shelves test", () {
      expect(libraryBloc?.shelfList?.contains(getMockShelves().first), true);
    });
    test("Fetch recent books test", () {
      expect(libraryBloc?.recentBooks?.contains(getMockBook().first), true);
    });
    test("Fetch categories list string  test", () {
      expect(
          libraryBloc?.categoriesStringList
              ?.contains(getMockCategoriesString().first),
          true);
    });
  });
}
