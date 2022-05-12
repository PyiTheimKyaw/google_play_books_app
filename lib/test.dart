// // ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields
//
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:google_play_books_app/data/vos/book_vo_test.dart';
// import 'package:google_play_books_app/dummy/dummy_data.dart';
// import 'package:google_play_books_app/resources/dimens.dart';
// import 'package:google_play_books_app/resources/strings.dart';
// import 'package:google_play_books_app/viewitems/book_item_view.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
//   List<BookVO> booksList = dummyBooks;
//   late TabController _tabController;
//   @override
//   void initState() {
//     // TODO: implement initState
//     _tabController = TabController(length: 2, vsync: this);
//     super.initState();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.only(top: MARGIN_MEDIUM_2),
//         color: Colors.white,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             children: [
//               RecentViewBooks(
//                 booksList: booksList,
//               ),
//               TabBar(
//                 controller: _tabController,
//                 labelColor: Colors.blue,
//                 unselectedLabelColor: Colors.black38,
//                 indicatorSize: TabBarIndicatorSize.label,
//                 tabs: [
//                   Tab(
//                     text: EBOOKS,
//                   ),
//                   Tab(
//                     text: AUDIO_BOOKS,
//                   ),
//                 ],
//               ),
//               TabBarView(
//                   controller: _tabController,
//                   children: [
//                     Text("1"),
//                     Text("1"),
//                   ]),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class RecentViewBooks extends StatelessWidget {
//   List<BookVO> booksList;
//
//   RecentViewBooks({required this.booksList});
//
//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//       options: CarouselOptions(
//         onPageChanged: (index, reason) {},
//         height: MediaQuery.of(context).size.height / 4.8,
//         aspectRatio: 4 / 3,
//         viewportFraction: 0.4,
//         initialPage: 0,
//         enableInfiniteScroll: false,
//         reverse: false,
//         // autoPlay: true,
//         // autoPlayInterval: Duration(seconds: 3),
//         // autoPlayAnimationDuration: Duration(milliseconds: 800),
//         autoPlayCurve: Curves.fastOutSlowIn,
//         enlargeCenterPage: true,
//         // onPageChanged: callbackFunction,
//         scrollDirection: Axis.horizontal,
//       ),
//       items: booksList.map((books) {
//         return BookItemView(booksList: booksList);
//       }).toList(),
//     );
//   }
// }
//
//
