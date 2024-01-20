import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:state_notifier_ex/provider/counter.dart';

enum Level {
  bronze,
  silver,
  gold,
}

class CustomerLevel extends StateNotifier<Level> with LocatorMixin {
  CustomerLevel() : super(Level.bronze);

  //currentCounter가변경될 때마다 update
  @override
  void update(Locator watch) {
    final currentCounter = watch<CounterState>().counter;
    if (currentCounter >= 100) {
      state = Level.gold;
    } else if (currentCounter > 50 && currentCounter < 100) {
      state = Level.silver;
    } else {
      state = Level.bronze;
    }
    super.update(watch);
  }
}
