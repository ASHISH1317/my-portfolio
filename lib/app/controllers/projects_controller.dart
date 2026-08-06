import 'package:get/get.dart';
import '../data/portfolio_data.dart';

class ProjectsController extends GetxController {
  final RxList<ProjectData> projects = <ProjectData>[].obs;
  final RxBool showAll = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProjects();
  }

  void loadProjects() {
    projects.assignAll(PortfolioData.projects);
  }

  void toggleShowAll() {
    showAll.value = true;
  }
}
