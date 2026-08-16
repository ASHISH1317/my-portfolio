import 'package:flutter/foundation.dart';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import '../widgets/scroll_reveal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../data/theme_config.dart';
import '../data/portfolio_data.dart';
import '../widgets/custom_card.dart';
import '../widgets/cool_dialog.dart';
import '../widgets/section_header.dart';
import '../controllers/contact_controller.dart';
import '../controllers/home_controller.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  ContactController get controller => Get.find<ContactController>();
  final GlobalKey _contactRowKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 900;
    final homeController = Get.find<HomeController>();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 50),
          isMobile
              ? Column(
                  children: [
                    ScrollReveal(
                      direction: RevealDirection.up,
                      delay: Duration.zero,
                      child: _buildContactInfo(isMobile: true),
                    ),
                    const SizedBox(height: 48),
                    ScrollReveal(
                      direction: RevealDirection.up,
                      delay: const Duration(milliseconds: 150),
                      child: _buildFormCard(isMobile: true),
                    ),
                  ],
                )
              : Row(
                  key: _contactRowKey,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: ScrollReveal(
                        direction: RevealDirection.left,
                        delay: Duration.zero,
                        child: StickyContainer(
                          parentKey: _contactRowKey,
                          scrollController: homeController.scrollController,
                          child: _buildContactInfo(isMobile: false),
                        ),
                      ),
                    ),
                    const SizedBox(width: 60),
                    Expanded(
                      flex: 6,
                      child: ScrollReveal(
                        direction: RevealDirection.right,
                        delay: const Duration(milliseconds: 100),
                        child: _buildFormCard(isMobile: false),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SectionHeader(
      title: "Let's build something great",
      subtitle: "Get In Touch",
      index: "07",
    );
  }

  Widget _buildContactInfo({required bool isMobile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's build something great",
          style: ThemeConfig.h3.copyWith(
            fontSize: 22,
            height: 1.4,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 16),
        Text(
          "Have a project in mind or want to discuss an opportunity? I'd love to hear from you. Drop me a message and I'll get back to you as soon as possible.",
          style: ThemeConfig.body,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 40),
        _buildInfoRow(
          Icons.mail_outlined,
          "EMAIL",
          controller.email,
          onTap: () => _showContactConfirm(
            "Send Email",
            "Do you want to send an email to ${controller.email}?",
            controller.emailUrl,
          ),
        ),
        const SizedBox(height: 24),
        _buildInfoRow(
          Icons.phone_android_outlined,
          "PHONE",
          controller.phone,
          onTap: () => _showContactConfirm(
            "Call Number",
            "Do you want to call ${controller.phone}?",
            "tel:${controller.phone.replaceAll(' ', '')}",
          ),
        ),
        const SizedBox(height: 24),
        _buildInfoRow(
          Icons.location_on_outlined,
          "LOCATION",
          controller.location,
          onTap: () => _showContactConfirm(
            "Open Location",
            "Do you want to view Surat, Gujarat, India on Google Maps?",
            "https://www.google.com/maps/search/?api=1&query=Surat,+Gujarat,+India",
          ),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildSocialIcon(FontAwesomeIcons.github, PortfolioData.github1),
            const SizedBox(width: 16),
            _buildSocialIcon(FontAwesomeIcons.github, PortfolioData.github2),
            const SizedBox(width: 16),
            _buildSocialIcon(FontAwesomeIcons.linkedin, PortfolioData.linkedin),
            const SizedBox(width: 16),
            _buildSocialIcon(FontAwesomeIcons.instagram, PortfolioData.instagram),
            const SizedBox(width: 16),
            _buildSocialIcon(FontAwesomeIcons.whatsapp, PortfolioData.whatsapp),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {VoidCallback? onTap}) {
    final Widget widget = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ThemeConfig.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: Icon(icon, color: ThemeConfig.primary, size: 24),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: ThemeConfig.caption.copyWith(letterSpacing: 1.5, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(value, style: ThemeConfig.bodyBold.copyWith(fontSize: 15)),
          ],
        ),
      ],
    );

    if (onTap != null) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: widget,
        ),
      );
    }
    return widget;
  }

  Widget _buildSocialIcon(dynamic icon, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          if (kIsWeb) {
            html.window.open(url, '_blank');
          } else {
            final Uri uri = Uri.parse(url);
            if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
              debugPrint("Could not launch $url");
            }
          }
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: ThemeConfig.outlineVariant.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(color: ThemeConfig.outlineVariant),
          ),
          child: FaIcon(icon, color: ThemeConfig.textSecondary, size: 20),
        ),
      ),
    );
  }

  Widget _buildFormCard({required bool isMobile}) {
    return CustomCard(
      enableHover: true,
      enableTilt: false,
      padding: isMobile
          ? const EdgeInsets.symmetric(horizontal: 20, vertical: 24)
          : const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: ThemeConfig.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  "Send Message",
                  style: ThemeConfig.h3.copyWith(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (isMobile) ...[
              _buildTextField(
                controller: controller.nameController,
                label: "YOUR NAME",
                validator: (val) => val == null || val.isEmpty ? "Please enter your name" : null,
              ),
              const SizedBox(height: 24),
              _buildTextField(
                controller: controller.emailController,
                label: "EMAIL ADDRESS",
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val == null || !val.contains("@") ? "Please enter a valid email" : null,
              ),
              const SizedBox(height: 24),
              Obx(() => _buildDropdownField(
                    label: "PREFERRED FRAMEWORK / TECHNOLOGY",
                    value: controller.selectedTechnology.value,
                    items: const ["Flutter", "Shopify", "Framer AI", "React Native", "Other"],
                    onChanged: (val) => controller.selectedTechnology.value = val,
                  )),
              const SizedBox(height: 24),
              Obx(() => _buildDropdownField(
                    label: "PROJECT BUDGET",
                    value: controller.selectedBudget.value,
                    items: const ["< \$1K", "\$1K - \$3K", "\$3K - \$5K", "\$5K+", "Not Decided"],
                    onChanged: (val) => controller.selectedBudget.value = val,
                  )),
              const SizedBox(height: 24),
              Obx(() => _buildDropdownField(
                    label: "EXPECTED TIMELINE",
                    value: controller.selectedTimeline.value,
                    items: const ["Immediate (< 1 mo)", "1 - 3 Months", "Flexible", "Just Exploring"],
                    onChanged: (val) => controller.selectedTimeline.value = val,
                  )),
              const SizedBox(height: 24),
              _buildTextField(
                controller: controller.subjectController,
                label: "SUBJECT",
                validator: (val) => val == null || val.isEmpty ? "Please enter a subject" : null,
              ),
            ] else ...[
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: controller.nameController,
                      label: "YOUR NAME",
                      validator: (val) => val == null || val.isEmpty ? "Please enter your name" : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      controller: controller.emailController,
                      label: "EMAIL ADDRESS",
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) => val == null || !val.contains("@") ? "Please enter a valid email" : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Obx(() => _buildDropdownField(
                          label: "PREFERRED TECHNOLOGY",
                          value: controller.selectedTechnology.value,
                          items: const ["Flutter", "Shopify", "Framer AI", "React Native", "Other"],
                          onChanged: (val) => controller.selectedTechnology.value = val,
                        )),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Obx(() => _buildDropdownField(
                          label: "PROJECT BUDGET",
                          value: controller.selectedBudget.value,
                          items: const ["< \$1K", "\$1K - \$3K", "\$3K - \$5K", "\$5K+", "Not Decided"],
                          onChanged: (val) => controller.selectedBudget.value = val,
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Obx(() => _buildDropdownField(
                          label: "EXPECTED TIMELINE",
                          value: controller.selectedTimeline.value,
                          items: const ["Immediate (< 1 mo)", "1 - 3 Months", "Flexible", "Just Exploring"],
                          onChanged: (val) => controller.selectedTimeline.value = val,
                        )),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      controller: controller.subjectController,
                      label: "SUBJECT",
                      validator: (val) => val == null || val.isEmpty ? "Please enter a subject" : null,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 24),
            Obx(() => _buildMeetingToggle(context)),
            const SizedBox(height: 24),
            _buildTextField(
              controller: controller.messageController,
              label: "MESSAGE",
              maxLines: 3,
              validator: (val) => val == null || val.isEmpty ? "Please write your message" : null,
            ),
            const SizedBox(height: 32),
            Obx(() {
              final bool isLoading = controller.isLoading.value;
              return isMobile
                  ? _SubmitButton(
                      onTap: isLoading ? null : () => controller.sendDirectMessage(context),
                      baseColor: ThemeConfig.primary,
                      icon: Icons.send_rounded,
                      text: "Send Message",
                      isFullWidth: true,
                      isPrimaryTextDark: true,
                      isLoading: isLoading,
                    )
                  : _SubmitButton(
                      onTap: isLoading ? null : () => controller.sendDirectMessage(context),
                      baseColor: ThemeConfig.primary,
                      icon: Icons.send_rounded,
                      text: "Send Message",
                      isFullWidth: false,
                      isPrimaryTextDark: true,
                      isLoading: isLoading,
                    );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(color: ThemeConfig.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: ThemeConfig.textSecondary.withValues(alpha: 0.7),
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
        floatingLabelStyle: TextStyle(color: ThemeConfig.primary),
        fillColor: ThemeConfig.surfaceContainerLow.withValues(alpha: 0.4),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ThemeConfig.outline.withValues(alpha: 0.12)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ThemeConfig.outline.withValues(alpha: 0.12)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ThemeConfig.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: TextStyle(color: ThemeConfig.textPrimary, fontSize: 14),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      dropdownColor: ThemeConfig.surfaceContainerLow,
      iconEnabledColor: ThemeConfig.primary,
      style: TextStyle(color: ThemeConfig.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: ThemeConfig.textSecondary.withValues(alpha: 0.7),
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
        floatingLabelStyle: TextStyle(color: ThemeConfig.primary),
        fillColor: ThemeConfig.surfaceContainerLow.withValues(alpha: 0.4),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ThemeConfig.outline.withValues(alpha: 0.12)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ThemeConfig.outline.withValues(alpha: 0.12)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ThemeConfig.primary, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildMeetingToggle(BuildContext context) {
    final bool isChecked = controller.scheduleCall.value;
    final DateTime? dateTime = controller.selectedDateTime.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: ThemeConfig.surfaceContainerLow.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isChecked ? ThemeConfig.primary : ThemeConfig.outline.withValues(alpha: 0.12),
              width: isChecked ? 1.5 : 1.0,
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor: ThemeConfig.textSecondary.withValues(alpha: 0.6),
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              clipBehavior: Clip.antiAlias,
              child: CheckboxListTile(
                dense: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: Text(
                  "Schedule a quick project discussion?",
                  style: TextStyle(
                    color: ThemeConfig.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  "Book a 30-minute virtual meeting via Google Meet",
                  style: TextStyle(
                    color: ThemeConfig.textSecondary.withValues(alpha: 0.6),
                    fontSize: 10,
                  ),
                ),
                value: isChecked,
                activeColor: ThemeConfig.primary,
                checkColor: Colors.black,
                onChanged: (bool? val) {
                  controller.scheduleCall.value = val ?? false;
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              ),
            ),
          ),
        ),
        if (isChecked) ...[
          const SizedBox(height: 12),
          _buildDateTimePickerButton(context, dateTime),
        ],
      ],
    );
  }

  Widget _buildDateTimePickerButton(BuildContext context, DateTime? dateTime) {
    final String label = dateTime == null
        ? "SELECT DATE & TIME"
        : "MEETING TIME: ${_formatDateTime(dateTime)}";

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _pickDateTime(context),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: ThemeConfig.surfaceContainerLow.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: dateTime == null ? ThemeConfig.outline.withValues(alpha: 0.12) : ThemeConfig.primary,
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.calendar_today_rounded,
                color: dateTime == null ? ThemeConfig.textSecondary : ThemeConfig.primary,
                size: 16,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: dateTime == null ? ThemeConfig.textSecondary : ThemeConfig.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_drop_down_rounded,
                color: ThemeConfig.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    final months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    final month = months[dt.month - 1];
    final hour = dt.hour > 12 ? dt.hour - 12 : (dt.hour == 0 ? 12 : dt.hour);
    final period = dt.hour >= 12 ? "PM" : "AM";
    final minute = dt.minute.toString().padLeft(2, '0');
    return "$month ${dt.day}, ${dt.year} at $hour:$minute $period";
  }

  Future<void> _pickDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: ThemeConfig.primary,
              onPrimary: Colors.black,
              surface: ThemeConfig.surfaceContainerLow,
              onSurface: ThemeConfig.textPrimary,
            ),
            dialogBackgroundColor: ThemeConfig.surface,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate == null) return;
    if (!context.mounted) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: ThemeConfig.primary,
              onPrimary: Colors.black,
              surface: ThemeConfig.surfaceContainerLow,
              onSurface: ThemeConfig.textPrimary,
            ),
            dialogBackgroundColor: ThemeConfig.surface,
          ),
          child: child!,
        );
      },
    );

    if (pickedTime == null) return;

    final DateTime finalDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    controller.selectedDateTime.value = finalDateTime;
  }

  void _showContactConfirm(String title, String message, String actionUrl) {
    showCoolDialog(
      context: context,
      title: title,
      message: message,
      icon: Icons.open_in_new_rounded,
      accentColor: ThemeConfig.primary,
      primaryButtonText: "Yes",
      onPrimaryPressed: () {
        Navigator.of(context).pop();
        controller.launchURL(actionUrl);
      },
      secondaryButtonText: "Cancel",
      onSecondaryPressed: () => Navigator.of(context).pop(),
    );
  }
}

class _SubmitButton extends StatefulWidget {
  final VoidCallback? onTap;
  final Color baseColor;
  final dynamic icon;
  final String text;
  final bool isFullWidth;
  final bool isPrimaryTextDark;
  final bool isLoading;

  const _SubmitButton({
    required this.onTap,
    required this.baseColor,
    required this.icon,
    required this.text,
    required this.isFullWidth,
    this.isPrimaryTextDark = false,
    this.isLoading = false,
  });

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = widget.onTap != null && !widget.isLoading;
    final bool showHover = _isHovered && isEnabled;

    final Color contentColor = showHover
        ? (widget.isPrimaryTextDark ? Colors.black : Colors.white)
        : widget.baseColor;

    final Color bgColor = showHover
        ? widget.baseColor
        : widget.baseColor.withValues(alpha: isEnabled ? 0.05 : 0.02);

    return MouseRegion(
      onEnter: (_) => isEnabled ? setState(() => _isHovered = true) : null,
      onExit: (_) => isEnabled ? setState(() => _isHovered = false) : null,
      cursor: isEnabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: isEnabled ? widget.onTap : null,
        child: AnimatedScale(
          scale: showHover ? 1.025 : 1.0,
          duration: const Duration(milliseconds: 150),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: showHover ? widget.baseColor : widget.baseColor.withValues(alpha: isEnabled ? 0.3 : 0.1),
                width: 1.5,
              ),
              boxShadow: showHover
                  ? [
                      BoxShadow(
                        color: widget.baseColor.withValues(alpha: 0.25),
                        blurRadius: 16,
                        spreadRadius: 1,
                        offset: const Offset(0, 6),
                      )
                    ]
                  : null,
            ),
            child: Opacity(
              opacity: isEnabled ? 1.0 : 0.6,
              child: Row(
                mainAxisSize: widget.isFullWidth ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(contentColor),
                          ),
                        )
                      : (widget.icon is IconData
                          ? Icon(widget.icon, color: contentColor, size: 20)
                          : FaIcon(widget.icon, color: contentColor, size: 20)),
                  const SizedBox(width: 10),
                  Text(
                    widget.isLoading ? "Sending..." : widget.text,
                    style: TextStyle(
                      color: contentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StickyContainer extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;
  final GlobalKey parentKey;

  const StickyContainer({
    super.key,
    required this.child,
    required this.scrollController,
    required this.parentKey,
  });

  @override
  State<StickyContainer> createState() => _StickyContainerState();
}

class _StickyContainerState extends State<StickyContainer> {
  final GlobalKey _childKey = GlobalKey();
  double _offsetTop = 0.0;
  double? _rowAbsoluteTop;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_updateOffset);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_updateOffset);
    super.dispose();
  }

  void _updateOffset() {
    if (!mounted) return;

    final RenderBox? rowRenderBox = widget.parentKey.currentContext?.findRenderObject() as RenderBox?;
    final RenderBox? childRenderBox = _childKey.currentContext?.findRenderObject() as RenderBox?;

    if (rowRenderBox != null && childRenderBox != null) {
      if (_rowAbsoluteTop == null) {
        final ScrollableState? scrollable = Scrollable.of(context);
        final RenderBox? scrollRenderBox = scrollable?.context.findRenderObject() as RenderBox?;
        if (scrollRenderBox != null) {
          _rowAbsoluteTop = rowRenderBox.localToGlobal(Offset.zero, ancestor: scrollRenderBox).dy + widget.scrollController.offset;
        }
      }

      if (_rowAbsoluteTop != null) {
        final double rowHeight = rowRenderBox.size.height;
        final double childHeight = childRenderBox.size.height;
        final double currentScroll = widget.scrollController.offset;

        // Sticky offset starting 100 pixels from top of screen
        final double targetTopOffset = 100.0;
        double newOffset = currentScroll - _rowAbsoluteTop! + targetTopOffset;

        final double maxOffset = rowHeight - childHeight;
        if (newOffset > maxOffset) {
          newOffset = maxOffset;
        }
        if (newOffset < 0) {
          newOffset = 0;
        }

        if (_offsetTop != newOffset) {
          setState(() {
            _offsetTop = newOffset;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Opacity(
          opacity: 0,
          child: Container(
            key: _childKey,
            child: widget.child,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: _offsetTop,
          child: widget.child,
        ),
      ],
    );
  }
}
