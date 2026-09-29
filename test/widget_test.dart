import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:spotify/main.dart';
import 'package:spotify/views/search_screen.dart';

void main() {
  testWidgets('Home page shows Made For You heading only once', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Made For You'), findsOneWidget);
  });

  testWidgets('Search page filters recommendations in real time', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SearchPage()));

    await tester.enterText(find.byType(TextField), 'mix');
    await tester.pump();

    expect(find.text('Daily Mix 1'), findsOneWidget);
  });
}
