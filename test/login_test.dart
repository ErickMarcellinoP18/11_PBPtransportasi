import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transportasi_11/data/client/userClient.dart';
import 'package:transportasi_11/view/home.dart';
import 'package:transportasi_11/view/homePetugas.dart';
import 'package:transportasi_11/view/login.dart';
import 'package:transportasi_11/view/register.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:http/http.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = null;
  });
  group('Testing', () {
    testWidgets('cek gagal login', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginView()));
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.enterText(find.byType(TextFormField).first, '124');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.enterText(find.byType(TextFormField).at(1), '123145678');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.byKey(const Key('LoginBtn')));
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byType(HomeView), isNull);
    });

    testWidgets('cek berhasil login Petugas', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginView()));

      await tester.enterText(find.byType(TextFormField).first, 'Petugas');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.enterText(find.byType(TextFormField).at(1), 'petugasPBP');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.byKey(const Key('LoginBtn')));
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byType(HomeView), isNotNull);
      await tester.pumpAndSettle(Duration(seconds: 2));
    });

    testWidgets('cek berhasil login', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginView()));

      await tester.enterText(find.byType(TextFormField).first, '321');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.enterText(find.byType(TextFormField).at(1), '87654321');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.byKey(const Key('password')));

      await tester.tap(find.byKey(const Key('LoginBtn')));
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byType(HomeView), isNotNull);
      await tester.pumpAndSettle(Duration(seconds: 2));
    });
  });
}
