import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spendwise/main.dart';

void main() {
  testWidgets('Firebase is initialized correctly', (WidgetTester tester) async {
    // Pump the app's main widget
    await tester.pumpWidget(const SpendWise());

    // Verify that Firebase has been initialized
    expect(Firebase.apps.isNotEmpty, true);
  });
}
