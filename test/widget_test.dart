import 'package:flutter_test/flutter_test.dart';
import 'package:self_checkout_app/main.dart';

void main() {
  testWidgets('Self checkout app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SelfCheckoutApp());
    
    expect(find.text('Self Checkout'), findsOneWidget);
  });
}
