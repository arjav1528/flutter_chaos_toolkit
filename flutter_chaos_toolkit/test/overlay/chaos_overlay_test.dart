import 'package:flutter/material.dart';
import 'package:flutter_chaos_toolkit/flutter_chaos_toolkit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders FPS metric by default', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: ChaosOverlay())),
    );

    await tester.pump();
    expect(find.textContaining('FPS'), findsOneWidget);
  });

  testWidgets('hides FPS when disabled', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: ChaosOverlay(config: ChaosConfig(showFPS: false))),
      ),
    );

    await tester.pump();
    expect(find.textContaining('FPS'), findsNothing);
  });
}
