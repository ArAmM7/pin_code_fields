import 'package:flutter_test/flutter_test.dart';

import 'package:pin_code_fields_example/main.dart';

void main() {
  testWidgets('App renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify that the app title is shown
    expect(find.text('Pin Field Examples'), findsOneWidget);

    // Verify that the demo sections are shown
    expect(find.text('Material Pin Field'), findsOneWidget);
    expect(find.text('Core Pin Input'), findsOneWidget);
    expect(find.text('Shape Variants'), findsOneWidget);
    expect(find.text('Error Handling'), findsOneWidget);
  });
}
