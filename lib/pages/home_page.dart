// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_play_books_app/blocs/home_bloc.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/book_vo_test.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/dummy/dummy_data.dart';
import 'package:google_play_books_app/pages/book_details.dart';
import 'package:google_play_books_app/resources/dimens.dart';
import 'package:google_play_books_app/resources/strings.dart';
import 'package:google_play_books_app/viewitems/book_item_view.dart';
import 'package:google_play_books_app/widgets/title_and_horizontal_books_list_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<BookVOTest> booksList = dummyBooks;
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  navigateToBookDetails(BuildContext context, int i) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Container()));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: MARGIN_MEDIUM_2),
          color: Colors.white,
          child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  Consumer<HomeBloc>(
                      builder: (context, bloc, child) =>
                          RecentBooksListSectionView(
                              booksList: bloc.bookList ?? [])),
                  TabsSectionView(tabController: _tabController),
                  DividerSectionView(),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  Consumer<HomeBloc>(
                    builder: (context, bloc, Widget? child) =>
                        EbooksSectionView(
                      booksList: [],
                      navigatePage: (index) {
                        navigateToBookDetails(context, index);
                      },
                      categoriesList: bloc.categoriesList,
                    ),
                  ),
                  AudioBooksSectionView(
                      booksList: [],
                      navigatePage: (index) {
                        navigateToBookDetails(context, index);
                      }),
                ],
              )),
        ),
      ),
    );
  }
}

class EbooksSectionView extends StatelessWidget {
  final List<BookVO> booksList;
  final List<CategoryVO>? categoriesList;
  final Function(int) navigatePage;

  EbooksSectionView(
      {required this.booksList,
      required this.navigatePage,
      required this.categoriesList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: categoriesList?.length,
        itemBuilder: (context, index) {
          return GoogleBooksHorizontalListSectionView(
            books: categoriesList?[index].books,
            navigateToDetails: () {
              navigatePage(index);
            },
            booksCategoriesLabel: categoriesList?[index].listName ?? "",
          );
        });
  }
}

class AudioBooksSectionView extends StatelessWidget {
  final List<BookVO> booksList;
  final Function(int) navigatePage;

  AudioBooksSectionView({required this.booksList, required this.navigatePage});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: booksList.length,
        itemBuilder: (context, index) {
          return GoogleBooksHorizontalListSectionView(
            books: booksList,
            navigateToDetails: () {
              navigatePage(index);
            },
            booksCategoriesLabel: "Tales of terror & intrigue",
          );
        });
  }
}

class DividerSectionView extends StatelessWidget {
  const DividerSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Divider(
        color: Colors.black26,
        thickness: 1,
      ),
    );
  }
}

class TabsSectionView extends StatelessWidget {
  const TabsSectionView({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: MARGIN_MEDIUM),
        child: TabBar(
          controller: _tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black38,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Tab(
              text: EBOOKS,
            ),
            Tab(
              text: AUDIO_BOOKS,
            ),
          ],
        ),
      ),
    );
  }
}

class RecentBooksListSectionView extends StatelessWidget {
  const RecentBooksListSectionView({
    Key? key,
    required this.booksList,
  }) : super(key: key);

  final List<BookVO> booksList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: RecentViewBooks(booksList: booksList),
    );
  }
}

class RecentViewBooks extends StatelessWidget {
  List<BookVO> booksList;

  RecentViewBooks({required this.booksList});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: booksList.length,
      options: CarouselOptions(
        onPageChanged: (index, reason) {},
        height: MediaQuery.of(context).size.height / 3.5,
        aspectRatio: 4 / 3,
        viewportFraction: 0.4,
        initialPage: 0,
        enableInfiniteScroll: false,
        reverse: false,
        // autoPlay: true,
        // autoPlayInterval: Duration(seconds: 3),
        // autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        // onPageChanged: callbackFunction,
        scrollDirection: Axis.horizontal,
      ),
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return Container(
            margin: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 12),
                )
              ],
            ),
            child: BookItemView(booksList: booksList[realIndex]));
      },
    );
  }
}
