import 'package:agrismart/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AgriSmart app starts successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const AgriSmartApp());

    expect(find.text('AgriSmart'), findsOneWidget);
    expect(find.text('Smart Farming. Better Harvest.'), findsOneWidget);
  });
}
