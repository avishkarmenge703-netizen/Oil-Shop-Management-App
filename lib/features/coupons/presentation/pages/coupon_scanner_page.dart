import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:oil_shop_management/features/coupons/presentation/bloc/coupon_bloc.dart';

class CouponScannerPage extends StatelessWidget {
  const CouponScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Coupon')),
      body: BlocConsumer<CouponBloc, CouponState>(
        listener: (context, state) {
          if (state is CouponSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Coupon saved!')),
            );
            Navigator.pop(context);
          } else if (state is CouponError) {
            _showManualEntryDialog(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is CouponLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return MobileScanner(
            onDetect: (capture) {
              final barcode = capture.barcodes.first.rawValue;
              if (barcode != null) {
                context.read<CouponBloc>().add(ScanBarcodeEvent(barcode));
              }
            },
          );
        },
      ),
    );
  }

  void _showManualEntryDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Scan Failed'),
        content: Text('$error\nEnter coupon manually:'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushNamed(context, '/manual-coupon-entry');
            },
            child: const Text('Manual Entry'),
          ),
        ],
      ),
    );
  }
}
