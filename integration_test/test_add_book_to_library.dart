import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_play_books_app/pages/home_page.dart';
import 'package:google_play_books_app/widgets/ebooks_section_view.dart';

import 'test_data/test_data.dart';

Future<void> testAddBooksToLibrary(WidgetTester tester) async {
  var delaySixSec = const Duration(seconds: 6);
  expect(find.byType(HomePage), findsOneWidget);
  expect(find.byType(EbooksSectionView), findsOneWidget);

  ///Verify first book exists or not
  expect(find.text(THE_INVESTIGATOR_BOOK_NAME), findsOneWidget);

  ///Choose first book
  await tester.tap(find.text(THE_INVESTIGATOR_BOOK_NAME));
  await tester.pumpAndSettle(delaySixSec);
  expect(find.text(THE_INVESTIGATOR_BOOK_NAME), findsWidgets);
  await tester.tap(find.byIcon(Icons.chevron_left));
  await tester.pumpAndSettle(delaySixSec);

  ///Verify recent books
  expect(find.byType(RecentBooksListSectionView), findsOneWidget);

  ///Drag to second book
  await tester.dragUntilVisible(find.text(FREEZING_ORDER_BOOK_NAME),
      find.text(FREEZING_ORDER_BOOK_NAME), const Offset(100.0, 500.0));
  await tester.pumpAndSettle(Duration(seconds: 10));

  ///Verify second book exists or not
  expect(find.text(FREEZING_ORDER_BOOK_NAME), findsOneWidget);

  ///Choose second book
  await tester.tap(find.text(FREEZING_ORDER_BOOK_NAME));
  await tester.pumpAndSettle(delaySixSec);
  expect(find.text(FREEZING_ORDER_BOOK_NAME), findsWidgets);
  await tester.tap(find.byIcon(Icons.chevron_left));
  await tester.pumpAndSettle(delaySixSec);
  // await tester.dragFrom(
  //      const Offset(100.0, 500.0),Offset(0.0, 0.0));
  // expect(find.byType(RecentBooksListSectionView), findsOneWidget);
  // await tester.pumpAndSettle(delaySixSec);
}
