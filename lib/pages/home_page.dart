// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_play_books_app/blocs/home_bloc.dart';
import 'package:google_play_books_app/widgets/audio_books_section_view.dart';
import 'package:google_play_books_app/widgets/ebooks_section_view.dart';
import 'package:provider/provider.dart';
import 'package:google_play_books_app/data/model/book_model.dart';
import 'package:google_play_books_app/data/model/book_model_impl.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/book_vo_test.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';
import 'package:google_play_books_app/dummy/dummy_data.dart';
import 'package:google_play_books_app/pages/book_details.dart';
import 'package:google_play_books_app/resources/dimens.dart';
import 'package:google_play_books_app/resources/strings.dart';
import 'package:google_play_books_app/viewitems/book_item_view.dart';
import 'package:google_play_books_app/widgets/title_and_horizontal_books_list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
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
                  Selector<HomeBloc, List<BookVO>?>(
                      selector: (context, bloc) => bloc.recentBooks,
                      shouldRebuild: (previous, next) => previous != next,
                      builder:
                          (BuildContext context, recentBooks, Widget? child) =>
                              Visibility(
                                  visible: recentBooks != [],
                                  child: RecentBooksListSectionView(
                                      booksList: recentBooks))),
                  TabsSectionView(tabController: _tabController),
                  DividerSectionView(),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  Selector<HomeBloc, List<CategoryVO>?>(
                    selector: (context, bloc) => bloc.categoriesList,
                    shouldRebuild: (previous, next) => previous != next,
                    builder: (context, categoryList, child) =>
                        EbooksSectionView(
                            category: categoryList,
                            navigatePage: (categoryIndex, index) {
                              HomeBloc bloc =
                                  Provider.of(context, listen: false);
                              bloc.navigateToBookDetails(
                                context,
                                categoryIndex,
                                index,
                              );
                            }),
                  ),
                  Selector<HomeBloc, List<CategoryVO>?>(
                    selector: (context, bloc) => bloc.categoriesList,
                    shouldRebuild: (previous, next) => previous != next,
                    builder: (context, categoryList, child) =>
                        Selector<HomeBloc, List<BookVO>?>(
                      selector: (context, bloc) => bloc.booksList,
                      shouldRebuild: (previous, next) => previous != next,
                      builder: (context, bookList, child) =>
                          AudioBooksSectionView(
                              category: categoryList,
                              booksList: bookList,
                              navigatePage: (categoryIndex, index) {
                                HomeBloc bloc =
                                    Provider.of(context, listen: false);
                                bloc.navigateToBookDetails(
                                    context, categoryIndex, index);
                              }),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
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

  final List<BookVO>? booksList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: RecentViewBooks(booksList: booksList),
    );
  }
}

class RecentViewBooks extends StatelessWidget {
  List<BookVO>? booksList;

  RecentViewBooks({required this.booksList});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: booksList?.length ?? 0,
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
          child: BookItemView(bookTitle: "", book: booksList?[index]),
        );
      },
    );
  }
}
