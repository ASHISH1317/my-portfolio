import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/hero_controller.dart';
import '../controllers/about_controller.dart';
import '../controllers/skills_controller.dart';
import '../controllers/experience_controller.dart';
import '../controllers/projects_controller.dart';
import '../controllers/education_controller.dart';
import '../controllers/contact_controller.dart';

class PortfolioBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController(), permanent: true);
    Get.put(HomeController(), permanent: true);
    Get.lazyPut<HeroController>(() => HeroController());
    Get.lazyPut<AboutController>(() => AboutController());
    Get.lazyPut<SkillsController>(() => SkillsController());
    Get.lazyPut<ExperienceController>(() => ExperienceController());
    Get.lazyPut<ProjectsController>(() => ProjectsController());
    Get.lazyPut<EducationController>(() => EducationController());
    Get.lazyPut<ContactController>(() => ContactController());
  }
}

