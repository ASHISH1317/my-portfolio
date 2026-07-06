import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntegrationData {
  final String title;
  final IconData icon;

  const IntegrationData({required this.title, required this.icon});
}

class SkillsController extends GetxController {
  final List<IntegrationData> allIntegrations = const [
    IntegrationData(title: "Supabase", icon: Icons.storage),
    IntegrationData(title: "Firebase", icon: Icons.local_fire_department),
    IntegrationData(title: "AWS", icon: Icons.cloud),
    IntegrationData(title: "Google Maps", icon: Icons.map),
    IntegrationData(title: "Stripe", icon: Icons.payments),
    IntegrationData(title: "Razorpay", icon: Icons.account_balance_wallet),
    IntegrationData(title: "REST APIs", icon: Icons.api),
    IntegrationData(title: "GoLang", icon: Icons.terminal),
    IntegrationData(title: "Socket.IO", icon: Icons.sync),
    IntegrationData(title: "Push Alerts", icon: Icons.notifications_active),
    IntegrationData(title: "SQLite / Hive", icon: Icons.dns),
    IntegrationData(title: "Sentry / Crash", icon: Icons.bug_report),
    IntegrationData(title: "GraphQL", icon: Icons.hub),
    IntegrationData(title: "BLE Bluetooth", icon: Icons.bluetooth),
    IntegrationData(title: "CI/CD Pipelines", icon: Icons.build_circle),
    IntegrationData(title: "RevenueCat", icon: Icons.monetization_on),
    IntegrationData(title: "WebRTC", icon: Icons.videocam),
    IntegrationData(title: "Mapbox SDK", icon: Icons.explore),
    IntegrationData(title: "GetIt / Inject", icon: Icons.extension),
    IntegrationData(title: "OAuth 2.0", icon: Icons.vpn_key),
  ];

  late final RxList<IntegrationData> currentDisplayList;
  late final List<IntegrationData> poolList;
  final RxBool showAll = false.obs;
  Timer? _cycleTimer;
  int _lastWipedIndex = -1;
  final Random _random = Random();
  
  final RxList<bool> tileTriggers = List.filled(20, false).obs;

  @override
  void onInit() {
    super.onInit();
    currentDisplayList = RxList<IntegrationData>(allIntegrations.take(8).toList());
    poolList = allIntegrations.skip(8).toList();
    startAutoCycle();
  }

  @override
  void onClose() {
    stopAutoCycle();
    super.onClose();
  }

  void startAutoCycle() {
    _cycleTimer?.cancel();
    _cycleTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (showAll.value) return;
      wipeAndCycleRandomCard();
    });
  }

  void stopAutoCycle() {
    _cycleTimer?.cancel();
  }

  void wipeAndCycleRandomCard() {
    int indexToWipe = _random.nextInt(8);
    if (indexToWipe == _lastWipedIndex) {
      indexToWipe = (indexToWipe + 1) % 8;
    }
    _lastWipedIndex = indexToWipe;

    if (poolList.isNotEmpty) {
      final int poolIndex = _random.nextInt(poolList.length);
      final IntegrationData oldItem = currentDisplayList[indexToWipe];
      final IntegrationData newItem = poolList[poolIndex];

      currentDisplayList[indexToWipe] = newItem;
      poolList[poolIndex] = oldItem;
      
      tileTriggers[indexToWipe] = !tileTriggers[indexToWipe];
    }
  }

  void toggleShowAll() {
    showAll.value = !showAll.value;
    if (showAll.value) {
      currentDisplayList.assignAll(allIntegrations);
      for (int i = 0; i < tileTriggers.length; i++) {
        tileTriggers[i] = !tileTriggers[i];
      }
    } else {
      currentDisplayList.assignAll(allIntegrations.take(8).toList());
      poolList.clear();
      poolList.addAll(allIntegrations.skip(8));
    }
  }
}
