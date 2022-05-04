// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_play_books_app/pages/home_page.dart';
import 'package:google_play_books_app/pages/library_page.dart';
import 'package:google_play_books_app/pages/search_page.dart';
import 'package:google_play_books_app/pages/search_page_test.dart';
import 'package:google_play_books_app/resources//dimens.dart';
import 'package:google_play_books_app/resources//strings.dart';
import 'package:google_play_books_app/widgets/debounce.dart';

NavigationDestination navigationDestination(
    {required Icon selectedIcon,
    required Icon unSelectedIcon,
    required String label}) {
  return NavigationDestination(
    selectedIcon: selectedIcon,
    icon: Icon(Icons.home_outlined),
    label: label,
  );
}

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  ///State Variables
  List<Widget> pages = [
    HomePage(),
    LibraryPage(),
  ];
  int _currentIndex = 0;
  final _debouncer = DebouncerClass(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(

        backgroundColor: Colors.white,
        elevation: 0,
        title: SearchAndProfileSectionView(
          debouncer: _debouncer,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: MARGIN_MEDIUM_2),
        child: pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBarSectionView(
        currentIndex: _currentIndex,
        changePage: (i) {
          setState(() {
            _currentIndex = i;
          });
        },
      ),
    );
  }
}

class BottomNavigationBarSectionView extends StatefulWidget {
  int currentIndex;
  Function(int) changePage;

  BottomNavigationBarSectionView(
      {required this.currentIndex, required this.changePage});

  @override
  State<BottomNavigationBarSectionView> createState() =>
      _BottomNavigationBarSectionViewState();
}

class _BottomNavigationBarSectionViewState
    extends State<BottomNavigationBarSectionView> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: MediaQuery.of(context).size.height / 12,
      backgroundColor: Colors.white,
      selectedIndex: widget.currentIndex,
      onDestinationSelected: (int newIndex) {
        widget.changePage(newIndex);
      },
      destinations: [
        NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: Colors.blueAccent,
            ),
            icon: Icon(Icons.home_outlined),
            label: BOTTOM_NAVI_HOME),
        NavigationDestination(
            selectedIcon:
                Icon(Icons.library_books_outlined, color: Colors.blueAccent),
            icon: Icon(Icons.library_books_outlined),
            label: BOTTOM_NAVI_LIBRARY),
      ],
    );
  }
}

class SearchAndProfileSectionView extends StatelessWidget {

  SearchAndProfileSectionView({
    Key? key,
    required this.debouncer,
  }) : super(key: key);
  final DebouncerClass debouncer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 18,
          width: MediaQuery.of(context).size.width / 1.09,
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(MARGIN_MEDIUM),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black54.withOpacity(0.1),
                spreadRadius: 4,
                blurRadius: 3,
                offset: Offset(0, 9),
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search,
                color: Colors.black54,
              ),
              SizedBox(
                width: MARGIN_MEDIUM_2,
              ),
              Expanded(
                child: TextField(
                  // autofocus: true,
                  decoration: InputDecoration(
                    hintText: SEARCH_PLAY_BOOKS,
                    hintStyle: TextStyle(
                      color: Colors.black54,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (String text) {
                    debouncer.run(() {
                      print(text);
                    });
                  },
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchPage()));
                  },
                ),
              ),
              ProfileView(),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: MARGIN_MEDIUM_2,
      child: ClipOval(
        child: Image.network(
            "https://th.bing.com/th/id/OIP.BK0uNDyYSQRsZwmpAFB39QHaHa?pid=ImgDet&rs=1"),
      ),
    );
  }
}
