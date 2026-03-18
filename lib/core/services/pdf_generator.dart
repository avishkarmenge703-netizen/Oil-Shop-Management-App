import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:oil_shop_management/data/models/failed_coupon_model.dart';

class PdfGenerator {
  static Future<File> generateFailedCouponsReport(List<FailedCouponModel> coupons) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Failed Coupons Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.TableHelper.fromTextArray(
              headers: ['Coupon Number', 'Reason', 'Date'],
              data: coupons.map((c) => [c.couponNumber, c.reason, '${c.enteredAt.toLocal()}']).toList(),
            ),
          ],
        ),
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/failed_coupons.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
