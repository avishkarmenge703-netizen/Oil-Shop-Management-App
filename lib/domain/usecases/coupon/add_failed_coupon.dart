import 'package:injectable/injectable.dart';
import 'package:oil_shop_management/data/models/failed_coupon_model.dart';
import 'package:oil_shop_management/domain/repositories/coupon_repository_interface.dart';

@injectable
class AddFailedCoupon {
  final CouponRepositoryInterface repository;

  AddFailedCoupon(this.repository);

  Future<void> call(FailedCouponModel failedCoupon) async {
    await repository.saveFailedCoupon(failedCoupon);
  }
}
