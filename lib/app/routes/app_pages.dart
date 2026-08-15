import 'package:get/get.dart';
import 'app_routes.dart';
import '../portfolio_home.dart';
import '../bindings/portfolio_binding.dart';
import '../sections/all_projects_page.dart';
import '../bindings/all_projects_binding.dart';

abstract class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const PortfolioHome(),
      binding: PortfolioBinding(),
    ),
    GetPage(
      name: Routes.PROJECTS,
      page: () => const AllProjectsPage(),
      binding: AllProjectsBinding(),
    ),
  ];
}
