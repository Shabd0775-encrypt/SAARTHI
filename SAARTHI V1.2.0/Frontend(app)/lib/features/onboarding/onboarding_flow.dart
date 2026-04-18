import 'package:flutter/material.dart';

import '../../core/data/models/user_profile.dart';
import '../../core/data/stores/schedule_store.dart';
import '../../core/data/stores/user_profile_store.dart';
import '../../shared/widgets/circle_button.dart';
import '../../shared/widgets/page_dots.dart';
import '../../shared/widgets/soft_blob.dart';
import 'onboarding_complete_screen.dart';
import 'pages/intro_page.dart';
import 'pages/name_page.dart';
import 'pages/start_page.dart';
import 'pages/weekly_setup_page.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _controller = PageController();
  final TextEditingController _nameController = TextEditingController();
  final ScheduleStore _scheduleStore = ScheduleStore();
  final UserProfileStore _profileStore = UserProfileStore();
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _scheduleStore.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_pageIndex == 0 && _nameController.text.trim().isEmpty) {
      _showMessage('Please enter your name to continue.');
      return;
    }

    if (_pageIndex < 3) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _finishOnboarding() async {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      _showMessage('Please enter your name.');
      _controller.animateToPage(
        0,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
      );
      return;
    }

    if (!_scheduleStore.hasAnyWeeklyEntry()) {
      _showMessage('Please add at least one fixed weekly slot.');
      return;
    }

    final profile = UserProfile(
      name: name,
      primaryTask: '',
      isOnboardingComplete: true,
    );
    await _profileStore.save(profile);
    if (!mounted) {
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => OnboardingCompleteScreen(profile: profile),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _goBack() {
    if (_pageIndex > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              top: -120,
              left: -80,
              child: SoftBlob(
                size: 220,
                color: Color.fromARGB(255, 226, 215, 240),
              ),
            ),
            const Positioned(
              bottom: -120,
              right: -80,
              child: SoftBlob(
                size: 240,
                color: Color.fromARGB(255, 226, 215, 240),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 16),
                PageDots(current: _pageIndex, count: 4),
                const SizedBox(height: 12),
                Expanded(
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (value) {
                      setState(() {
                        _pageIndex = value;
                      });
                    },
                    children: [
                      NamePage(controller: _nameController),
                      IntroPage(nameListenable: _nameController),
                      const StartPage(),
                      WeeklySetupPage(scheduleStore: _scheduleStore),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleButton(
                        icon: Icons.arrow_back,
                        size: 56,
                        iconSize: 28,
                        onPressed: _pageIndex == 0 ? null : _goBack,
                      ),
                      CircleButton(
                        icon: _pageIndex == 3 ? Icons.check : Icons.arrow_forward,
                        size: 56,
                        iconSize: 28,
                        onPressed: _pageIndex == 3 ? _finishOnboarding : _goNext,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
