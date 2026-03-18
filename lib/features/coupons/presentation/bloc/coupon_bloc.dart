import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oil_shop_management/data/models/coupon_model.dart';
import 'package:oil_shop_management/data/models/failed_coupon_model.dart';
import 'package:oil_shop_management/domain/usecases/coupon/add_failed_coupon.dart';
import 'package:oil_shop_management/domain/usecases/coupon/scan_coupon.dart';

part 'coupon_event.dart';
part 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  final ScanCoupon scanCoupon;
  final AddFailedCoupon addFailedCoupon;

  CouponBloc({required this.scanCoupon, required this.addFailedCoupon})
      : super(CouponInitial()) {
    on<ScanBarcodeEvent>(_onScanBarcode);
    on<AddManualCouponEvent>(_onAddManualCoupon);
  }

  Future<void> _onScanBarcode(ScanBarcodeEvent event, Emitter<CouponState> emit) async {
    emit(CouponLoading());
    try {
      final coupon = CouponModel(
        couponNumber: event.barcode,
        scanMethod: 'barcode',
        status: 'valid', // assume valid after format check
        scannedAt: DateTime.now(),
        shopId: 'shop123', // get from auth
      );
      await scanCoupon(coupon);
      emit(CouponSuccess());
    } catch (e) {
      emit(CouponError('Scan failed: $e'));
    }
  }

  Future<void> _onAddManualCoupon(AddManualCouponEvent event, Emitter<CouponState> emit) async {
    emit(CouponLoading());
    try {
      final failed = FailedCouponModel(
        couponNumber: event.couponNumber,
        reason: event.reason,
        imagePath: event.imagePath,
        enteredAt: DateTime.now(),
        shopId: 'shop123',
      );
      await addFailedCoupon(failed);
      emit(CouponSuccess());
    } catch (e) {
      emit(CouponError('Manual entry failed: $e'));
    }
  }
}
