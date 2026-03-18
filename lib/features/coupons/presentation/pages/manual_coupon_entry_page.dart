import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oil_shop_management/features/coupons/presentation/bloc/coupon_bloc.dart';
import 'package:oil_shop_management/core/services/ocr_service.dart'; // assume implemented

class ManualCouponEntryPage extends StatefulWidget {
  const ManualCouponEntryPage({super.key});

  @override
  State<ManualCouponEntryPage> createState() => _ManualCouponEntryPageState();
}

class _ManualCouponEntryPageState extends State<ManualCouponEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final _couponController = TextEditingController();
  String? _imagePath;
  bool _isOcrLoading = false;

  final ImagePicker _picker = ImagePicker();
  final OcrService _ocrService = OcrService();

  Future<void> _pickImageAndOcr() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() => _isOcrLoading = true);
      final file = File(image.path);
      final extracted = await _ocrService.extractTextFromImage(file);
      setState(() {
        _isOcrLoading = false;
        _couponController.text = extracted ?? '';
        _imagePath = file.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manual Coupon Entry')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _couponController,
                decoration: const InputDecoration(
                  labelText: 'Coupon Number',
                  hintText: 'Enter or scan via OCR',
                ),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _isOcrLoading ? null : _pickImageAndOcr,
                icon: const Icon(Icons.camera_alt),
                label: Text(_isOcrLoading ? 'Processing...' : 'Scan with OCR'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<CouponBloc>().add(
                          AddManualCouponEvent(
                            couponNumber: _couponController.text,
                            reason: 'barcode_scan_failed',
                            imagePath: _imagePath,
                          ),
                        );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save Failed Coupon'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

