// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/model/book_model.dart';
import 'package:google_play_books_app/data/model/book_model_impl.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/book_vo_test.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
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
  List<BookVO>? booksList;
  late TabController _tabController;
  late ScrollController _scrollController;

  BookModel mBookModel = BookModelImpl();
  List<CategoryVO>? categoriesList;

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    _tabController = TabController(length: 2, vsync: this);

    ///Api call
    mBookModel.getCategories().then((overview) {
      setState(() {
        categoriesList = overview?.lists;
      });
      print("Category list length => ${categoriesList?.length}");
    });

    super.initState();
  }

  navigateToBookDetails(BuildContext context, int? categoryIndex,int? title) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BookDetails(
                  categoriesList?[categoryIndex?? 0].books?[title ?? 0],
                  books: booksList ?? [],
                  bookTitle: "title",
                  category: categoriesList?[1],
                )));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MARGIN_MEDIUM_2),
        color: Colors.white,
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                // RecentBooksListSectionView(booksList: categoriesList),
                TabsSectionView(tabController: _tabController),
                DividerSectionView(),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                EbooksSectionView(
                    category: categoriesList,
                    booksList: booksList,
                    navigatePage: (categoryIndex,index) {
                      navigateToBookDetails(
                        context,
                        categoryIndex,
                        index,
                      );
                    }),
                AudioBooksSectionView(
                    category: categoriesList,
                    booksList: booksList,
                    navigatePage: (categoryIndex,index) {
                      navigateToBookDetails(context,categoryIndex, index);
                    }),
              ],
            )),
      ),
    );
  }
}

class EbooksSectionView extends StatelessWidget {
  final List<BookVO>? booksList;
  final Function(int?,int?) navigatePage;
  List<CategoryVO>? category;

  EbooksSectionView(
      {required this.booksList,
      required this.navigatePage,
      required this.category});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: category?.length ?? 0,
        itemBuilder: (context, index) {
          return GoogleBooksHorizontalListSectionView(
            books: category?[index].books ?? [],
            category: category?[index],
            categoryIndex: index,
            navigateToDetails: (index,title) {
              navigatePage(index,title);
            },
            booksCategoriesLabel: category?[index].listName ?? "",
          );
        });
  }
}

class AudioBooksSectionView extends StatelessWidget {
  final List<BookVO>? booksList;
  final Function(int?,int?) navigatePage;
  List<CategoryVO>? category;

  AudioBooksSectionView(
      {required this.booksList,
      required this.navigatePage,
      required this.category});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: booksList?.length,
        itemBuilder: (context, index) {
          return GoogleBooksHorizontalListSectionView(
            category: category?[index],
            categoryIndex: index,
            books: booksList,
            navigateToDetails: (index,title) {
              navigatePage(index,title);
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

  final List<CategoryVO>? booksList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: RecentViewBooks(booksList: booksList),
    );
  }
}

class RecentViewBooks extends StatelessWidget {
  List<CategoryVO>? booksList;

  RecentViewBooks({required this.booksList});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: booksList?[1].books?.length,
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
          child: Container(),
        );
      },
    );
  }
}
