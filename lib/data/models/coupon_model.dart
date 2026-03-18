import 'package:freezed_annotation/freezed_annotation.dart';

part 'coupon_model.freezed.dart';
part 'coupon_model.g.dart';

@freezed
class CouponModel with _$CouponModel {
  const factory CouponModel({
    String? id,
    required String couponNumber,
    required String scanMethod, // 'barcode', 'manual', 'ocr'
    required String status,      // 'valid', 'invalid'
    required DateTime scannedAt,
    String? saleId,
    String? mechanicName,
    required String shopId,
  }) = _CouponModel;

  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);
}
