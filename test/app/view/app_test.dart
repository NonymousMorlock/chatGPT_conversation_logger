import 'package:conversation_log/app/app.dart';
import 'package:conversation_log/core/services/injection_container.dart';
import 'package:conversation_log/src/home/presentation/views/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await init();
  });
  group('App', () {
    testWidgets('renders HomeScreen', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
