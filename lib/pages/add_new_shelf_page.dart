import 'package:flutter/material.dart';
import 'package:google_play_books_app/resources/dimens.dart';

class AddNewShelfPage extends StatefulWidget {
  List<String> shelfNameList;
  TextEditingController shelfName=TextEditingController();
  Function(String) onPressedCreate;

  AddNewShelfPage({required this.shelfNameList,required this.shelfName,required this.onPressedCreate});

  @override
  State<AddNewShelfPage> createState() => _AddNewShelfPageState();
}

class _AddNewShelfPageState extends State<AddNewShelfPage> {
  String? shelfListName;
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
                print("Shelf name when crete => ${shelfListName ?? ""}");
                widget.onPressedCreate(shelfListName ?? "");
                Navigator.pop(context);
              },
              icon: Icon(Icons.download_done_outlined),
              color: Colors.blue,
            ),
            Padding(
              padding: const EdgeInsets.only(left: MARGIN_MEDIUM),
              child: TextField(
                controller: widget.shelfName,
                  onChanged: (shelfName){
                  setState(() {
                    shelfListName=shelfName;
                    print("Shelf name => ${shelfListName}");
                  });
                  },
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
