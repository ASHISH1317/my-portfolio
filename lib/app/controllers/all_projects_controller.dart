import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/portfolio_data.dart';

class AllProjectsController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  final RxList<ProjectData> projects = <ProjectData>[].obs;
  final RxString searchQuery = "".obs;
  final RxString selectedTag = "All".obs;
  final RxList<String> tagsList = <String>["All"].obs;
  final RxDouble scrollOpacity = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadProjects();
    extractTags();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.hasClients) {
      double offset = scrollController.offset;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        double opacity = ((offset - 100) / 150).clamp(0.0, 1.0);
        if (opacity != scrollOpacity.value) {
          scrollOpacity.value = opacity;
        }
      });
    }
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    searchController.dispose();
    super.onClose();
  }

  void loadProjects() {
    projects.assignAll(PortfolioData.projects);
  }

  void extractTags() {
    tagsList.assignAll([
      "All",
      "Flutter",
      "React / Next.js",
      "Supabase / DB",
      "AI Integration",
      "Shopify Headless",
      "IoT & BLE",
      "Payments",
    ]);
  }

  List<ProjectData> get filteredProjects {
    return projects.where((project) {
      final query = searchQuery.value.toLowerCase();
      final tag = selectedTag.value;

      final matchesQuery = query.isEmpty ||
          project.title.toLowerCase().contains(query) ||
          project.description.toLowerCase().contains(query) ||
          project.tags.any((t) => t.toLowerCase().contains(query));

      if (tag == "All") return matchesQuery;

      bool matchesTag = false;
      final lowercaseTags = project.tags.map((t) => t.toLowerCase()).toList();

      if (tag == "Flutter") {
        matchesTag = lowercaseTags.any((t) => t.contains("flutter") || t.contains("dart"));
      } else if (tag == "React / Next.js") {
        matchesTag = lowercaseTags.any((t) =>
            t.contains("react") ||
            t.contains("next.js") ||
            t.contains("typescript"));
      } else if (tag == "Supabase / DB") {
        matchesTag = lowercaseTags.any((t) =>
            t.contains("supabase") ||
            t.contains("sqlite") ||
            t.contains("hive") ||
            t.contains("drift") ||
            t.contains("database") ||
            t.contains("powersync") ||
            t.contains("postgresql"));
      } else if (tag == "AI Integration") {
        matchesTag = lowercaseTags.any((t) =>
            t.contains("ai") ||
            t.contains("openai") ||
            t.contains("gemini"));
      } else if (tag == "Shopify Headless") {
        matchesTag = lowercaseTags.any((t) =>
            t.contains("shopify") ||
            t.contains("hydrogen") ||
            t.contains("storefront"));
      } else if (tag == "IoT & BLE") {
        matchesTag = lowercaseTags.any((t) =>
            t.contains("ble") ||
            t.contains("bluetooth") ||
            t.contains("wifi") ||
            t.contains("iot"));
      } else if (tag == "Payments") {
        matchesTag = lowercaseTags.any((t) =>
            t.contains("stripe") ||
            t.contains("plaid") ||
            t.contains("payment") ||
            t.contains("apple pay") ||
            t.contains("telr") ||
            t.contains("revenuecat"));
      } else {
        matchesTag = project.tags.contains(tag);
      }

      return matchesQuery && matchesTag;
    }).toList();
  }

  void selectTag(String tag) {
    selectedTag.value = tag;
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
    if (searchController.text != query) {
      searchController.value = searchController.value.copyWith(
        text: query,
        selection: TextSelection.collapsed(offset: query.length),
      );
    }
  }
}
