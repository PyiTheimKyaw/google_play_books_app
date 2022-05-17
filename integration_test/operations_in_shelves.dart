import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_play_books_app/pages/add_book_to_shelf_page.dart';
import 'package:google_play_books_app/pages/add_new_shelf_page.dart';
import 'package:google_play_books_app/pages/library_page.dart';
import 'package:google_play_books_app/pages/review_shelf_page.dart';
import 'package:google_play_books_app/pages/start_page.dart';
import 'package:google_play_books_app/widgets/shelf_section_view.dart';

import 'test_data/test_data.dart';

Future<void> operationsInShelves(WidgetTester tester) async {
  var delayThreeSec = const Duration(seconds: 3);
  var delaySixSec = const Duration(seconds: 6);
  var delayTenSec = const Duration(seconds: 10);
  ///Tab shelves tab again to verfify added book exists or not
  await tester.tap(find.text(SHELVES_TAB));
  await tester.pumpAndSettle(delaySixSec);

  ///tap shlef which has added book
  await tester.tap(find.text(CREATE_SHELF_NAME));
  await tester.pumpAndSettle(delaySixSec);

  ///Verify added books exits or not
  expect(find.text(THE_INVESTIGATOR_BOOK_NAME), findsOneWidget);
  await tester.pumpAndSettle(delaySixSec);


  ///Tap button to edit and rename
  await tester.tap(find.byIcon(Icons.more_vert));
  await tester.pumpAndSettle(delaySixSec);

  ///Tap rename
  await tester.tap(find.text(RENAME_SHELF));
  await tester.pumpAndSettle(delaySixSec);

  ///Enter text to rename
  await tester.enterText(find.byType(TextField), RENAME_SHELF_NAME);
  await tester.pumpAndSettle(delaySixSec);

  ///Tap button to confirm renamed text
  await tester.tap(find.byIcon(Icons.download_done_rounded));
  await tester.pumpAndSettle(delayTenSec);

  ///Tap back button
  await tester.tap(find.byIcon(Icons.arrow_back));
  await tester.pumpAndSettle(delaySixSec);


  ///Tap shelf to delete
  await tester.tap(find.text(RENAME_SHELF_NAME));
  await tester.pumpAndSettle(delaySixSec);

  ///Verify is it review shelf page or not
  expect(find.byType(ReviewShelfPage), findsOneWidget);
  await tester.pumpAndSettle(delaySixSec);

  ///tap more button to delete
  await tester.tap(find.byIcon(Icons.more_vert));
  await tester.pumpAndSettle(delaySixSec);

  ///Tap to delete shelf
  await tester.tap(find.text(DELETE_SHELF_BUTTON));
  await tester.pumpAndSettle(delaySixSec);

  expect(find.byType(ShelvesSectionView), findsOneWidget);
  await tester.pumpAndSettle(delaySixSec);
}
