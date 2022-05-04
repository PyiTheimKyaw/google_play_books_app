import 'package:google_play_books_app/data/model/book_model.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';
import 'package:google_play_books_app/network/dataagents/book_data_agent.dart';
import 'package:google_play_books_app/network/dataagents/retrofit_data_agent_impl.dart';

class BookModelImpl extends BookModel{
  static final BookModelImpl _singleton=BookModelImpl._internal();

  factory BookModelImpl(){
    return _singleton;
  }

  BookModelImpl._internal();

  BookDataAgent mDataAgent=RetrofitDataAgentImpl();

  @override
  Future<List<BookVO>?> getBooksList() {
    // TODO: implement getBooksList
    throw UnimplementedError();
  }

  @override
  Future<OverviewVo?> getCategories() {
    return Future.value(mDataAgent.getCategories());
  }

}