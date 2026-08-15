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
      description: "A premier social dining and food discovery ecosystem. Hogr merges social networking with dining, featuring AI-powered dish discovery, real-time shared group carts, gamified loyalty coins, and interactive map exploration.",
      tags: ["Flutter", "Supabase", "Firebase", "AI Search", "Google Maps", "REST APIs"],
      projectUrl: "https://hogr.app",
      githubUrl: "",
      playStoreUrl: "https://play.google.com/store/apps/details?id=com.hogr.hogr&hl=enIN",
      appStoreUrl: "https://apps.apple.com/in/app/hogr-the-food-app/id6451259467",
      imageUrl: "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/hogr/HOGR%201.jpg",
      backgroundStory: "HOGR revolutionized digital dining by addressing a core gap: eating is inherently social, yet existing apps treated it as a cold transaction. We designed an ecosystem that couples a real-time social feed with group ordering workflows, mapping services, and intelligent recommendation systems.\n\nOur engineering challenge was syncing collaborative, multi-user shared carts with millisecond latencies, alongside processing short-form video streaming feeds smoothly on consumer devices. Leveraging Flutter's high-performance rendering and a scalable Supabase backend, HOGR delivers an engaging experience that is both visually stunning and operationally robust.",
      keyFeatures: [
        FeatureItem(
          title: "AI-Powered Dish Search",
          description: "Smart semantic search engine allowing users to find specific dishes and restaurants using AI natural language matching.",
        ),
        FeatureItem(
          title: "Real-time Shared Carts",
          description: "Collaborative ordering system allowing multiple users to add items to a single active cart in real-time.",
        ),
        FeatureItem(
          title: "Food Reels & Shorts",
          description: "Immersive short video engine showcasing local street food, reviews, and trending dining recommendations.",
        ),
        FeatureItem(
          title: "Gamified Coin System",
          description: "Social rewards loyalty engine where diners earn coins for reviews, referrals, and dining challenges.",
        ),
        FeatureItem(
          title: "Interactive Dine-In & Maps",
          description: "Geolocated restaurant discovery, interactive table bookings, and routing using Google Maps SDK.",
        ),
        FeatureItem(
          title: "Social Network & Connections",
          description: "Follow friends, build customized foodie circles, and share public dining recommendations.",
        ),
      ],
      techStack: [
        TechItem(name: "Flutter", icon: "flutter"),
        TechItem(name: "Dart", icon: "terminal"),
        TechItem(name: "Supabase Realtime", icon: "database"),
        TechItem(name: "Firebase Suite", icon: "local_fire_department"),
        TechItem(name: "Google Maps SDK", icon: "map"),
        TechItem(name: "AI Search APIs", icon: "api"),
        TechItem(name: "GetX Architecture", icon: "rebase_edit"),
      ],
      codeSnippetPath: "lib/app/modules/home/bindings/home_binding.dart",
      codeSnippet: "class HomeBinding extends Bindings {\n  @override\n  void dependencies() {\n    Get.lazyPut<HomeController>(() => HomeController());\n    Get.lazyPut<HomeProvider>(() => HomeProvider());\n    Get.lazyPut<HomeRepository>(() => HomeRepository(\n      provider: Get.find()\n    ));\n  }\n}",
      screenshots: [
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/hogr/HOGR%201.jpg",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/hogr/HOGR%202.jpg",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/hogr/HOGR%203.jpg",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/hogr/HOGR%204.jpg",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/hogr/HOGR%205.jpg",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/hogr/HOGR%206.jpg",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/hogr/HOGR%207.jpg",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/hogr/HOGR%208.jpg",
      ],
      integrations: [
        IntegrationItem(title: "Google Maps SDK Integration", icon: "map"),
        IntegrationItem(title: "AI Search Matcher API", icon: "api"),
        IntegrationItem(title: "Shared Collaborative Cart", icon: "shopping_cart"),
        IntegrationItem(title: "Food Reels Video Engine", icon: "movie"),
        IntegrationItem(title: "Gamified Coins & Rewards", icon: "monetization_on"),
        IntegrationItem(title: "Push Notifications Engine", icon: "notifications_active"),
      ],
    ),
    ProjectData(
      title: "Trainovate",
      description: "A modern e-learning ecosystem featuring secure video lectures, interactive quizzes, progress tracking, and custom certificate generation. Built with standard state management and integrated with Paymongo, Apple Pay, and In-App Purchases, featuring robust corporate group licensing.",
      tags: ["Flutter", "Node.js", "GetX", "Next.js", "PostgreSQL", "Socket.IO"],
      projectUrl: "https://new.trainovate.org/",
      githubUrl: "",
      playStoreUrl: "https://play.google.com/store/apps/details?id=com.trainovate.app&hl=en_IN",
      appStoreUrl: "https://apps.apple.com/us/app/trainovate/id6752285691",
      imageUrl: "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/trainovate/website/Trainovate-website-1.png",
      backgroundStory: "Trainovate was built to solve a critical issue in regional e-learning: providing high-quality, flexible, and interactive courses with localized payments and group coordination support. I engineered the cross-platform mobile app in Flutter using GetX, while the system is powered by a high-concurrency Node.js microservices backend and a Next.js front-end.\n\nA significant achievement was building the Corporate Group system, allowing companies to buy seat licenses, bulk-manage user allocations asynchronously via BullMQ/Redis worker queues, and track employee learning metrics. I also implemented localized regional payments (Paymongo with GCash/PayMaya) and native iOS In-App Purchase logic, handling sandbox/production verification securely.",
      keyFeatures: [
        FeatureItem(
          title: "Structured Video Learning",
          description: "Organized course modules, video lessons with secure playback, progress bookmarking, and resume-from-left-off logic.",
        ),
        FeatureItem(
          title: "Corporate Groups & Licenses",
          description: "Administrative tools for corporations to buy seats, bulk-assign courses to employees, and monitor training progress.",
        ),
        FeatureItem(
          title: "Multi-Gateway Payments",
          description: "Seamless localized payments using Paymongo (GCash, PayMaya, PHP cards) alongside native iOS In-App Purchases.",
        ),
        FeatureItem(
          title: "Interactive Assessments",
          description: "Engaging quiz structures including MCQs, open-book questions, and interactive H5P learning models.",
        ),
        FeatureItem(
          title: "Auto-Generated Certifications",
          description: "Automated verification of completion criteria followed by dynamic PDF certificate generation and secure hosting.",
        ),
        FeatureItem(
          title: "Admin Management Dashboard",
          description: "A feature-rich admin panel built in React utilizing Ant Design for managing courses, tracking progress, and audit logging.",
        ),
      ],
      techStack: [
        TechItem(name: "Flutter", icon: "flutter"),
        TechItem(name: "GetX", icon: "rebase_edit"),
        TechItem(name: "Node.js", icon: "code"),
        TechItem(name: "Next.js", icon: "web"),
        TechItem(name: "React.js", icon: "terminal"),
        TechItem(name: "PostgreSQL", icon: "database"),
        TechItem(name: "Redis & Bull", icon: "queue"),
        TechItem(name: "Socket.IO", icon: "bolt"),
      ],
      codeSnippetPath: "lib/app/modules/checkout/controllers/checkout_controller.dart",
      codeSnippet: "class CheckoutController extends GetxController {\n  final InAppPurchase _iap = InAppPurchase.instance;\n  StreamSubscription<List<PurchaseDetails>>? _subscription;\n  RxBool isLoading = false.obs;\n\n  Future<void> purchaseCourseIOS(String courseId) async {\n    isLoading(true);\n    final bool available = await _iap.isAvailable();\n    if (!available) {\n      showError('In-App Purchases are not available on this device');\n      return;\n    }\n\n    final ProductDetailsResponse response = await _iap.queryProductDetails({IosIapData.kCoursePurchaseId});\n    if (response.productDetails.isEmpty) {\n      showError('Course purchase product not found');\n      return;\n    }\n\n    final ProductDetails productDetails = response.productDetails.first;\n    _subscription = _iap.purchaseStream.listen((purchaseList) async {\n      for (var purchase in purchaseList) {\n        if (purchase.status == PurchaseStatus.purchased) {\n          await verifyAndCompletePurchase(purchase, courseId);\n        } else if (purchase.status == PurchaseStatus.error) {\n          showError(purchase.error?.message);\n          isLoading(false);\n        }\n      }\n    });\n\n    await _iap.buyNonConsumable(purchaseParam: PurchaseParam(productDetails: productDetails));\n  }\n}",
      screenshots: [
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/trainovate/app/Trainovate-app-1.jpg",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/trainovate/app/Trainovate-app-2.jpg",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/trainovate/app/Trainovate-app-3.jpg",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/trainovate/app/Trainovate-app-4.jpg",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/trainovate/app/Trainovate-app-5.jpg",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/trainovate/app/Trainovate-app-6.jpg",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/trainovate/app/Trainovate-app-7.jpg",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/trainovate/app/Trainovate-app-8.jpg",
      ],
      webScreenshots: [
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/trainovate/website/Trainovate-website-1.png",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/trainovate/website/Trainovate-website-2.png",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/trainovate/website/Trainovate-website-3.png",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/trainovate/website/Trainovate-website-4.png",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/trainovate/website/Trainovate-website-5.png",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/trainovate/website/Trainovate-website-6.png",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/trainovate/website/Trainovate-website-7.png",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/trainovate/website/Trainovate-website-8.png",
      ],
      integrations: [
        IntegrationItem(title: "Paymongo Regional Payment Gateway", icon: "payment"),
        IntegrationItem(title: "iOS In-App Purchases & Apple Pay", icon: "apple"),
        IntegrationItem(title: "FCM Push Notifications System", icon: "notifications_active"),
        IntegrationItem(title: "OAuth Authentication (Apple & Google)", icon: "security"),
        IntegrationItem(title: "Interactive H5P Content Hosting", icon: "extension"),
        IntegrationItem(title: "AWS S3 Cloud Assets Management", icon: "cloud_done"),
      ],
    ),
    ProjectData(
      title: "YP Club",
      description: "A private, invite-only founder network and business community platform. It facilitates curated peer-to-peer networking, event booking, AI-matched founder dinners, and business referrals.",
      tags: ["Flutter", "React Native", "TypeScript", "GraphQL", "Biometrics", "Telr SDK"],
      projectUrl: "",
      githubUrl: "",
      playStoreUrl: "https://play.google.com/store/apps/details?id=com.ypclub.app",
      appStoreUrl: "https://apps.apple.com/us/app/yp-club/id6476503681",
      imageUrl: "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/yp-club/yp-club-1.jpg",
      backgroundStory: "YP Club is a premium, private founder community based in Dubai. The platform's mobile experience was engineered in two distinct architectures: initially built in Flutter using GetX state management, and subsequently migrated to React Native with TypeScript. The Flutter app utilized GetX bindings, Firebase Auth, and local_auth integration. The React Native version utilized TanStack React Query, Zustand, and a GraphQL API engine via graphql-codegen.\n\nTo meet high vetting and privacy standards, both apps integrate local biometric authentication (FaceID/TouchID), waitlist state management, and direct founder chat services, along with Telr Payment SDK integrations for Middle-East transactions.",
      keyFeatures: [
        FeatureItem(
          title: "Hybrid Tech Deployments",
          description: "Engineered in both Flutter (GetX architecture) and React Native (Zustand & TypeScript) configurations.",
        ),
        FeatureItem(
          title: "Secure Biometric Signatures",
          description: "Touch ID/Face ID integration utilizing react-native-biometrics on React Native and local_auth on Flutter.",
        ),
        FeatureItem(
          title: "GraphQL & Ky API Client",
          description: "Type-safe operations using GraphQL queries/mutations combined with Ky for high-speed REST endpoints.",
        ),
        FeatureItem(
          title: "Private Forums & Real-time Chat",
          description: "Direct peer-to-peer messaging and discussion boards for founders to coordinate and share opportunities.",
        ),
        FeatureItem(
          title: "Middle-East Payment SDK",
          description: "Regional credit card and Telr Payment SDK integrations for membership plans and dues.",
        ),
        FeatureItem(
          title: "Interactive Membership Lifecycle",
          description: "Detailed onboarding and waitlist tracking synced with state transitions like active, paused, or cancelled.",
        ),
      ],
      techStack: [
        TechItem(name: "Flutter", icon: "flutter"),
        TechItem(name: "React Native", icon: "code"),
        TechItem(name: "TypeScript & Dart", icon: "terminal"),
        TechItem(name: "GraphQL & REST", icon: "api"),
        TechItem(name: "Biometrics", icon: "fingerprint"),
        TechItem(name: "Telr Payment SDK", icon: "payment"),
      ],
      codeSnippetPath: "src/services/biometrics.ts & lib/app/modules/biometric/controller/biometric_controller.dart",
      codeSnippet: "// React Native (TypeScript) - Cryptographic Signature\nclass BiometricService {\n  private rnBiometrics = new ReactNativeBiometrics();\n  async authenticateWithBiometrics(promptMessage?: string): Promise<BiometricResult> {\n    const { signature, success } = await this.rnBiometrics.createSignature({\n      payload: 'biometric_authentication',\n      promptMessage: promptMessage || 'Confirm identity',\n    });\n    return { signature, success };\n  }\n}\n\n// Flutter (Dart) - Local Authentication\nclass BiometricController extends GetxController {\n  final LocalAuthentication auth = LocalAuthentication();\n  Future<void> authenticate() async {\n    final bool result = await auth.authenticate(\n      localizedReason: \"Confirm it's you\",\n      biometricOnly: true,\n    );\n    if (result) flowController.nextPage(nextStep: 'nationality');\n  }\n}",
      screenshots: [
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/yp-club/yp-club-1.jpg",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/yp-club/yp-club-2.jpg",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/yp-club/yp-club-3.jpg",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/yp-club/yp-club-4.jpg",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/yp-club/yp-club-5.jpg",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/yp-club/yp-club-6.jpg",
        "https://cdn.jsdelivr.net/gh/ASHISH1317/my-portfolio@main/media/projects/yp-club/yp-club-7.jpg",
      ],
      integrations: [
        IntegrationItem(title: "Biometrics (Flutter & React Native)", icon: "fingerprint"),
        IntegrationItem(title: "GraphQL Operations (Codegen)", icon: "security"),
        IntegrationItem(title: "Telr Middle-East Payments", icon: "payment"),
        IntegrationItem(title: "TanStack React Query Cache", icon: "sync"),
        IntegrationItem(title: "Zustand, GetX & MMKV", icon: "save"),
        IntegrationItem(title: "Mixpanel & Clarity Analytics", icon: "analytics"),
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

  factory FeatureItem.fromJson(Map<String, dynamic> json) {
    return FeatureItem(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}

class TechItem {
  final String name;
  final String icon;

  const TechItem({required this.name, required this.icon});

  factory TechItem.fromJson(Map<String, dynamic> json) {
    return TechItem(
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon,
    };
  }
}

class IntegrationItem {
  final String title;
  final String icon;

  const IntegrationItem({required this.title, required this.icon});

  factory IntegrationItem.fromJson(Map<String, dynamic> json) {
    return IntegrationItem(
      title: json['title'] ?? '',
      icon: json['icon'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'icon': icon,
    };
  }
}
class ProjectData {
  final String title;
  final String description;
  final List<String> tags;
  final String projectUrl;
  final String githubUrl;
  final String playStoreUrl;
  final String appStoreUrl;
  final String imageUrl;
  final String backgroundStory;
  final List<FeatureItem> keyFeatures;
  final List<TechItem> techStack;
  final String codeSnippetPath;
  final String codeSnippet;
  final List<String> screenshots;
  final List<String> webScreenshots;
  final List<IntegrationItem> integrations;

  const ProjectData({
    required this.title,
    required this.description,
    required this.tags,
    required this.projectUrl,
    required this.githubUrl,
    required this.playStoreUrl,
    required this.appStoreUrl,
    required this.imageUrl,
    required this.backgroundStory,
    required this.keyFeatures,
    required this.techStack,
    required this.codeSnippetPath,
    required this.codeSnippet,
    required this.screenshots,
    this.webScreenshots = const [],
    required this.integrations,
  });

  factory ProjectData.fromJson(Map<String, dynamic> json) {
    return ProjectData(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      projectUrl: json['projectUrl'] ?? '',
      githubUrl: json['githubUrl'] ?? '',
      playStoreUrl: json['playStoreUrl'] ?? '',
      appStoreUrl: json['appStoreUrl'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      backgroundStory: json['backgroundStory'] ?? '',
      keyFeatures: (json['keyFeatures'] as List? ?? [])
          .map((item) => FeatureItem.fromJson(item))
          .toList(),
      techStack: (json['techStack'] as List? ?? [])
          .map((item) => TechItem.fromJson(item))
          .toList(),
      codeSnippetPath: json['codeSnippetPath'] ?? '',
      codeSnippet: json['codeSnippet'] ?? '',
      screenshots: List<String>.from(json['screenshots'] ?? []),
      webScreenshots: List<String>.from(json['webScreenshots'] ?? []),
      integrations: (json['integrations'] as List? ?? [])
          .map((item) => IntegrationItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'tags': tags,
      'projectUrl': projectUrl,
      'githubUrl': githubUrl,
      'playStoreUrl': playStoreUrl,
      'appStoreUrl': appStoreUrl,
      'imageUrl': imageUrl,
      'backgroundStory': backgroundStory,
      'keyFeatures': keyFeatures.map((item) => item.toJson()).toList(),
      'techStack': techStack.map((item) => item.toJson()).toList(),
      'codeSnippetPath': codeSnippetPath,
      'codeSnippet': codeSnippet,
      'screenshots': screenshots,
      'webScreenshots': webScreenshots,
      'integrations': integrations.map((item) => item.toJson()).toList(),
    };
  }
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
