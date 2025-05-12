import 'package:car_on_sale_challenge/widgets/car_on_sale_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CarOnSaleWidget Test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CarOnSaleWidget(
            isLoading: false,
            title: 'title',
            action: 'action',
            placeholder: 'hint',
            onPressed: (String value) {},
            validator: (value) {
              if (value == null || value.isEmpty) return 'Validation test';
              return null;
            },
          ),
        ),
      ),
    );

    // Wait for frame
    await tester.pumpAndSettle();

    // Enter invalid text (or no text to trigger validator)
    await tester.enterText(find.byType(TextFormField), '');
    await tester.tap(find.byType(TextButton));

    await tester.pumpAndSettle();

    expect(find.text('Validation test'), findsOneWidget);
  });

}
