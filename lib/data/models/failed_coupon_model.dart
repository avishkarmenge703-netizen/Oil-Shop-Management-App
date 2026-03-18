import 'package:freezed_annotation/freezed_annotation.dart';

part 'failed_coupon_model.freezed.dart';
part 'failed_coupon_model.g.dart';

@freezed
class FailedCouponModel with _$FailedCouponModel {
  const factory FailedCouponModel({
    String? id,
    required String couponNumber,
    required String reason,      // 'barcode_unreadable', 'ocr_failed'
    String? imagePath,
    required DateTime enteredAt,
    @Default(false) bool resolved,
    required String shopId,
  }) = _FailedCouponModel;

  factory FailedCouponModel.fromJson(Map<String, dynamic> json) =>
      _$FailedCouponModelFromJson(json);
}
