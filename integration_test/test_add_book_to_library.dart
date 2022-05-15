import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_play_books_app/pages/home_page.dart';
import 'package:google_play_books_app/pages/library_page.dart';
import 'package:google_play_books_app/widgets/ebooks_section_view.dart';

import 'test_data/test_data.dart';

Future<void> testAddBooksToLibrary(WidgetTester tester) async {
  var delaySixSec = const Duration(seconds: 6);
  expect(find.byType(HomePage), findsOneWidget);
  expect(find.byType(EbooksSectionView), findsOneWidget);
  expect(find.text(THE_INVESTIGATOR_BOOK_NAME), findsOneWidget);

  await tester.tap(find.text(THE_INVESTIGATOR_BOOK_NAME));
  await tester.pumpAndSettle(delaySixSec);

  expect(find.text("John Sandford"), findsOneWidget);

  await tester.pumpAndSettle(delaySixSec);

  await tester.tap(find.byIcon(Icons.chevron_left));

  await tester.pumpAndSettle(delaySixSec);

  expect(find.byType(RecentBooksListSectionView), findsOneWidget);

  await tester.tap(find.text("Library"));
  await tester.pumpAndSettle(delaySixSec);

  expect(find.byType(LibraryPage), findsOneWidget);
  expect(find.text(THE_INVESTIGATOR_BOOK_NAME), findsOneWidget);
}
