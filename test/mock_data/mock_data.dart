import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/google_book_vo.dart';
import 'package:google_play_books_app/data/vos/google_search_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';
import 'package:google_play_books_app/data/vos/shelf_vo.dart';

List<BookVO> getMockBook(){
  return[
    BookVO(
      "",
      null,
      null,
      "Bill Browder",
      null,
      null,
      null,
      null,
      null,
      "",
      null,
      "The author of “Red Notice” tells his story of becoming Vladimir Putin’s enemy by uncovering a \$230 million tax refund scheme.",
      null,
      "0.00",
      "1982153288",
      "9781982153281",
      null,
      "Simon & Schuster",
      null,
      null,
      null,
      "FREEZING ORDER",
      null,
      null,
      null,
      null,
      null,
      null,
      null,
    ),
  ];
}
List<String> getMockCategoriesString() {
  return [
    "Hardcover Fiction",
    "Hardcover Nonfiction",
    "Series",
    "Stories Book"
  ];
}

List<ShelfVO> getMockShelves(){
  return[
    ShelfVO(shelfName: "Testing",books: []),
  ];
}

List<CategoryVO> getMockBookListForViewMore() {
  return [
    CategoryVO(
        704,
        "Hardcover Nonfiction",
        null,
        "Hardcover Nonfiction",
        null,
        null,
        null,
        null,
        null,
        "2022-04-16",
        "2022-05-01",
        1,
        0,
        1,
        0,
        0,
        "https://www.amazon.com/dp/1982153288?tag=NYTBSREV-20",
        null,
        [
          BookVO(
            "",
            null,
            null,
            "Bill Browder",
            null,
            null,
            null,
            null,
            null,
            "",
            null,
            "The author of “Red Notice” tells his story of becoming Vladimir Putin’s enemy by uncovering a \$230 million tax refund scheme.",
            null,
            "0.00",
            "1982153288",
            "9781982153281",
            null,
            "Simon & Schuster",
            null,
            null,
            null,
            "FREEZING ORDER",
            null,
            null,
            null,
            null,
            null,
            null,
            null,
          )
        ],
        null),
    // CategoryVO(
    //     708,
    //     "Hardcover Nonfiction",
    //     "",
    //     "Hardcover Nonfiction",
    //     null,
    //     null,
    //     null,
    //     null,
    //     null,
    //     "2022-04-16",
    //     "2022-05-01",
    //     2,
    //     0,
    //     1,
    //     0,
    //     0,
    //     "https://www.amazon.com/dp/0063056232?tag=NYTBSREV-20",
    //     null,
    //     [
    //       BookVO(
    //         "",
    //         null,
    //         null,
    //         "Molly Shannon with Sean Wilsey",
    //         null,
    //         null,
    //         null,
    //         null,
    //         "by Molly Shannon with Sean Wilsey",
    //         "",
    //         null,
    //         "The comedic actor shares stories of family tragedy and her years as a star of “Saturday Night Live.”",
    //         null,
    //         "0.00",
    //         "0063056232",
    //         "9780063056237",
    //         null,
    //         "Ecco",
    //         null,
    //         null,
    //         null,
    //         "HELLO, MOLLY!",
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //       )
    //     ],
    //     null),
  ];
}

List<BookVO> getMockSearchedBook() {
  return [
    BookVO(
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        GoogleSearchVO(
          "books#volume",
          "taMTAQAAMAAJ",
          "2xMlxuoAy/0",
          GoogleBooksVO(
              "The Investigator's Guide to Clinical Research",
              ["David Ginsberg"],
              "Centerwatch Incorporated",
              "2002",
              "The Investigator's Guide to Clinical Research is a step-by-step manual filled with tips, instructions and insights for investigators - novice and experienced - and health professionals involved in conducting clinical research. Along with updated sections, charts and statistics, the 3rd edition includes a detailed look at investigator financial disclosure, noncompliance issues, the FDA audit process and data collection technologies. A new appendix includes valuable lists of company contacts and additional resources. Developed in accordance with the essentials and standards of the ACCME. Exam is provided online. Topics include...An overview of the clinical development process; A review of regulatory requirements; How to set up and manage a research center; How to effectively and efficiently conduct clinical trials and How to identify and secure clinical grant opportunities.",
              null,
              null,
              ["Medical"]),
        ),
        null,
        null),
  ];
}

OverviewVo getMockOverview() {
  return OverviewVo("2022-04-16", "2022-05-01", "", "2022-04-24", '2022-05-08',
      getMockBookListForViewMore());
}
