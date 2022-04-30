import 'package:flutter/material.dart';
import 'package:google_play_books_app/resources/dimens.dart';

class AddNewShelfPage extends StatelessWidget {
  List<String> shelfNameList;
  TextEditingController shelfName=TextEditingController();
  Function onPressedCreate;

  AddNewShelfPage({required this.shelfNameList,required this.shelfName,required this.onPressedCreate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        centerTitle: true,
        leadingWidth: 10,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                onPressedCreate();
                Navigator.pop(context);
              },
              icon: Icon(Icons.download_done_outlined),
              color: Colors.blue,
            ),
            Padding(
              padding: const EdgeInsets.only(left: MARGIN_MEDIUM),
              child: TextField(
                controller: shelfName,
                  decoration: InputDecoration(
                    hintText: "Shelf name",
                    hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,),
                    ),

                  )

              ),
            ),
          ],
        ),
      ),
    );
  }
}
