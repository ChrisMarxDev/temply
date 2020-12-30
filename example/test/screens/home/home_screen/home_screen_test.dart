import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/screens/home/home_screen/home_screen.dart';
import 'package:example/screens/home/home_screen/cubit/home_cubit.dart';
import 'package:mockito/mockito.dart';

    
class MockHomeCubit extends MockBloc<HomeState>
    implements HomeCubit {}

void main() {
  HomeCubit mockBloc;

  group('Home: Basics', () {
    setUp(() {
      mockBloc = MockHomeCubit();
    });

    testWidgets('check [HomeScreen] widgets',
        (WidgetTester tester) async {
      final screen = HomeScreen();

      final app = MaterialApp(home: screen);

      await tester.pumpWidget(app);
      await tester.pump();

      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('check [HomeScreen] widgets',
            (WidgetTester tester) async {
          final screen = HomeScreen();

          final app = MaterialApp(home: screen);

          when(mockBloc.state).thenAnswer((realInvocation) => null);

          await tester.pumpWidget(app);
          await tester.pump();

          expect(find.byType(HomeScreen), findsOneWidget);
        });
  });
}
    