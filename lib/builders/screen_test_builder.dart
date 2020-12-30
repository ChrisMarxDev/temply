import 'package:temply/builders/builder.dart';

class ScreenTestBuilder extends CodeBuilder {

  final String name;
  final String screenImport;
  final String cubitImport;

  ScreenTestBuilder(String file, this.name, {this.screenImport, this.cubitImport}) : super(file);

  @override
  String template() {
    // TODO need to optimize imports
    // 'package:APP_NAME/screens/SNAKE_CASE_NAME_screen/SNAKE_CASE_NAME_screen.dart';
    return """import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
${screenImport != null ? "import '$screenImport';" : ""}
${cubitImport != null ? "import '$cubitImport';" : ""}

    
class Mock${name}Cubit extends MockBloc<${name}State>
    implements ${name}Cubit {}

void main() {
  ${name}Cubit mockBloc;

  group('${name}: Basics', () {
    setUp(() {
      mockBloc = Mock${name}Cubit();
    });

    testWidgets('check [${name}Screen] widgets',
        (WidgetTester tester) async {
      final screen = ${name}Screen();

      final app = MaterialApp(home: screen);

      await tester.pumpWidget(app);
      await tester.pump();

      expect(find.byType(${name}Screen), findsOneWidget);
    });
  });
}
    """;
  }
}
