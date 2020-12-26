import 'package:temply/builders/builder.dart';

class CubitTestBuilder extends CodeBuilder {
  final String name;
  final String cubitImport;

  CubitTestBuilder(String file, this.name, {this.cubitImport}) : super(file);

  @override
  String template() {
    // TODO fix imports
    return """import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
${cubitImport != null ? "import '$cubitImport';" : ""}



void main() {

  setUp(() {
  });

  group('[${name}Cubit]]', () {
    test('The first state should be [${name}Initial]', () {
      expect(
        ${name}Cubit()
            .state,
        isA<${name}Initial>(),
      );
    });

    blocTest(
      'emits correct [${name}State] when X',
      build: () {
        return ${name}Cubit();
      },
      act: (${name}Cubit cubit) {},
      expect: [
        isA<${name}State>(),
      ],
    );
  });
}

    """;
  }
}
