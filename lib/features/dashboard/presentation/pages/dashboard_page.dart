import 'package:flutter/material.dart';
import 'package:oil_shop_management/core/constants/app_strings.dart';
import 'package:oil_shop_management/core/routes/app_routes.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appName)),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuCard(context, 'Scan Coupon', Icons.qr_code_scanner, AppRoutes.scanCoupon),
          _buildMenuCard(context, 'Failed Coupons', Icons.error, AppRoutes.failedCoupons),
          _buildMenuCard(context, 'Products', Icons.inventory, '/products'),
          _buildMenuCard(context, 'Sales', Icons.shopping_cart, '/sales'),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon, String route) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(icon, size: 48), const SizedBox(height: 8), Text(title)],
        ),
      ),
    );
  }
}
