// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/model/book_model.dart';
import 'package:google_play_books_app/data/model/book_model_impl.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/book_vo_test.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';
import 'package:google_play_books_app/widgets/your_books_by_grid_section_view.dart';
import 'package:google_play_books_app/widgets/your_books_by_large_grid_section_view.dart';

class MoreViewPage extends StatefulWidget {

  String list;
  int index;

  MoreViewPage({

    required this.list,
    required this.index,
  });

  @override
  State<MoreViewPage> createState() => _MoreViewPageState();
}

class _MoreViewPageState extends State<MoreViewPage> {
  BookModel mBookModel = BookModelImpl();
  List<CategoryVO>? viewMoreList;
  OverviewVo? overview;
  List<BookVO>? books;

  @override
  void initState() {
    print(widget.list);

    mBookModel.getCategories().then((value) {
      setState(() {
        overview = value;
      });
      mBookModel
          .getBooksList(widget.list, overview?.bestSellersDate ?? "",
              overview?.publishedDate ?? "")
          .then((value) {
        setState(() {
          viewMoreList = value;
          books = value?[widget.index].bookDetails;
        });
        print(viewMoreList.toString());
        print("Books => ${books.toString()}");
      }).catchError((error) {
        print("Error ${error.toString()}");
      });

      print("Best sellers ${overview?.bestSellersDate ?? ""}");
      print("Published  ${overview?.publishedDate ?? ""}");
    });

    super.initState();
  }

  // _buildTabContext(IndexedWidgetBuilder itemBuilder, int itemCount) =>
  //     ListView.builder(
  //       // physics: const ClampingScrollPhysics(),
  //       itemCount: itemCount,
  //       itemBuilder: itemBuilder,
  //     );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          viewMoreList?[widget.index].listName ?? "",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 34.0),
        child: YourBooksByGridSectionView(
          isViewMore: true,
          category: viewMoreList,
          books: viewMoreList?[widget.index].bookDetails,
        ),
      ),
    );
  }
}
