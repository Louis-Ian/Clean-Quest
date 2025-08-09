import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/welcome/view/create_family_dialog.dart';
import 'package:app/features/welcome/viewmodel/welcome_viewmodel.dart';
import '../mocks/mock_family_repository.dart';
import '../../../setup.dart';

void main() {
  group('CreateFamilyDialog Widget Tests', () {
    late ProviderContainer container;
    late MockFamilyRepository mockRepository;

    setUpAll(() async {
      await setupFirebaseForTesting();
    });

    setUp(() {
      mockRepository = MockFamilyRepository();
      container = ProviderContainer(
        overrides: [familyRepositoryProvider.overrideWithValue(mockRepository)],
      );
    });

    tearDown(() {
      container.dispose();
      mockRepository.clear();
    });

    Widget createTestWidget() {
      return MaterialApp(
        home: UncontrolledProviderScope(
          container: container,
          child: const Scaffold(body: CreateFamilyDialog()),
        ),
      );
    }

    testWidgets('should display dialog with correct title and fields', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text('Create a Family'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Family Name'), findsOneWidget);
      expect(find.text('Enter your family name'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Create'), findsOneWidget);
    });

    testWidgets('should show validation error for empty family name', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.tap(find.text('Create'));
      await tester.pump();

      // Assert
      expect(find.text('Please enter a family name'), findsOneWidget);
    });

    testWidgets('should show validation error for short family name', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.enterText(find.byType(TextFormField), 'A');
      await tester.tap(find.text('Create'));
      await tester.pump();

      // Assert
      expect(find.text('Family name must be at least 2 characters'), findsOneWidget);
    });

    testWidgets('should accept valid family name', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.enterText(find.byType(TextFormField), 'Valid Family Name');
      await tester.tap(find.text('Create'));
      await tester.pump();

      // Assert
      expect(find.text('Please enter a family name'), findsNothing);
      expect(find.text('Family name must be at least 2 characters'), findsNothing);
    });

    testWidgets('should close dialog when cancel is pressed', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Create a Family'), findsNothing);
    });
  });
}
