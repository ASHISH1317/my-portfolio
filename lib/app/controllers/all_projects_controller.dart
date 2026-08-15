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
    final Set<String> uniqueTags = {};
    for (var project in PortfolioData.projects) {
      uniqueTags.addAll(project.tags);
    }
    tagsList.assignAll(["All", ...uniqueTags]);
  }

  List<ProjectData> get filteredProjects {
    return projects.where((project) {
      final query = searchQuery.value.toLowerCase();
      final tag = selectedTag.value;

      final matchesQuery = query.isEmpty ||
          project.title.toLowerCase().contains(query) ||
          project.description.toLowerCase().contains(query) ||
          project.tags.any((t) => t.toLowerCase().contains(query));

      final matchesTag = tag == "All" || project.tags.contains(tag);

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
