import 'package:get/get.dart';
import '../data/portfolio_data.dart';

class ProjectsController extends GetxController {
  final List<ProjectData> projects = PortfolioData.projects;
  final RxBool showAll = false.obs;

  void toggleShowAll() {
    showAll.value = true;
  }
}
