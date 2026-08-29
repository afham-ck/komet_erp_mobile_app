import 'package:flutter_test/flutter_test.dart';
import 'package:komet_collection/core/di/injection.dart';
import 'package:komet_collection/main.dart';

void main() {
  setUp(() {
    try {
      initDependencies();
    } catch (_) {
      // already initialized
    }
  });

  testWidgets('App compiles and launches to initial route test', (WidgetTester tester) async {
    await tester.pumpWidget(const KometCollectionApp());
    await tester.pump();
    expect(find.byType(KometCollectionApp), findsOneWidget);
  });
}
