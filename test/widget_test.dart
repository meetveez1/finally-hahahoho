import 'package:flutter_test/flutter_test.dart';
import 'package:school_app/app.dart';

void main() {
  testWidgets('SchoolApp builds', (tester) async {
    await tester.pumpWidget(const SchoolApp());
    expect(find.text('Школьное\nприложение'), findsOneWidget);
  });
}
