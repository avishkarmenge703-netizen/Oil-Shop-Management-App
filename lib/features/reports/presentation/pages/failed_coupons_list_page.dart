import 'package:flutter/material.dart';
import 'package:oil_shop_management/domain/usecases/coupon/get_failed_coupons.dart';
import 'package:oil_shop_management/data/models/failed_coupon_model.dart';
import 'package:oil_shop_management/core/services/pdf_generator.dart';
import 'package:share_plus/share_plus.dart';

class FailedCouponsListPage extends StatefulWidget {
  const FailedCouponsListPage({super.key});

  @override
  State<FailedCouponsListPage> createState() => _FailedCouponsListPageState();
}

class _FailedCouponsListPageState extends State<FailedCouponsListPage> {
  late Future<List<FailedCouponModel>> _failedCoupons;

  @override
  void initState() {
    super.initState();
    _failedCoupons = GetIt.instance<GetFailedCoupons>()('shop123');
  }

  Future<void> _generateAndSharePdf() async {
    final coupons = await _failedCoupons;
    if (coupons.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No failed coupons to report')),
      );
      return;
    }
    final pdfFile = await PdfGenerator.generateFailedCouponsReport(coupons);
    Share.shareXFiles([XFile(pdfFile.path)], text: 'Failed Coupons Report');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Failed Coupons'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: _generateAndSharePdf,
          ),
        ],
      ),
      body: FutureBuilder<List<FailedCouponModel>>(
        future: _failedCoupons,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No failed coupons'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final coupon = snapshot.data![index];
              return ListTile(
                title: Text(coupon.couponNumber),
                subtitle: Text('Reason: ${coupon.reason}'),
                trailing: Text('${coupon.enteredAt.toLocal()}'.split(' ')[0]),
              );
            },
          );
        },
      ),
    );
  }
}
