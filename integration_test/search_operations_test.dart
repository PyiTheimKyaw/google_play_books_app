import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_play_books_app/pages/search_page.dart';
import 'package:google_play_books_app/pages/start_page.dart';

import 'test_data/test_data.dart';

Future<void> searchOperations(WidgetTester tester) async {
  var delayThreeSec = const Duration(seconds: 3);
  var delaySixSec = const Duration(seconds: 6);
  var delayTenSec = const Duration(seconds: 10);

  await tester.tap(find.byType(TextField));
  await tester.pumpAndSettle(delayThreeSec);

  ///Verify is it start page or not
  expect(find.byType(SearchPage), findsOneWidget);

  await tester.enterText(find.byType(TextField), SEARCHED_QUERY);
  await tester.pumpAndSettle(delayThreeSec);

  ///Verify searched book list
  expect(find.text(SEARCHED_BOOK), findsOneWidget);
  await tester.pumpAndSettle(delayThreeSec);

  ///tap done on keyboart
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pumpAndSettle(delayTenSec);

  ///Verify submitted book results exist or not
  expect(find.text(SEARCHED_BOOK_RESULT), findsWidgets);
  await tester.pumpAndSettle(delaySixSec);
}
