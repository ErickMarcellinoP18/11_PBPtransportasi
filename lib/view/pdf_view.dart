import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:transportasi_11/view/preview_screen.dart';

Future<void> createPdf(Uint8List image, String asal, int harga, String idTicket,
    String tujuan, String jenis, BuildContext context) async {
  final doc = pw.Document();
  final now = DateTime.now();
  final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

  final imageLogo =
      (await rootBundle.load("assets/images/logo.png")).buffer.asUint8List();
  final imageInvoice = pw.MemoryImage(imageLogo);

  pw.ImageProvider pdfImageProvider(Uint8List image) {
    return pw.MemoryImage(image);
  }

  final pdfTheme = pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
    buildBackground: (pw.Context context) {
      return pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(
            color: PdfColor.fromHex('#FFBD59'),
            width: 1,
          ),
        ),
      );
    },
  );

  doc.addPage(
    pw.MultiPage(
      pageTheme: pdfTheme,
      header: (pw.Context context) {
        return headerPDF();
      },
      build: (pw.Context context) {
        return [
          pw.Center(
              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                pw.Container(
                    margin: const pw.EdgeInsets.symmetric(
                        horizontal: 2, vertical: 2)),
                pw.SizedBox(height: 10),
                imageFromInput(pdfImageProvider, image),
                pw.SizedBox(height: 10),
                personalDataFromInput(asal, harga, idTicket, tujuan, jenis),
                pw.SizedBox(height: 10),
                // topOfInvoice(imageInvoice),
                // barcodeGaris(idTicket.toString()),
                // pw.SizedBox(height: 5),
                pw.Text('QR CODE TIKET ANDA'),
                pw.SizedBox(height: 5),
                barcodeKotak(idTicket),
                pw.SizedBox(height: 1),
              ])),
        ];
      },
      footer: (pw.Context context) {
        return pw.Container(
            color: PdfColor.fromHex('#FFBD59'),
            child: footerPDF(formattedDate));
      },
    ),
  );

  // ignore: use_build_context_synchronously
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(doc: doc),
      ));
}

pw.Header headerPDF() {
  return pw.Header(
      margin: pw.EdgeInsets.zero,
      outlineColor: PdfColors.amber50,
      outlineStyle: PdfOutlineStyle.normal,
      level: 5,
      decoration: pw.BoxDecoration(
        shape: pw.BoxShape.rectangle,
        gradient: pw.LinearGradient(
          colors: [PdfColor.fromHex('#FCDF8A'), PdfColor.fromHex('#F38381')],
          begin: pw.Alignment.topLeft,
          end: pw.Alignment.bottomRight,
        ),
      ),
      child: pw.Center(
        child: pw.Text(
          '-TRANSKRIP TIKET KERETA-',
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ));
}

pw.Padding imageFromInput(
    pw.ImageProvider Function(Uint8List imageBytes) pdfImageProvider,
    Uint8List imageBytes) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(horizontal: 2, vertical: 1),
    child: pw.FittedBox(
      child: pw.Image(pdfImageProvider(imageBytes), width: 100),
      fit: pw.BoxFit.fitHeight,
      alignment: pw.Alignment.center,
    ),
  );
}

pw.Padding personalDataFromInput(
  String asal,
  int harga,
  String idTicket,
  String tujuan,
  String jenis,
) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(horizontal: 5, vertical: 1),
    child: pw.Table(
      border: pw.TableBorder.all(),
      children: [
        pw.TableRow(
          children: [
            pw.Padding(
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              child: pw.Text(
                'Asal',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
            pw.Padding(
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              child: pw.Text(
                asal,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Padding(
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              child: pw.Text(
                'Tujuan',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              child: pw.Text(
                tujuan,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              child: pw.Text(
                'Jenis',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              child: pw.Text(
                jenis,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

pw.Padding topOfInvoice(pw.MemoryImage imageInvoice) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(8.0),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Image(imageInvoice, height: 30, width: 30),
        pw.Expanded(
          child: pw.Container(
            height: 10,
            decoration: const pw.BoxDecoration(
                borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
                color: PdfColors.amberAccent),
            padding: const pw.EdgeInsets.only(
                left: 40, top: 10, bottom: 10, right: 40),
            alignment: pw.Alignment.centerLeft,
            child: pw.DefaultTextStyle(
              style:
                  const pw.TextStyle(color: PdfColors.amber100, fontSize: 12),
              child: pw.GridView(
                crossAxisCount: 2,
                children: [
                  pw.Text('Awesome Product',
                      style:
                          pw.TextStyle(fontSize: 10, color: PdfColors.blue800)),
                  pw.Text('Anggek Street 12',
                      style:
                          pw.TextStyle(fontSize: 10, color: PdfColors.blue800)),
                  pw.SizedBox(height: 1),
                  pw.Text('Jakarta 5111',
                      style:
                          pw.TextStyle(fontSize: 10, color: PdfColors.blue800)),
                  pw.SizedBox(height: 1),
                  pw.SizedBox(height: 1),
                  pw.Text('Contact Us',
                      style:
                          pw.TextStyle(fontSize: 10, color: PdfColors.blue800)),
                  pw.SizedBox(height: 1),
                  pw.Text('Phone Number',
                      style:
                          pw.TextStyle(fontSize: 10, color: PdfColors.blue800)),
                  pw.Text('0812345678',
                      style:
                          pw.TextStyle(fontSize: 10, color: PdfColors.blue800)),
                  pw.Text('Email',
                      style:
                          pw.TextStyle(fontSize: 10, color: PdfColors.blue800)),
                  pw.Text('awesomeproduct@gmail.com',
                      style:
                          pw.TextStyle(fontSize: 10, color: PdfColors.blue800)),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

pw.Padding contentOfInvoice(pw.Widget table) {
  return pw.Padding(
      padding: const pw.EdgeInsets.all(8.0),
      child: pw.Column(children: [
        pw.Text(
            "Dear Customer, thank you for buying our project, we hope the products can make your day."),
        pw.SizedBox(height: 3),
        table,
        pw.Text("Thanks for your trust, and till the next time."),
        pw.SizedBox(height: 3),
        pw.Text("Kind regards,"),
        pw.SizedBox(height: 3),
        pw.Text("XXXX"),
      ]));
}

pw.Padding barcodeKotak(String id) {
  return pw.Padding(
    padding: pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
    child: pw.Center(
      child: pw.BarcodeWidget(
        barcode: pw.Barcode.qrCode(
          errorCorrectLevel: BarcodeQRCorrectionLevel.high,
        ),
        data: 'https://pbptransportasi/' + id,
        width: 100,
        height: 100,
      ),
    ),
  );
}

pw.Container barcodeGaris(String id) {
  return pw.Container(
    child: pw.Padding(
      padding: pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: pw.BarcodeWidget(
        barcode: Barcode.code128(escapes: true),
        data: id,
        width: 10,
        height: 5,
      ),
    ),
  );
}

pw.Center footerPDF(String formattedDate) => pw.Center(
    child: pw.Text('Created At $formattedDate',
        style: pw.TextStyle(fontSize: 10, color: PdfColors.blue)));
