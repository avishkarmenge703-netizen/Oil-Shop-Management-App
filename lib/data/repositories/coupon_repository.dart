import 'package:injectable/injectable.dart';
import 'package:oil_shop_management/data/datasources/remote/firestore_service.dart';
import 'package:oil_shop_management/data/models/coupon_model.dart';
import 'package:oil_shop_management/data/models/failed_coupon_model.dart';
import 'package:oil_shop_management/domain/repositories/coupon_repository_interface.dart';

@Injectable(as: CouponRepositoryInterface)
class CouponRepository implements CouponRepositoryInterface {
  final FirestoreService _firestore;

  CouponRepository(this._firestore);

  @override
  Future<void> saveCoupon(CouponModel coupon) async {
    await _firestore.addDocument('coupons', coupon.toJson());
  }

  @override
  Future<void> saveFailedCoupon(FailedCouponModel failedCoupon) async {
    await _firestore.addDocument('failed_coupons', failedCoupon.toJson());
  }

  @override
  Future<List<FailedCouponModel>> getFailedCoupons(String shopId) async {
    final snapshot = await _firestore.getCollection('failed_coupons');
    return snapshot.docs
        .map((doc) => FailedCouponModel.fromJson(doc.data() as Map<String, dynamic>).copyWith(id: doc.id))
        .where((c) => c.shopId == shopId && !c.resolved)
        .toList();
  }
}
