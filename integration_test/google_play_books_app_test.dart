// @dart=2.9
import 'package:flutter_test/flutter_test.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/buy_links_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/google_book_vo.dart';
import 'package:google_play_books_app/data/vos/google_search_vo.dart';
import 'package:google_play_books_app/data/vos/image_link_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';
import 'package:google_play_books_app/data/vos/shelf_vo.dart';
import 'package:google_play_books_app/main.dart';
import 'package:google_play_books_app/pages/start_page.dart';
import 'package:google_play_books_app/persistence/hive_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';

import 'test_data/test_data.dart';

void main()async{
   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
   await Hive.initFlutter();
   Hive.registerAdapter(OverviewVOAdapter());
   Hive.registerAdapter(CategoryVoAdapter());
   Hive.registerAdapter(BookVOAdapter());
   Hive.registerAdapter(BuyLinksVOAdapter());
   Hive.registerAdapter(ImageLinkVOAdapter());
   Hive.registerAdapter(GoogleBookVOAdapter());
   Hive.registerAdapter(GoogleSearchBookVOAdapter());
   Hive.registerAdapter(ShelfVOAdapter());

   await Hive.openBox<OverviewVo>(BOX_NAME_OVERVIEW_VO);
   await Hive.openBox<BookVO>(BOX_NAME_BOOK_VO);
   await Hive.openBox<CategoryVO>(BOX_NAME_CATEGORY_VO);
   await Hive.openBox<BookVO>(BOX_NAME_BOOK_VO_FOR_RECENT);
   await Hive.openBox<GoogleSearchVO>(BOX_NAME_GOOGLE_SEARCH_VO);
   await Hive.openBox<ShelfVO>(BOX_NAME_SHELF_VO);

   testWidgets("Tap book item and Navigate to details", (WidgetTester tester)async{
     await tester.pumpWidget(MyApp());
     await Future.delayed(Duration(seconds: 5));
     await tester.pumpAndSettle(Duration(seconds: 10));

     expect(find.byType(StartPage), findsOneWidget);
     expect(find.text(THE_INVESTIGATOR_BOOK_NAME), findsOneWidget);
   });
}