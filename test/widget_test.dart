// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  final CameraPosition _initialPosition = const CameraPosition(target: LatLng(41.017901, 28.847953)); // 초기 위치
  GoogleMap(initialCameraPosition: _initialPosition);
}
