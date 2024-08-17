// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:patterns_setstate/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(GridView), findsNothing);

    expect(find.text('SetState'), findsOneWidget);
    expect(find.text('Best'), findsNothing);

    expect(find.text('SetState'), findsWidgets);
    expect(find.text('SetState'), findsNWidgets(1));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.byType(Navigator), findsNWidgets(1));
  });
}
