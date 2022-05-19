import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_play_books_app/blocs/search_bloc.dart';

import '../data.models/book_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){
  group("Search bloc test", (){
    SearchBloc? searchBloc;
    Function deepEq = ListEquality().equals;
    setUp((){
      searchBloc=SearchBloc(BookModelImplMock());
    });

    test("Search books list test", (){
      deepEq(searchBloc?.allSearchedBooks, getMockBook());
    });
  });

}