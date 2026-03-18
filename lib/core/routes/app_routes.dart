import 'package:flutter/material.dart';
import 'package:oil_shop_management/features/coupons/presentation/pages/coupon_scanner_page.dart';
import 'package:oil_shop_management/features/coupons/presentation/pages/manual_coupon_entry_page.dart';
import 'package:oil_shop_management/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:oil_shop_management/features/reports/presentation/pages/failed_coupons_list_page.dart';

class AppRoutes {
  static const String dashboard = '/';
  static const String scanCoupon = '/scan-coupon';
  static const String manualEntry = '/manual-coupon-entry';
  static const String failedCoupons = '/failed-coupons';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      case scanCoupon:
        return MaterialPageRoute(builder: (_) => const CouponScannerPage());
      case manualEntry:
        return MaterialPageRoute(builder: (_) => const ManualCouponEntryPage());
      case failedCoupons:
        return MaterialPageRoute(builder: (_) => const FailedCouponsListPage());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Page not found'))));
    }
  }
}
