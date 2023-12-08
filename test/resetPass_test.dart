import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:transportasi_11/view/loginRegistResetPass/login.dart';
import 'package:transportasi_11/view/loginRegistResetPass/resetPass.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    HttpOverrides.global = null;
  });
  group('Testing', () {
    testWidgets('cek Berhasil ubah', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ForgetPasswordPage()));

      await tester.enterText(find.byType(TextField).first, '123');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.enterText(find.byType(TextField).at(1), '87654321');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byType(LoginView), isNotNull);
    });
    testWidgets('cek gagal ubah', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ForgetPasswordPage()));

      await tester.enterText(find.byType(TextField).first, '111');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.enterText(find.byType(TextField).at(1), '87654321');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byWidgetPredicate((widget) {
        if (widget is SnackBar) {
          final snackBar = widget as SnackBar;
          return snackBar.content != null &&
              snackBar.content is Text &&
              (snackBar.content as Text).data == 'Gagal ganti password';
        }
        return false;
      }), findsOneWidget);
    });
  });
}
