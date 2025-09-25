import 'package:flutter_challenge/config/enums.dart';
import 'package:flutter_challenge/config/size_const.dart';
import 'package:flutter/foundation.dart';

class PageSataProvider extends ChangeNotifier {
  int _currentIndex = 0;
  PageState _currentPage = PageState.letsGetStarted;

  int get currentIndex => _currentIndex;

  PageState get currentPage => _currentPage;

  // Mapping index to PageState
  PageState _mapIndexToPage(int index) {
    if (index == 0) return PageState.letsGetStarted;
    if (index >= 1 && index <= 4) return PageState.next;
    if (index == 5) return PageState.finish;
    if (index == 6) return PageState.analysing;
    if (index == 7) return PageState.seeResult;
    if (index == 8) return PageState.buyPlan;
    return PageState.letsGetStarted; // fallback
  }

  // Update index and page
  void next() {
    int index = _currentIndex + 1;
    if (index < 0 || index > 8) return; // optional boundary check
    _currentIndex = index;
    _currentPage = _mapIndexToPage(index);
    notifyListeners();
  }

  void back() {
    int index = _currentIndex - 1;
    if (index < 0 || index > 7) return; // optional boundary check
    _currentIndex = index;
    _currentPage = _mapIndexToPage(index);
    notifyListeners();
  }

  void navToFinishPage() async {
    await Future.delayed(SizeConstants.delay);
    if (currentPage == PageState.analysing) {
      next();
    }
  }
}
