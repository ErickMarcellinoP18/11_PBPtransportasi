import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:transportasi_11/data/client/userClient.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:transportasi_11/view/home.dart';
import 'package:transportasi_11/view/ticketInputPage.dart';
import 'package:transportasi_11/view/TicketPage.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    HttpOverrides.global = null;
  });

  group('Testing', () {
    testWidgets('cek input berhasil', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ticketInputPage()));
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.enterText(find.byKey(Key('asal')), 'jakarta');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.enterText(find.byKey(Key('tujuan')), 'bandung');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.enterText(find.byKey(Key('harga')), '12');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.byKey(Key('jenis')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Eksekutif'));
      await tester.pumpAndSettle(Duration(seconds: 5));

      await tester.tap(find.byKey(const Key('SaveBtn')));
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byType(TicketHomePage), isNotNull);
    });

    testWidgets('cek edit berhasil', (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: ticketInputPage(idTicket: 1)));
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.enterText(find.byKey(Key('asal')), 'bandung');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.enterText(find.byKey(Key('tujuan')), 'jakarta');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.enterText(find.byKey(Key('harga')), '12');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.byKey(const Key('SaveBtn')));
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byType(TicketHomePage), isNotNull);
    });

    testWidgets('cek hapus berhasil', (WidgetTester tester) async {
      User loggedIn = await userClient.Login('123', '12345678');

      await tester
          .pumpWidget(MaterialApp(home: TicketHomePage(loggedIn: loggedIn)));
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.byKey(const Key('delete')).first);
      await tester.pumpAndSettle(Duration(seconds: 5));

      expect(find.text('Delete Success'), findsOneWidget);
    });
  });
}
