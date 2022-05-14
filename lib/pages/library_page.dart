// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_play_books_app/blocs/library_bloc.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/resources/strings.dart';
import 'package:google_play_books_app/widgets/shelf_section_view.dart';
import 'package:google_play_books_app/widgets/your_books_section_view.dart';
import 'package:provider/provider.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  int bookCount = 1;
  List<String>? dummyShelf;
  TextEditingController shelfName = TextEditingController();
  TextEditingController editShelfName = TextEditingController();
  List<BookVO>? recentBooks;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LibraryBloc>.value(
      value: LibraryBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 2,
          bottom: TabBar(
            controller: tabController,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black38,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(
                text: YOUR_BOOKS,
              ),
              Tab(
                text: SHELVES,
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          // padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: TabBarView(controller: tabController, children: [
            Consumer<LibraryBloc>(
              builder: (context, bloc, child) => YourBooksSectionView(
                selectedCategoriesList: bloc.selectedCategoriesStringList,
                categoriesStringList: bloc.categoriesStringList ?? [],
                recentBooksList: (bloc.booksByCategory.isEmpty)
                    ? (bloc.selectedCategoriesStringList.isNotEmpty)
                        ? null
                        : bloc.recentBooks
                    : bloc.booksByCategory,
                byType: bloc.byType,
                byView: bloc.byView,
                onTapType: (value) {
                  LibraryBloc bloc = Provider.of(context, listen: false);
                  bloc.sortByType(value, context);
                },
                onTapView: (value) {
                  LibraryBloc bloc = Provider.of(context, listen: false);
                  bloc.sortByView(value, context);
                },
                onSelectCategory: (index) {
                  bloc.selectOrUnselectCategory(index);
                },
                onSelectedCategory: (index) {
                  bloc.unselectCategory(index);
                },
                onTapClose: () {
                  bloc.clearCategories();
                },
              ),
            ),

            ///Shelves
            // Container(),
            Consumer<LibraryBloc>(
              builder: (context, bloc, child) => ShelvesSectionView(
                booksList: bloc.recentBooks ?? [],
                shelfName: shelfName,
                bookCount: bookCount,
                editShelfName: editShelfName,
                onPressedCreate: (shelfName) {
                  print('Shelf name data pass => $shelfName');
                  // List<ShelfVO>? shelves;
                  // List<ShelfVO> shelfList=shelves?.map((e) {
                  //   e.shelfName=shelfName;
                  //   e.books=[];
                  //   return e;
                  // }).toList() ?? [];

                  bloc.addNewShelf(shelfName);
                  // print("First index of shelf => ${shelfList.first.shelfName}");
                },

                shelfList: bloc.shelfList,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}








