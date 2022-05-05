import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/buy_links_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';
import 'package:google_play_books_app/network/dataagents/retrofit_data_agent_impl.dart';
import 'package:google_play_books_app/pages/start_page.dart';
import 'package:google_play_books_app/persistence/hive_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:hive/hive.dart';


void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(OverviewVOAdapter());
  Hive.registerAdapter(CategoryVoAdapter());
  Hive.registerAdapter(BookVOAdapter());
  Hive.registerAdapter(BuyLinksVOAdapter());

  await Hive.openBox<OverviewVo>(BOX_NAME_OVERVIEW_VO);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartPage(),
    );
  }
}
