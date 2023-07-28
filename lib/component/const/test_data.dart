import '../../models/car.dart';

class TestData {
  final List<Car> _testList = [];

  TestData() {
    for (int i = 0; i < 100; i++) {
      _testList.add(Car(uid: i));
    }
  }
}
