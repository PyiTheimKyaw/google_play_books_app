import 'package:flutter/material.dart';
import 'package:google_play_books_app/resources/colors.dart';
import 'package:google_play_books_app/resources/dimens.dart';

class SearchWidget extends StatefulWidget {

  final String searchText;
  final ValueChanged<String> onChanged;
  final Function onTapClear;
  final ValueChanged<String> onTapSubmitted;


  @override
  State<SearchWidget> createState() => _SearchWidgetState();

  SearchWidget({required this.searchText,required this.onChanged,required this.onTapClear,required this.onTapSubmitted});
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search Play Books",
        hintStyle: TextStyle(color: ICON_COLOR),
        border: InputBorder.none,
        suffixIcon: (widget.searchText.isNotEmpty)?Padding(
          padding: const EdgeInsets.only(right: MARGIN_MEDIUM_3),
          child: GestureDetector(
              onTap: (){
                widget.onTapClear;
                controller.clear();
                // widget.onChanged('');
                // FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Icon(Icons.close,color: ICON_COLOR,)),
        ):null,
      ),
      onChanged: widget.onChanged,
      onSubmitted: widget.onTapSubmitted,
    );
  }
}