import 'package:oil_shop_management/data/models/coupon_model.dart';
import 'package:oil_shop_management/data/models/failed_coupon_model.dart';

abstract class CouponRepositoryInterface {
  Future<void> saveCoupon(CouponModel coupon);
  Future<void> saveFailedCoupon(FailedCouponModel failedCoupon);
  Future<List<FailedCouponModel>> getFailedCoupons(String shopId);
}
