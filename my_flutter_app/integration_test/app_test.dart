import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:my_flutter_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('E2E Testing', () {
    testWidgets('Start App', (WidgetTester tester) async {
      await tester.pumpWidget(const TestingApp());

      expect(find.text('Testing Sample'), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.byKey(const ValueKey('text_1')), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsWidgets);

      await tester.tap(find.byKey(const ValueKey('icon_1')));
      await tester.pump();

      expect(find.byIcon(Icons.favorite), findsOneWidget);

      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();

      expect(find.text('Favorites'), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.byKey(const ValueKey('favorites_text_1')), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('remove_icon_1')));
      await tester.pump();

      expect(find.text('Item 1'), findsNothing);

      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      expect(find.text('Testing Sample'), findsOneWidget);
    });
  });
}
