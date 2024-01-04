import 'package:flutter/material.dart';

class BottomNavBarProvider extends ChangeNotifier {
  int _currentIndex = 0;
  final PageController pageController = PageController(initialPage: 0);

  int get currentIndex => _currentIndex;

  void updateIndex(int index) {
    _currentIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
