import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_play_books_app/pages/library_page.dart';

import 'test_data/test_data.dart';

Future<void> operationsInYourBooks(WidgetTester tester) async {
  var delayThreeSec = const Duration(seconds: 3);
  var delaySixSec = const Duration(seconds: 6);
  var delayTenSec = const Duration(seconds: 10);

  ///Tap library tab
  await tester.tap(find.text("Library"));
  await tester.pumpAndSettle(delaySixSec);

  ///Verify is it library tab or not
  expect(find.byType(LibraryPage), findsOneWidget);
  expect(find.text(THE_INVESTIGATOR_BOOK_NAME), findsOneWidget);

  // await tester.pumpAndSettle(delaySixSec);
  ///Choose first category
  await tester.tap(find.byKey(Key(CATEGORY_COMBINED_PRINT_AND_E_BOOK_FICTION)));

  ///Choose second category
  await tester.dragUntilVisible(find.text(CATEGORY_HARDCOVER_FICTION),
      find.text(CATEGORY_HARDCOVER_FICTION), Offset(307, 1996));
  await tester.pumpAndSettle(delayThreeSec);
  await tester.tap(find.text(CATEGORY_HARDCOVER_FICTION));
  await tester.pumpAndSettle(delayThreeSec);
  // await tester.drag(find.byIcon(Icons.close), Offset(0, 1996));
  // await tester.pumpAndSettle(delayThreeSec);
  // await tester.tap(find.byIcon(Icons.close));
  // await tester.pumpAndSettle(delaySixSec);

  ///Verify choosed category book result or nor
  expect(find.text(THE_INVESTIGATOR_BOOK_NAME), findsOneWidget);

  ///Tap sort by type menu icon and choose sort by recent
  await tester.tap(find.byIcon(Icons.menu));
  await tester.pumpAndSettle(delayTenSec);
  await tester.tap(find.byKey(Key(SORT_BY_RECENT)));
  await tester.pumpAndSettle(delayTenSec);

  ///Tap sort by type menu icon and choose sort by title
  await tester.tap(find.byIcon(Icons.menu));
  await tester.pumpAndSettle(delayTenSec);
  await tester.tap(find.byKey(Key(SORT_BY_TITLE)));
  await tester.pumpAndSettle(delayTenSec);

  ///Tap sort by view menu icon and choose sort by 2x grid
  await tester.tap(find.byIcon(Icons.list_alt));
  await tester.pumpAndSettle(delayTenSec);
  await tester.tap(find.byKey(Key(SMALL_GRID)));
  await tester.pumpAndSettle(delayTenSec);

  ///Verify is it two x grid or not
  expect(find.byKey(Key(TWOX_GRID)), findsOneWidget);

  ///Tap sort by view menu icon and choose sort by 3x grid
  await tester.tap(find.byIcon(Icons.list_alt));
  await tester.pumpAndSettle(delayTenSec);
  await tester.tap(find.byKey(Key(LARGE_GRID)));
  await tester.pumpAndSettle(delayTenSec);

  ///Verify is it two x grid or not
  expect(find.byKey(Key(THREEX_GRID)), findsOneWidget);
}
