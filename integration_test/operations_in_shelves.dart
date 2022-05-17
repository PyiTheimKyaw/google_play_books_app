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

  expect(find.byType(ShelvesSectionView), findsOneWidget);
  await tester.pumpAndSettle(delaySixSec);
  await tester.tap(find.byType(FloatingActionButton));
  await tester.pumpAndSettle(delaySixSec);

  expect(find.byType(AddNewShelfPage), findsOneWidget);
  await tester.pumpAndSettle(delaySixSec);
  await tester.enterText(find.byType(TextField), CREATE_SHELF_NAME);
  await tester.pumpAndSettle(delayTenSec);
  await tester.tap(find.byIcon(Icons.download_done_outlined));
  await tester.pumpAndSettle(delaySixSec);

  expect(find.text(CREATE_SHELF_NAME), findsOneWidget);
  await tester.pumpAndSettle(delaySixSec);
  await tester.tap(find.text(CREATE_SHELF_NAME));
  await tester.pumpAndSettle(delaySixSec);

  expect(find.byType(ReviewShelfPage), findsOneWidget);
  await tester.pumpAndSettle(delaySixSec);

  await tester.tap(find.byIcon(Icons.more_vert));
  await tester.pumpAndSettle(delaySixSec);
  await tester.tap(find.text("Rename Shelf"));
  await tester.pumpAndSettle(delaySixSec);
  await tester.enterText(find.byType(TextField), RENAME_SHELF_NAME);
  await tester.pumpAndSettle(delaySixSec);
  await tester.tap(find.byIcon(Icons.download_done_rounded));
  await tester.pumpAndSettle(delayTenSec);
  await tester.tap(find.byIcon(Icons.arrow_back));
  await tester.pumpAndSettle(delaySixSec);

  expect(find.text(RENAME_SHELF_NAME), findsOneWidget);
  await tester.pumpAndSettle(delaySixSec);

  // await tester.tap(find.text(RENAME_SHELF_NAME));
  // await tester.pumpAndSettle(delaySixSec);
  //
  // expect(find.byType(ReviewShelfPage), findsOneWidget);
  // await tester.pumpAndSettle(delaySixSec);
  // await tester.tap(find.byIcon(Icons.more_vert));
  // await tester.pumpAndSettle(delaySixSec);
  // await tester.tap(find.text("Delete Shelf"));
  // await tester.pumpAndSettle(delaySixSec);

  await tester.tap(find.text("Your books"));
  await tester.pumpAndSettle(delaySixSec);
  await tester.tap(find.byIcon(Icons.more_horiz));
  await tester.pumpAndSettle(delaySixSec);
  await tester.tap(find.text("Add to shelf"));
  await tester.pumpAndSettle(Duration(seconds: 20));

  expect(find.byType(AddBookToShelfPage), findsOneWidget);
  await tester.pumpAndSettle(delaySixSec);
  await tester.tap(find.text(RENAME_SHELF_NAME));
  await tester.pumpAndSettle(Duration(seconds: 20));

  // await tester.tap(find.byType(LibraryPage));
  await tester.pump();

  await tester.tap(find.text("Shelves"));
  await tester.pumpAndSettle(delaySixSec);
  await tester.tap(find.text(RENAME_SHELF_NAME));
  await tester.pumpAndSettle(delaySixSec);

  expect(find.text(THE_INVESTIGATOR_BOOK_NAME), findsOneWidget);
  await tester.pumpAndSettle(delaySixSec);
}
