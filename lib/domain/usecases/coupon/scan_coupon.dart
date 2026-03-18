import 'package:dartz/dartz.dart'; // for functional error handling (optional)
import 'package:injectable/injectable.dart';
import 'package:oil_shop_management/data/models/coupon_model.dart';
import 'package:oil_shop_management/domain/repositories/coupon_repository_interface.dart';

@injectable
class ScanCoupon {
  final CouponRepositoryInterface repository;

  ScanCoupon(this.repository);

  Future<void> call(CouponModel coupon) async {
    // You can add validation logic here
    await repository.saveCoupon(coupon);
  }
}
