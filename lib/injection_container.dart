import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:oil_shop_management/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> init() async {
  getIt.init();
}
