import 'package:car_on_sale_challenge/environments/caronsale_app/development/main_development.dart' as app;
import 'package:car_on_sale_challenge/features/auth/presentation/screens/splash_screen.dart';
import 'package:car_on_sale_challenge/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login Flow Integration Test,', (tester) async {
    // Start the CarOnSale app
    app.main();
    await tester.pumpAndSettle();

    // Check if the splash screen is displayed and the image appears
    expect(find.byType(SplashScreen), findsOneWidget);

    // Check for  SVG image
    expect(
      find.byWidgetPredicate((widget) {
        return widget.toString().contains('car_on_sale_logo.svg');
      }),
      findsOneWidget,
    );

    // Wait for login screen by checking for the login button text
    await tester.pumpAndSettle(const Duration(seconds: 10));
    expect(find.text(S.current.login), findsOneWidget);

    // Enter the TextFormField Value and search for the TextButton and Click on it.
    await tester.enterText(find.byType(TextFormField), 'info@caronsale.de');
    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();

    // Check if the next screen displayed by check the title if it appears.
    expect(find.text(S.current.check_vin_details), findsOneWidget);
  });
}
