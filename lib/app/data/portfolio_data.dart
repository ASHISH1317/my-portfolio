class PortfolioData {
  static const String name = "Ashish";
  static const String fullName = "Ashish Vasava";
  static const String title = "Flutter Developer";
  static const String heroTagline = "Hi, I'm Ashish";
  static const String heroSubTagline = "Flutter Developer with 3+ years of experience in building cross-platform apps. Skilled in clean architecture, API integration, and performance optimization, with a passion for intuitive user experiences.";
  
  static const String aboutText1 = "Flutter Developer with 3+ years of experience in building cross-platform apps. Skilled in clean architecture, API integration, and performance optimization, with a passion for intuitive user experiences.";
  static const String aboutText2 = "Currently working as a Tech Lead at Dharma Tech in Surat, where I architect and develop production-grade Flutter applications. My journey began at IT Futurz where I honed my skills in Dart, state management, and real-time app development.";
  static const String aboutText3 = "I'm passionate about building apps that users love — from food discovery platforms to construction management tools to social challenge apps. Every project is an opportunity to push the boundaries of what's possible with Flutter.";

  static const List<Map<String, String>> stats = [
    {"value": "4+", "label": "Years Experience"},
    {"value": "7+", "label": "Projects Delivered"},
    {"value": "15+", "label": "Technologies"},
    {"value": "5+", "label": "App Store Launches"},
  ];

  static const List<SkillCategory> skills = [
    SkillCategory(
      name: "Languages",
      skills: [
        SkillItem(name: "Dart", level: 0.95),
        SkillItem(name: "Java", level: 0.75),
        SkillItem(name: "GoLang", level: 0.70),
      ],
    ),
    SkillCategory(
      name: "Frameworks",
      skills: [
        SkillItem(name: "Flutter", level: 0.95),
        SkillItem(name: "Android SDK", level: 0.85),
      ],
    ),
    SkillCategory(
      name: "State Management",
      skills: [
        SkillItem(name: "GetX", level: 0.90),
        SkillItem(name: "Riverpod", level: 0.85),
        SkillItem(name: "Provider", level: 0.85),
      ],
    ),
    SkillCategory(
      name: "APIs & Networking",
      skills: [
        SkillItem(name: "REST APIs", level: 0.90),
        SkillItem(name: "Socket.IO", level: 0.85),
        SkillItem(name: "Retrofit", level: 0.80),
      ],
    ),
    SkillCategory(
      name: "Firebase",
      skills: [
        SkillItem(name: "Authentication", level: 0.90),
        SkillItem(name: "Firestore", level: 0.90),
        SkillItem(name: "Cloud Messaging", level: 0.85),
        SkillItem(name: "Analytics", level: 0.80),
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
    ),
    ProjectData(
      title: "NexRev Freedom",
      description: "A facility and energy management app providing real-time control of building systems, including HVAC units, energy consumption, and alarms.",
      tags: ["Flutter", "Firebase", "REST APIs"],
      projectUrl: "https://nexrev.com",
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuAQrH0Hf3dwEVpsSvt6TWIJT8Yxq8qe3tKjdUIqeXwa8wTtUEDVBqoQaCpfLmx8cNEipzGpZcKQi_47zcRywv3gIntfRqwHCYrInK5hTKT69ScHqA95WAZbNEmwEtdnrVFBwd6FsoIZcwE_eYF31TmgqSOhhB-xw-J5Ig9gR1CYYYjPw2yPcHyWZjwmF7Fmd2JqYnSrL0LRHgszsCBl6HrIAwP-XgxG1kadXZTaheeUdZvcNrDXMavgh7C7HVVvQ2LO2MpCbVxarNL3",
    ),
    ProjectData(
      title: "StagePay",
      description: "A construction management and payment platform streamlining collaboration between clients and contractors with secure wallet funding.",
      tags: ["Flutter", "Firebase", "Stripe"],
      projectUrl: "https://stagepay.com",
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuDR5-8gwe1GGxHAikXXFAAOaiyB32YmMGbMa2mOP1mKRRkzwMFDyZVbkQtt7hPn4U_z9JGXJ2u26ohQ13qtM_p_JM2nhJWi4p1P52dPoM0-lmhZwpn9dxI3YD02emmZnQJVkM990XiKVVFJTZH65ABwM2uX2B4Dpp6pl8iMlToLOOLFMgNutdN47V64XlT0W-8Dsb_19eHikqQ_MIEuZ6jjxCYQIuncDdY4YHxmDqGH2NEmp_UQJB8KEPKhz5CquRMkTT32g6SU6eWX",
    ),
  ];

  static const List<ExperienceData> experiences = [
    ExperienceData(
      role: "Flutter Developer (Tech Lead)",
      company: "Dharma Tech",
      period: "Jul, 2022 — Present",
      location: "Surat, Gujarat, India",
      bullets: [
        "Leading Flutter development team, architecting scalable mobile applications with clean code principles.",
        "Implementing complex features including real-time communication via Socket.IO, secure payment integrations, and cloud-based authentication.",
        "Driving best practices in state management using GetX and Riverpod for maintainable codebases.",
        "Mentoring junior developers and conducting code reviews to ensure code quality and consistency."
      ],
    ),
    ExperienceData(
      role: "Flutter Developer (Intern)",
      company: "IT Futurz",
      period: "Apr, 2021 — Jun, 2022",
      location: "Surat, Gujarat, India",
      bullets: [
        "Proficient in GetX state management for scalable and maintainable Flutter applications.",
        "Experienced in programming languages including Dart, Java, and GoLang.",
        "Strong debugging and problem-solving skills with a logical approach to development."
      ],
    ),
  ];

  static const List<EducationData> education = [
    EducationData(
      degree: "BE (Information Technology)",
      institution: "LD College of Engineering, Ahmedabad",
      period: "2017 — 2021",
      grade: "CGPA: 7.58",
    ),
  ];

  static const String email = "ashishvasava0346@gmail.com";
  static const String phone = "+91 99136 29852";
  static const String location = "Surat, Gujarat, India";
  
  static const String github = "https://github.com";
  static const String linkedin = "https://linkedin.com";
  static const String twitter = "https://twitter.com";
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

class ProjectData {
  final String title;
  final String description;
  final List<String> tags;
  final String projectUrl;
  final String imageUrl;

  const ProjectData({
    required this.title,
    required this.description,
    required this.tags,
    required this.projectUrl,
    required this.imageUrl,
  });
}

class ExperienceData {
  final String role;
  final String company;
  final String period;
  final String location;
  final List<String> bullets;

  const ExperienceData({
    required this.role,
    required this.company,
    required this.period,
    required this.location,
    required this.bullets,
  });
}

class EducationData {
  final String degree;
  final String institution;
  final String period;
  final String grade;

  const EducationData({
    required this.degree,
    required this.institution,
    required this.period,
    required this.grade,
  });
}
