import 'package:get/get.dart';

import '../modules/bill_home/bindings/bill_home_binding.dart';
import '../modules/bill_home/views/bill_home_view.dart';
import '../modules/edittodo/bindings/edittodo_binding.dart';
import '../modules/edittodo/views/edittodo_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.EDITTODO,
      page: () => EdittodoView(),
      binding: EdittodoBinding(),
    ),
    GetPage(
      name: _Paths.BILL_HOME,
      page: () => const BillHomeView(),
      binding: BillHomeBinding(),
    ),
  ];
}
