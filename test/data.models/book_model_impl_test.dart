import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_play_books_app/data/model/book_model_impl.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/shelf_vo.dart';

import '../mock_data/mock_data.dart';
import '../network/book_data_agent_impl_mock.dart';
import '../persistence/book_dao_impl_mock.dart';
import '../persistence/category_dao_impl_mock.dart';
import '../persistence/google_search_book_dao_impl_mock.dart';
import '../persistence/shelf_dao_impl_mock.dart';

void main() {
  group("Book model impl", () {
    var model = BookModelImpl();
    List one = [1, 2, 3];
    List two = [1, 2, 3];
    Function deepEq = ListEquality().equals;
    setUp(() {
      model.setDaosAndDataAgents(
          BookDaoImplMock(),
          CategoryDaoImplMock(),
          GoogleSearchBookDaoImplMock(),
          ShelfDaoImplMock(),
          BookDataAgentImplMock());
    });

    test("Save all books and Get All books from database test", () {
      expect(
        model.getAllBooksFromDatabase(),
        emits(
          [
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
          ],
        ),
      );
    });

    test("Save all recent books and get all recent books from database test",
        () {
      expect(
        model.getAllRecentBooksFromDatabase(),
        emits(
          [
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
          ],
        ),
      );
    });

    test("Save all categories and get all categories from database test ", (){
      expect(model.getCategoriesListFromDatabase(), emits([
        CategoryVO(
            704,
            "Hardcover Nonfiction",
            null,
            "Hardcover Nonfiction",
            null,
            null,
            null,
            null,
            null,
            "2022-04-16",
            "2022-05-01",
            1,
            0,
            1,
            0,
            0,
            "https://www.amazon.com/dp/1982153288?tag=NYTBSREV-20",
            null,
            [
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
              )
            ],
            null)
      ],),);
    });

    test("Save all search books and get all search books from database test", (){
      expect(model.getSearchedBooksFromDatabase('flutter'), emits([
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
      ],),);
    });

    test("Save all categories string list and get all categories string list from database test",(){
      expect(model.getCategoriesStringList(), completion(
        equals(getMockCategoriesString())
      ));
    });
    
    test("Get book list for view more from database test",(){
      expect(model.getBooksListForViewMore("list", "bestSellersDate", "publishedDate"), completion(
        equals(getMockBookListForViewMore())
      ));
    });

    test("Get all shelves database test", () {
      expect(
          model.getAllShelvesFromDatabase(),
          emits(
            [
              ShelfVO(shelfName: "Testing", books: []),
            ],
          ));
    });
  });
}
