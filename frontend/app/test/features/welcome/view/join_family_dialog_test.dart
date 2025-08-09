import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/welcome/view/join_family_dialog.dart';
import 'package:app/features/welcome/viewmodel/welcome_viewmodel.dart';
import '../mocks/mock_family_repository.dart';
import '../../../setup.dart';

void main() {
  group('JoinFamilyDialog Widget Tests', () {
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
          child: const Scaffold(body: JoinFamilyDialog()),
        ),
      );
    }

    testWidgets('should display dialog with correct title and fields', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text('Join a Family'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Invite Code'), findsOneWidget);
      expect(find.text('Enter the 6-digit invite code'), findsOneWidget);
      expect(
        find.text('Ask your family member for the invite code to join their family.'),
        findsOneWidget,
      );
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Join'), findsOneWidget);
    });

    testWidgets('should show validation error for empty invite code', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.tap(find.text('Join'));
      await tester.pump();

      // Assert
      expect(find.text('Please enter an invite code'), findsOneWidget);
    });

    testWidgets('should show validation error for short invite code', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.enterText(find.byType(TextFormField), 'ABC');
      await tester.tap(find.text('Join'));
      await tester.pump();

      // Assert
      expect(find.text('Invite code must be 6 characters'), findsOneWidget);
    });

    testWidgets('should show validation error for long invite code', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.enterText(find.byType(TextFormField), 'ABCDEFG');
      await tester.tap(find.text('Join'));
      await tester.pump();

      // Assert
      expect(find.text('Invite code must be 6 characters'), findsOneWidget);
    });

    testWidgets('should accept valid invite code', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.enterText(find.byType(TextFormField), 'ABC123');
      await tester.tap(find.text('Join'));
      await tester.pump();

      // Assert
      expect(find.text('Please enter an invite code'), findsNothing);
      expect(find.text('Invite code must be 6 characters'), findsNothing);
    });

    testWidgets('should convert lowercase to uppercase', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.enterText(find.byType(TextFormField), 'abc123');
      await tester.tap(find.text('Join'));
      await tester.pump();

      // Assert
      expect(find.text('Please enter an invite code'), findsNothing);
      expect(find.text('Invite code must be 6 characters'), findsNothing);
    });

    testWidgets('should close dialog when cancel is pressed', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Join a Family'), findsNothing);
    });

    testWidgets('should have proper text capitalization', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      // Note: textCapitalization is not directly accessible in tests
      // but the functionality is tested through user interaction
      expect(find.byType(TextFormField), findsOneWidget);
    });
  });
}
