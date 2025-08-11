import 'package:flutter/material.dart';
import '../ds/components/bottom_toolbar.dart';
import '../feature/home/home_screen.dart';
import '../feature/topics/topics_screen.dart';
import '../feature/practice/practice_screen.dart';
import '../domain/models.dart';

class ShellScreen extends StatefulWidget {
  final int initialIndex;
  final TopicModel? selectedTopic;
  
  const ShellScreen({
    super.key, 
    this.initialIndex = 0,
    this.selectedTopic,
  });

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  late int currentIndex;
  TopicModel? selectedTopic;

  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    selectedTopic = widget.selectedTopic;
    _initializeScreens();
  }

  void _initializeScreens() {
    _screens.clear();
    _screens.addAll([
      const HomeScreen(),
      const TopicsScreen(),
      PracticeScreen(selectedTopic: selectedTopic),
    ]);
  }

  void _onTap(int index) {
    if (index == currentIndex) return;
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: IndexedStack(
        index: currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomToolbar(currentIndex: currentIndex, onTap: _onTap),
    );
  }
}


