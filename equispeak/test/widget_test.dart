import 'package:flutter_test/flutter_test.dart';
import 'package:equispeak_app/main.dart'; // Update this import to match your project structure

void main() {
  testWidgets('App UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(EquiSpeakApp());

    // Verify that the welcome screen elements are displayed.
    expect(find.text('EquiSpeak'), findsOneWidget);
    expect(find.text('Speech to Text'), findsOneWidget);
    expect(find.text('Text to Speech'), findsOneWidget);

    // Tap on the Text to Speech button and verify the result.
    await tester.tap(find.text('Text to Speech'));
    await tester.pump();
    expect(find.text('Recognized Text:'),
        findsOneWidget); // Verify the recognized text widget

    // Tap on the Speech to Text button and verify the result.
    await tester.tap(find.text('Speech to Text'));
    await tester.pump();
    expect(find.text('Recognized Text:'),
        findsOneWidget); // Verify the recognized text widget
  });
}
