import 'dart:async';

class FocusPageViewModel {
  Timer? _timer;
  StreamController<DateTime> _timeController = StreamController<DateTime>.broadcast();
  StreamController<int> _moneyController = StreamController<int>.broadcast();
  int _money = 0;

  Timer? _countdownTimer;
  StreamController<int> _countdownController = StreamController<int>.broadcast();
  int _countdownTime; // Countdown time in seconds

  Function? onCountdownComplete; // Callback for when countdown completes

  Stream<int> get countdownStream => _countdownController.stream;
  Stream<DateTime> get timeStream => _timeController.stream;
  Stream<int> get moneyStream => _moneyController.stream;

  FocusPageViewModel({int initialCountdownTime = 300})
      : _countdownTime = initialCountdownTime { // Default to 5 minutes if not provided
    _moneyController.add(_money); // Initialize the money stream with the starting value
  }

  void startTimer() {
    _timeController.add(DateTime.now());
    _moneyController.add(_money);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _timeController.add(DateTime.now());
      _moneyController.add(_money);
      if (timer.tick % 10 == 0) {
        _money += 5;
        _moneyController.add(_money);
      }
    });
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdownTime > 0) {
        _countdownTime--;
        _countdownController.add(_countdownTime);
      } else {
        _countdownTimer?.cancel();
        onCountdownComplete?.call(); // Call the callback function
      }
    });
  }

  void cancelTimer() {
    _timer?.cancel();
    _countdownTimer?.cancel();
    // ... existing cancellation code ...
  }
}
