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

  ///Tap shelves tab
  await tester.tap(find.text("Shelves"));
  await tester.pumpAndSettle(delaySixSec);

  ///Verify is it shelves tab or nor
  expect(find.byType(ShelvesSectionView), findsOneWidget);
  await tester.pumpAndSettle(delaySixSec);

  ///Tap add new shelf button
  await tester.tap(find.byType(FloatingActionButton));
  await tester.pumpAndSettle(delaySixSec);

  ///Verify is it add new shelf page or not
  expect(find.byType(AddNewShelfPage), findsOneWidget);
  // await tester.pumpAndSettle(delaySixSec);

  ///Enter new shelf
  await tester.enterText(find.byType(TextField), CREATE_SHELF_NAME);
  await tester.pumpAndSettle(delayTenSec);

  ///Tap add new shelf done button
  await tester.tap(find.byIcon(Icons.download_done_outlined));
  await tester.pumpAndSettle(delaySixSec);

  ///Verity is it created sheld name or name
  expect(find.text(CREATE_SHELF_NAME), findsOneWidget);
  // await tester.pumpAndSettle(delaySixSec);

  ///Tap created new shelf name to shelf details
  await tester.tap(find.text(CREATE_SHELF_NAME));
  await tester.pumpAndSettle(delaySixSec);

  ///Verify is it shelf details or not
  expect(find.byType(ReviewShelfPage), findsOneWidget);
  await tester.pumpAndSettle(delaySixSec);

  ///Tap button to edit and rename
  await tester.tap(find.byIcon(Icons.more_vert));
  await tester.pumpAndSettle(delaySixSec);

  ///Tap rename
  await tester.tap(find.text("Rename Shelf"));
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
  ///Tap your books tab again
  await tester.tap(find.text("Your books"));
  await tester.pumpAndSettle(delaySixSec);

  ///Tap more button on the book cover
  await tester.tap(find.byKey(Key("0")));
  await tester.pumpAndSettle(delaySixSec);

  ///Tap add to shelf button
  await tester.tap(find.text("Add to shelf"));
  await tester.pumpAndSettle(Duration(seconds: 20));

  ///Verify is it add book to shelf page or nor
  expect(find.byType(AddBookToShelfPage), findsOneWidget);
  // await tester.pumpAndSettle(delaySixSec);

  ///Choose a shelf to add book
  await tester.tap(find.text(RENAME_SHELF_NAME));
  await tester.pumpAndSettle(Duration(seconds: 20));

  // await tester.tap(find.byType(LibraryPage));
  await tester.pump();

  ///Tab shelves tab again to verfify added book exists or not
  await tester.tap(find.text("Shelves"));
  await tester.pumpAndSettle(delaySixSec);

  ///tap shlef which has added book
  await tester.tap(find.text(RENAME_SHELF_NAME));
  await tester.pumpAndSettle(delaySixSec);

  ///Verify added books exits or not
  expect(find.text(THE_INVESTIGATOR_BOOK_NAME), findsOneWidget);
  await tester.pumpAndSettle(delaySixSec);

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
  await tester.tap(find.text("Delete Shelf"));
  await tester.pumpAndSettle(delaySixSec);

  ///Tap back button again
  await tester.tap(find.byIcon(Icons.arrow_back));
  await tester.pumpAndSettle(delaySixSec);
}
