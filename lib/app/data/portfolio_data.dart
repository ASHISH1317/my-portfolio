class PortfolioData {
  static const String name = "Ashish";
  static const String fullName = "Ashish Vasava";
  static const String title = "Senior Flutter Developer";
  static const String heroTagline = "Hi, I'm Ashish";
  static const String heroSubTagline = "Senior Flutter Developer with 4+ years of experience crafting high-performance, production-grade mobile applications. Specializing in Clean Architecture, robust state management, and seamless system integrations that drive user engagement and business growth.";
  
  static const String aboutText1 = "Senior Flutter Developer with 4+ years of experience crafting high-performance, production-grade mobile applications. Specializing in Clean Architecture, robust state management, and seamless system integrations that drive user engagement and business growth.";
  static const String aboutText2 = "Currently leading engineering efforts as Tech Lead at Dharma Tech, I translate client visions into scalable, pixel-perfect cross-platform products. Previously, at IT Futurz, I engineered real-time apps and mastered reactive programming.";
  static const String aboutText3 = "I focus on delivering real business value—combining clean, maintainable codebases with optimized performance to achieve stellar App Store ratings and high user retention. Let's build something exceptional together.";

  static const List<Map<String, String>> stats = [
    {"value": "4+", "label": "Years Experience"},
    {"value": "7+", "label": "Projects Delivered"},
    {"value": "15+", "label": "Technologies"},
    {"value": "5+", "label": "App Store Launches"},
  ];

  static const List<SkillCategory> skills = [
    SkillCategory(
      name: "Core Focus",
      skills: [
        SkillItem(name: "Flutter", level: 0.98),
        SkillItem(name: "Dart", level: 0.95),
        SkillItem(name: "Clean Architecture", level: 0.90),
        SkillItem(name: "Android SDK / Java", level: 0.80),
        SkillItem(name: "GoLang", level: 0.70),
      ],
    ),
    SkillCategory(
      name: "State & Logic",
      skills: [
        SkillItem(name: "GetX State Management", level: 0.95),
        SkillItem(name: "Riverpod / Provider", level: 0.90),
        SkillItem(name: "BLoC Pattern", level: 0.85),
        SkillItem(name: "Reactive Programming (Rx)", level: 0.88),
      ],
    ),
    SkillCategory(
      name: "Integrations & Maps",
      skills: [
        SkillItem(name: "Google Maps SDK & Geolocation", level: 0.92),
        SkillItem(name: "Stripe & Payment Gateways", level: 0.90),
        SkillItem(name: "Socket.IO / WebSockets", level: 0.88),
        SkillItem(name: "REST APIs & Retrofit", level: 0.95),
      ],
    ),
    SkillCategory(
      name: "Backend & Cloud",
      skills: [
        SkillItem(name: "Firebase (Auth, DB, Messaging)", level: 0.92),
        SkillItem(name: "Supabase Realtime Services", level: 0.85),
        SkillItem(name: "AWS Cloud Operations", level: 0.75),
      ],
    ),
    SkillCategory(
      name: "Web & No-Code",
      skills: [
        SkillItem(name: "Shopify (Hydrogen Framework)", level: 0.80),
        SkillItem(name: "Framer No-code Tool", level: 0.85),
      ],
    ),
  ];

  static const List<ProjectData> projects = [
    ProjectData(
      title: "HOGR — The Food App",
      description: "A modern food discovery and social dining platform enabling users to explore trending dishes, share experiences, and connect with food lovers.",
      tags: ["Flutter", "Supabase", "Firebase"],
      projectUrl: "https://hogr.app",
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuAeLH5eKP2lmezCLljsHMfrkirqkdwDyTVGuWywhSnIUyaB4hmDPx6BqNEys5XblhnBJzuZM5I7I6Gcd2RPNCMiQ1hEeO5ekgvubEqHBvAA6SfsMZtlQgikLJ-4j3zpBzENku0r5K9qL-7eKoLXlDjaBE16ti66QFu1iS7SE-8acbmHF04Gs1_2u4XYoPtc4lwSK5LjFDwfiyuN77fUV36I1xjYBYcg1vcNvH0Uf911yT8m08whpW84feKEstY8l5lqzDRyDTK_2DQR",
      backgroundStory: "HOGR emerged from a simple observation: dining is inherently social, yet digital food apps remain isolated transactions. We set out to build an architecture that handles high-frequency social interactions with real-time updates while maintaining a slick, minimal interface.\n\nThe challenge was orchestrating a complex backend ecosystem—combining Supabase's real-time capabilities for social feeds with Firebase's robust authentication and notification infrastructure. The result is a seamless, lag-free experience that feels as intuitive as a conversation over dinner.",
      keyFeatures: [
        FeatureItem(
          title: "Real-time Social Dining",
          description: "Connect with friends, share reviews, and see what's trending in your circle instantly.",
        ),
        FeatureItem(
          title: "Smart Restaurant Discovery",
          description: "AI-driven recommendations based on your taste profile and social graph.",
        ),
        FeatureItem(
          title: "Seamless Payment Integration",
          description: "One-tap bill splitting and secure transactions through Stripe.",
        ),
      ],
      techStack: [
        TechItem(name: "Flutter", icon: "flutter"),
        TechItem(name: "Dart", icon: "terminal"),
        TechItem(name: "Supabase", icon: "database"),
        TechItem(name: "Firebase", icon: "local_fire_department"),
        TechItem(name: "REST APIs", icon: "api"),
        TechItem(name: "GetX Logic", icon: "rebase_edit"),
      ],
      codeSnippetPath: "lib/app/modules/home/bindings/home_binding.dart",
      codeSnippet: "class HomeBinding extends Bindings {\n  @override\n  void dependencies() {\n    Get.lazyPut<HomeController>(() => HomeController());\n    Get.lazyPut<HomeProvider>(() => HomeProvider());\n    Get.lazyPut<HomeRepository>(() => HomeRepository(\n      provider: Get.find()\n    ));\n  }\n}",
      screenshots: [
        "https://lh3.googleusercontent.com/aida-public/AB6AXuBnaNT0vYNhNQoHBOaDphsrf_dLR-KdOmBRsll5lmSoii9PjSshUd_icAGCMNC_mmX-cg7C3qgFINCZ4aEOcUzul4LnBBfDhMz8OCvTOLgnnz9Vq91yJGghREI5GWJZjEUZD0Ukia_fQBTQf5ui8sDRLM-OjnuG5efbTQdk_nnPWKBYlZGuJDt2CUj0FLzae6MPFfrADkXnq-E3HespGMDgQPyQkgC2onuUQmmO1uupFd71hlor3RZUXlaMXPhBPp8t0F8JyoX2YpKB",
        "https://lh3.googleusercontent.com/aida-public/AB6AXuBPzFbG_fjFr9xb5aVPA8mqoMZqLVg0OzCIB2q42LvBfdPGF93PU7XHey_eacWlCCpWsIHtg4tguoqjWH6imoDslkNLYPCKAqGExAdx7s-oYmOiMSCfSkPvClHlSEsShsiOfNBLbb2j42cm5pAvsMB8yGbmyTxwRS4mk88tLpmB7MtXv6DzUbrA1XZE5DSEFDq222ern6SnM7AHzT3XfEU7PlfQpJr8tdjKoIPoVEj5xhRS-5IK8iiLSq8KzEPNUEM--EI64Di_iO5N",
        "https://lh3.googleusercontent.com/aida-public/AB6AXuAEkEeWwwD6ldZzt5640bcBKZQkOrLruuuxHliGDqyMBS0gFDhxfXf1oIMRs-WK5Gzq32bkWEdPB_u7xb-qGpZLzJwgfmQlaHnjXwZKgUL3pQ3GN6CJcDEFvR90ApBjos31sIFD2zGDBpVQR61C79HKdPIsuC-0zmQXAKUjLbgC4ikQhkvWBC6Zo9NU2E4oLmPfSHlaPA382lErTrb0q518VtQT8yToSNGBcXE4OLw-_0fXazShCH_9jziMH9XFcJ6UzZxG8LcRjl0e",
        "https://lh3.googleusercontent.com/aida-public/AB6AXuDf23w4Up9YGD-ehp-B7dY25dIHl1sPDaZrTY0_hNepbuKeUn7SrbI7SDbt5PYFfxyQMhgU0-amUpFHsQb_mGgpZFB9eJVjK8GCuXVW3aoUh_07z8Wz2BhwK6EkfqsdtPBflSA4vkpEU3kzyeqedvD82c0MrRn-l4DE0g4ezPSO8ji8qQ0u6k4g1KSU1xeXVWxq5YgqCxve8YpNCzK9dnfdbqwpExVQIszTANNmmvkhckXD2QmZfIIbZVrrXQHY4AuP2FTBY_dGo1qg",
      ],
      integrations: [
        IntegrationItem(title: "Google Maps SDK", icon: "map"),
        IntegrationItem(title: "Stripe Payments", icon: "payments"),
        IntegrationItem(title: "Push Notifications", icon: "notifications_active"),
      ],
    ),
    ProjectData(
      title: "NexRev Freedom",
      description: "A facility and energy management app providing real-time control of building systems, including HVAC units, energy consumption, and alarms.",
      tags: ["Flutter", "Firebase", "REST APIs"],
      projectUrl: "https://nexrev.com",
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuAQrH0Hf3dwEVpsSvt6TWIJT8Yxq8qe3tKjdUIqeXwa8wTtUEDVBqoQaCpfLmx8cNEipzGpZcKQi_47zcRywv3gIntfRqwHCYrInK5hTKT69ScHqA95WAZbNEmwEtdnrVFBwd6FsoIZcwE_eYF31TmgqSOhhB-xw-J5Ig9gR1CYYYjPw2yPcHyWZjwmF7Fmd2JqYnSrL0LRHgszsCBl6HrIAwP-XgxG1kadXZTaheeUdZvcNrDXMavgh7C7HVVvQ2LO2MpCbVxarNL3",
      backgroundStory: "NexRev Freedom was built to solve energy waste in commercial building portfolios. We developed an enterprise-grade IoT companion app that communicates with building controllers to monitor and adjust HVAC units, lighting grids, and electrical loads in real-time.\n\nThe challenge was ensuring dynamic updates were broadcast quickly to a multi-platform frontend, resolving connection drops and providing rapid alarms when safety parameters were violated.",
      keyFeatures: [
        FeatureItem(
          title: "Real-time IoT Monitoring",
          description: "Real-time telemetry visualization of HVAC and electric load systems.",
        ),
        FeatureItem(
          title: "Facility Control & Schedules",
          description: "Schedule heating/cooling setpoints and control building states remotely.",
        ),
        FeatureItem(
          title: "Alarm & Alert Management",
          description: "Instant push notifications and live logs when telemetry values exceed thresholds.",
        ),
      ],
      techStack: [
        TechItem(name: "Flutter", icon: "flutter"),
        TechItem(name: "Dart", icon: "terminal"),
        TechItem(name: "Firebase", icon: "local_fire_department"),
        TechItem(name: "REST APIs", icon: "api"),
        TechItem(name: "Socket.IO", icon: "sync"),
        TechItem(name: "GetX Logic", icon: "rebase_edit"),
      ],
      codeSnippetPath: "lib/app/modules/facility/controllers/facility_controller.dart",
      codeSnippet: "class FacilityController extends GetxController {\n  final FacilityRepository repository;\n  var isCooling = false.obs;\n\n  void toggleCooling(String facilityId) async {\n    final status = await repository.setCooling(facilityId, !isCooling.value);\n    isCooling.value = status;\n  }\n}",
      screenshots: [
        "https://lh3.googleusercontent.com/aida-public/AB6AXuBPzFbG_fjFr9xb5aVPA8mqoMZqLVg0OzCIB2q42LvBfdPGF93PU7XHey_eacWlCCpWsIHtg4tguoqjWH6imoDslkNLYPCKAqGExAdx7s-oYmOiMSCfSkPvClHlSEsShsiOfNBLbb2j42cm5pAvsMB8yGbmyTxwRS4mk88tLpmB7MtXv6DzUbrA1XZE5DSEFDq222ern6SnM7AHzT3XfEU7PlfQpJr8tdjKoIPoVEj5xhRS-5IK8iiLSq8KzEPNUEM--EI64Di_iO5N",
        "https://lh3.googleusercontent.com/aida-public/AB6AXuAEkEeWwwD6ldZzt5640bcBKZQkOrLruuuxHliGDqyMBS0gFDhxfXf1oIMRs-WK5Gzq32bkWEdPB_u7xb-qGpZLzJwgfmQlaHnjXwZKgUL3pQ3GN6CJcDEFvR90ApBjos31sIFD2zGDBpVQR61C79HKdPIsuC-0zmQXAKUjLbgC4ikQhkvWBC6Zo9NU2E4oLmPfSHlaPA382lErTrb0q518VtQT8yToSNGBcXE4OLw-_0fXazShCH_9jziMH9XFcJ6UzZxG8LcRjl0e",
      ],
      integrations: [
        IntegrationItem(title: "BMS Controller API", icon: "dns"),
        IntegrationItem(title: "Socket.IO", icon: "sync"),
        IntegrationItem(title: "Firebase Cloud Messaging", icon: "notifications_active"),
      ],
    ),
    ProjectData(
      title: "StagePay",
      description: "A construction management and payment platform streamlining collaboration between clients and contractors with secure wallet funding.",
      tags: ["Flutter", "Firebase", "Stripe"],
      projectUrl: "https://stagepay.com",
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuDR5-8gwe1GGxHAikXXFAAOaiyB32YmMGbMa2mOP1mKRRkzwMFDyZVbkQtt7hPn4U_z9JGXJ2u26ohQ13qtM_p_JM2nhJWi4p1P52dPoM0-lmhZwpn9dxI3YD02emmZnQJVkM990XiKVVFJTZH65ABwM2uX2B4Dpp6pl8iMlToLOOLFMgNutdN47V64XlT0W-8Dsb_19eHikqQ_MIEuZ6jjxCYQIuncDdY4YHxmDqGH2NEmp_UQJB8KEPKhz5CquRMkTT32g6SU6eWX",
      backgroundStory: "StagePay was created to streamline construction payments and milestone tracking. By introducing a secure escrow-like payment workflow, it ensures that contractors get paid on time for completed milestones, and clients only release funds upon verification.",
      keyFeatures: [
        FeatureItem(
          title: "Milestone Tracking",
          description: "Break down projects into structured stages with distinct verification requirements.",
        ),
        FeatureItem(
          title: "Escrow Funding & Stripe",
          description: "Secure payment processing and funding with instant payouts.",
        ),
        FeatureItem(
          title: "Multi-user Collaboration",
          description: "Live chat, photo uploads, and contract signing for clients and contractors.",
        ),
      ],
      techStack: [
        TechItem(name: "Flutter", icon: "flutter"),
        TechItem(name: "Dart", icon: "terminal"),
        TechItem(name: "Firebase", icon: "local_fire_department"),
        TechItem(name: "Stripe", icon: "payments"),
        TechItem(name: "REST APIs", icon: "api"),
        TechItem(name: "Riverpod State", icon: "rebase_edit"),
      ],
      codeSnippetPath: "lib/app/modules/milestone/repositories/milestone_repository.dart",
      codeSnippet: "class MilestoneRepository {\n  final StripeService _stripeService;\n  \n  Future<bool> releaseMilestoneFunds(String milestoneId) async {\n    final success = await _stripeService.capturePayment(milestoneId);\n    return success;\n  }\n}",
      screenshots: [
        "https://lh3.googleusercontent.com/aida-public/AB6AXuDf23w4Up9YGD-ehp-B7dY25dIHl1sPDaZrTY0_hNepbuKeUn7SrbI7SDbt5PYFfxyQMhgU0-amUpFHsQb_mGgpZFB9eJVjK8GCuXVW3aoUh_07z8Wz2BhwK6EkfqsdtPBflSA4vkpEU3kzyeqedvD82c0MrRn-l4DE0g4ezPSO8ji8qQ0u6k4g1KSU1xeXVWxq5YgqCxve8YpNCzK9dnfdbqwpExVQIszTANNmmvkhckXD2QmZfIIbZVrrXQHY4AuP2FTBY_dGo1qg",
        "https://lh3.googleusercontent.com/aida-public/AB6AXuAEkEeWwwD6ldZzt5640bcBKZQkOrLruuuxHliGDqyMBS0gFDhxfXf1oIMRs-WK5Gzq32bkWEdPB_u7xb-qGpZLzJwgfmQlaHnjXwZKgUL3pQ3GN6CJcDEFvR90ApBjos31sIFD2zGDBpVQR61C79HKdPIsuC-0zmQXAKUjLbgC4ikQhkvWBC6Zo9NU2E4oLmPfSHlaPA382lErTrb0q518VtQT8yToSNGBcXE4OLw-_0fXazShCH_9jziMH9XFcJ6UzZxG8LcRjl0e",
      ],
      integrations: [
        IntegrationItem(title: "Stripe Connect", icon: "payments"),
        IntegrationItem(title: "Firebase Storage", icon: "folder_shared"),
        IntegrationItem(title: "Push Notifications", icon: "notifications_active"),
      ],
    ),
  ];

  static const List<ExperienceData> experiences = [
    ExperienceData(
      role: "Flutter Developer (Tech Lead)",
      company: "Dharma Tech",
      period: "Jul, 2022 — Present",
      location: "Surat, Gujarat, India",
      isCurrent: true,
      bulletIcon: "check_circle",
      tags: [
        "Socket.IO",
        "GetX",
        "Riverpod",
        "Clean Architecture",
        "Team Mentorship",
      ],
      bullets: [
        "Architecting scalable mobile applications using clean code principles and modular widget composition.",
        "Implementing real-time communication via Socket.IO and secure cloud-based authentication systems.",
      ],
    ),
    ExperienceData(
      role: "Flutter Developer (Intern)",
      company: "IT Futurz",
      period: "Apr, 2021 — Jun, 2022",
      location: "Surat, Gujarat, India",
      isCurrent: false,
      bulletIcon: "terminal",
      tags: [
        "Dart",
        "GoLang",
        "Java",
        "UI/UX Implementation",
      ],
      bullets: [
        "Developed proficiency in GetX state management for maintainable cross-platform applications.",
        "Gained hands-on experience with Dart, Java, and GoLang integration within the Flutter ecosystem.",
      ],
    ),
  ];

  static const List<EducationData> education = [
    EducationData(
      role: "Student", // dummy field to match previous if any, let's keep degree, institution
      degree: "BE (Information Technology)",
      institution: "LD College of Engineering, Ahmedabad",
      period: "2017 — 2021",
      grade: "CGPA: 7.58",
    ),
  ];

  static const String email = "ashishvasava0346@gmail.com";
  static const String phone = "+91 99136 29852";
  static const String location = "Surat, Gujarat, India";
  
  static const String github1 = "https://github.com/ASHISH1317";
  static const String github2 = "https://github.com/AshishDT";
  static const String linkedin = "https://www.linkedin.com/in/ashish-vasava";
  static const String instagram = "https://www.instagram.com/theboywholovesdarkness?igsh=cDRxNnVwZTV3NDhl";
  static const String whatsapp = "https://wa.me/919913629852";
  static const String twitter = "https://twitter.com";
  static const String emailUrl = "mailto:ashishvasava0346@gmail.com";

  static const List<PackageData> packages = [
    PackageData(
      title: "auto_dispose_mixin",
      description: "A lightweight, flexible Flutter mixin to automatically dispose of controllers, subscriptions, and other resources to prevent memory leaks.",
      tags: ["Dart", "Flutter", "Memory Management", "Clean Code"],
      pubUrl: "https://pub.dev/packages/auto_dispose_mixin",
      installCommand: "flutter pub add auto_dispose_mixin",
      keyHighlights: [
        "Automatic Resource Cleanup",
        "Prevents Memory Leaks",
        "Supports AnimationControllers & Streams",
        "Clean Lifecycle Hooks"
      ],
      mockupType: "auto_dispose",
    ),
    PackageData(
      title: "dio_api_kit",
      description: "A lightweight, backend-agnostic API layer built on top of Dio with configurable success handling, centralized error management, and clean architecture support.",
      tags: ["Dio Wrapper", "Clean Architecture", "API Client", "Networking"],
      pubUrl: "https://pub.dev/packages/dio_api_kit",
      installCommand: "flutter pub add dio_api_kit",
      keyHighlights: [
        "Centralized API Init",
        "Configurable Success Resolvers",
        "Typed API Response Models",
        "Unified Error Interception"
      ],
      mockupType: "dio_api_kit",
    ),
    PackageData(
      title: "flying_characters",
      description: "A Flutter package to animate flying characters or particles on the screen to create playful, engaging, and interactive user interface experiences.",
      tags: ["Animations", "Particles", "Playful UI", "Visual Effects"],
      pubUrl: "https://pub.dev/packages/flying_characters",
      installCommand: "flutter pub add flying_characters",
      keyHighlights: [
        "Custom Character Particles",
        "Smooth 60FPS Animations",
        "Highly Configurable Physics",
        "Simple Declarative API"
      ],
      mockupType: "flying_characters",
    ),
    PackageData(
      title: "state_illustrator",
      description: "A Flutter package for handling and visualizing various screen states (loading, empty, error, success) with custom animations and layouts.",
      tags: ["State UI", "Illustrations", "Custom Themes", "UX Transitions"],
      pubUrl: "https://pub.dev/packages/state_illustrator",
      installCommand: "flutter pub add state_illustrator",
      keyHighlights: [
        "Clean Screen Transitions",
        "Pre-configured State Templates",
        "Highly Customizable Themes",
        "Lottie/SVG support built-in"
      ],
      mockupType: "state_illustrator",
    ),
  ];
}

class SkillCategory {
  final String name;
  final List<SkillItem> skills;

  const SkillCategory({required this.name, required this.skills});
}

class SkillItem {
  final String name;
  final double level;

  const SkillItem({required this.name, required this.level});
}

class FeatureItem {
  final String title;
  final String description;

  const FeatureItem({required this.title, required this.description});
}

class TechItem {
  final String name;
  final String icon;

  const TechItem({required this.name, required this.icon});
}

class IntegrationItem {
  final String title;
  final String icon;

  const IntegrationItem({required this.title, required this.icon});
}

class ProjectData {
  final String title;
  final String description;
  final List<String> tags;
  final String projectUrl;
  final String imageUrl;
  final String backgroundStory;
  final List<FeatureItem> keyFeatures;
  final List<TechItem> techStack;
  final String codeSnippetPath;
  final String codeSnippet;
  final List<String> screenshots;
  final List<IntegrationItem> integrations;

  const ProjectData({
    required this.title,
    required this.description,
    required this.tags,
    required this.projectUrl,
    required this.imageUrl,
    required this.backgroundStory,
    required this.keyFeatures,
    required this.techStack,
    required this.codeSnippetPath,
    required this.codeSnippet,
    required this.screenshots,
    required this.integrations,
  });
}

class ExperienceData {
  final String role;
  final String company;
  final String period;
  final String location;
  final List<String> bullets;
  final bool isCurrent;
  final List<String> tags;
  final String bulletIcon;

  const ExperienceData({
    required this.role,
    required this.company,
    required this.period,
    required this.location,
    required this.bullets,
    this.isCurrent = false,
    this.tags = const [],
    this.bulletIcon = "check_circle",
  });
}

class EducationData {
  final String degree;
  final String institution;
  final String period;
  final String grade;
  final String role;

  const EducationData({
    required this.degree,
    required this.institution,
    required this.period,
    required this.grade,
    this.role = "",
  });
}

class PackageData {
  final String title;
  final String description;
  final List<String> tags;
  final String pubUrl;
  final String installCommand;
  final List<String> keyHighlights;
  final String mockupType;

  const PackageData({
    required this.title,
    required this.description,
    required this.tags,
    required this.pubUrl,
    required this.installCommand,
    required this.keyHighlights,
    required this.mockupType,
  });
}
