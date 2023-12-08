import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transportasi_11/view/loginRegistResetPass/register.dart';
import 'package:integration_test/integration_test.dart';
import 'package:transportasi_11/view/loginRegistResetPass/login.dart';
import 'package:transportasi_11/view/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Register Testing', () {
    testWidgets('cek berhasil gagal', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterView(
              id: null,
              name: ' ',
              email: ' ',
              fullName: ' ',
              noTelp: ' ',
              password: ' ',
            ),
          ),
        ),
      );
      await tester.enterText(find.byType(TextFormField).first, '18');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.enterText(find.byType(TextFormField).at(1), '1@gmail.com');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.enterText(find.byType(TextFormField).at(2), '12345678');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.enterText(find.byType(TextFormField).at(3), 'satu');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.enterText(find.byType(TextFormField).at(4), '081111111111');
      await tester.pumpAndSettle(Duration(seconds: 2));

      // await tester.tap(find.byType(ElevatedButton));
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byType(HomeView), isNotNull);
      await tester.pumpAndSettle(Duration(seconds: 2));
    });

    testWidgets('cek berhasil register', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterView(
              id: null,
              name: null,
              email: null,
              fullName: null,
              noTelp: null,
              password: null,
            ),
          ),
        ),
      );
      await tester.enterText(find.byType(TextFormField).first, '172');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.enterText(find.byType(TextFormField).at(1), '17@gmail.com');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.enterText(find.byType(TextFormField).at(2), '12345678');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.enterText(find.byType(TextFormField).at(3), 'satutujuh');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.enterText(find.byType(TextFormField).at(4), '081890998765');
      await tester.pumpAndSettle(Duration(seconds: 2));

      // await tester.tap(find.byType(ElevatedButton));
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.text('Ya'));
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byType(LoginView), isNotNull);
      await tester.pumpAndSettle(Duration(seconds: 2));
    });
  });
}
