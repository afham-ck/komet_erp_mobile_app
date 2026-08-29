import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:komet_collection/core/widgets/error_tile.dart';

void main() {
  group('ErrorTile Widget Tests', () {
    testWidgets('renders title, error icon, message, and retry button', (WidgetTester tester) async {
      bool retried = false;
      const errorMessage = 'Failed to fetch collection data';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorTile(
              message: errorMessage,
              onRetry: () {
                retried = true;
              },
            ),
          ),
        ),
      );

      // Verify warning icon, default title, message, and button are displayed
      expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);
      expect(find.text('Something went wrong.'), findsOneWidget);
      expect(find.text(errorMessage), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);

      // Tap retry button and check callback execution
      await tester.tap(find.text('Retry'));
      await tester.pump();

      expect(retried, isTrue);
    });
  });
}
