import 'package:flutter_test/flutter_test.dart';

import 'package:spotify/main.dart';

void main() {
  testWidgets('Home page shows Made For You heading only once', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Made For You'), findsOneWidget);
  });
}
