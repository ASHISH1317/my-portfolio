import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  
  // Global keys to track 8 section positions (Hero, About, Skills, Experience, Packages, Projects, Education, Contact)
  final List<GlobalKey> sectionKeys = List.generate(8, (index) => GlobalKey());
  
  final RxInt activeIndex = 0.obs;
  final RxBool isScrollingAutomatically = false.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(onScroll);
  }

  @override
  void onClose() {
    scrollController.removeListener(onScroll);
    scrollController.dispose();
    super.onClose();
  }

  void onScroll() {
    if (isScrollingAutomatically.value) return;

    int nearestIndex = 0;
    double minDistance = double.maxFinite;

    for (int i = 0; i < sectionKeys.length; i++) {
      final context = sectionKeys[i].currentContext;
      if (context != null) {
        final renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final position = renderBox.localToGlobal(Offset.zero);
          final distance = position.dy.abs();
          if (distance < minDistance) {
            minDistance = distance;
            nearestIndex = i;
          }
        }
      }
    }

    if (activeIndex.value != nearestIndex) {
      activeIndex.value = nearestIndex;
    }
  }

  void scrollToSection(int index) {
    if (index < 0 || index >= sectionKeys.length) return;

    if (scaffoldKey.currentState?.isEndDrawerOpen ?? false) {
      scaffoldKey.currentState?.closeEndDrawer();
    }

    final sectionContext = sectionKeys[index].currentContext;
    if (sectionContext != null) {
      activeIndex.value = index;
      isScrollingAutomatically.value = true;

      Scrollable.ensureVisible(
        sectionContext,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      ).then((_) {
        Future.delayed(const Duration(milliseconds: 100), () {
          isScrollingAutomatically.value = false;
        });
      });
    }
  }
}
