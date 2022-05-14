import 'package:flutter/material.dart';
import 'package:google_play_books_app/blocs/library_bloc.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/resources/colors.dart';
import 'package:google_play_books_app/widgets/shelf_section_view.dart';
import 'package:provider/provider.dart';

class AddBookToShelfPage extends StatelessWidget {
  BookVO? book;

  AddBookToShelfPage({required this.book});

  @override
  Widget build(BuildContext context) {
    TextEditingController shelfName = TextEditingController();
    TextEditingController editShelfName = TextEditingController();
    return ChangeNotifierProvider<LibraryBloc>.value(
      value: LibraryBloc(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: ICON_COLOR,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Add to shelf",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 18),
          ),
        ),
        body: Consumer<LibraryBloc>(
          builder: (context, bloc, child) => ShelvesSectionView(
            toViewShelfDetails: false,
            booksList: bloc.recentBooks ?? [],
            shelfName: shelfName,
            bookCount: 1,
            editShelfName: editShelfName,
            onPressedCreate: (shelfName) {
              bloc.addNewShelf(shelfName);
            },
            addToShelf: (shelfName,index){
              bloc.addToShelf(book, shelfName, index);
              Navigator.pop(context);
            },
            shelfList: bloc.shelfList,
          ),
        ),
      ),
    );
  }
}
