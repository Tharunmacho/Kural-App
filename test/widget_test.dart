// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.



import 'package:flutter_test/flutter_test.dart';

import 'package:kural_ai/main.dart';

void main() {
  testWidgets('App loads and shows login screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the login screen is displayed
    expect(find.text('Thedal Election\nAnalytics Manager'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('The first-ever SaaS-based comprehensive\nelection campaign management tool for all\ncandidates'), findsOneWidget);
  });
}
