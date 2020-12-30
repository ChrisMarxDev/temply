import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:example/screens/home/home_screen/cubit/home_cubit.dart';



void main() {

  setUp(() {
  });

  group('[HomeCubit]]', () {
    test('The first state should be [HomeInitial]', () {
      expect(
        HomeCubit()
            .state,
        isA<HomeInitial>(),
      );
    });

    blocTest(
      'emits correct [HomeState] when X',
      build: () {
        return HomeCubit();
      },
      act: (HomeCubit cubit) {},
      expect: [
        isA<HomeContent>(),
      ],
    );
  });
}

    