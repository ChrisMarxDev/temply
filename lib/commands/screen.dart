import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:interact/interact.dart';
import 'package:temply/builders/cubit_builder.dart';
import 'package:temply/builders/cubit_test_builder.dart';
import 'package:temply/builders/screen_builder.dart';
import 'package:temply/builders/screen_test_builder.dart';
import 'package:temply/builders/state_builder.dart';

import '../util.dart';

class ScreenCommand extends Command {
  static final String forceFlag = 'force';

  @override
  final name = 'screen';
  @override
  final description = 'Generates a standard screen component';

  ScreenCommand() {
    // [argParser] is automatically created by the parent class.
    argParser
      ..addFlag(forceFlag,
          negatable: false,
          abbr: 'f',
          help: 'force generate classes, overwriting existing classes');
  }

  // [run] may also return a Future.
  void run() async {
    // [argResults] is set before [run()] is called and contains the options
    // passed to this command.

    final force = argResults[forceFlag];

    if (argResults.rest.isEmpty) {
      stdout.write('Please write the name of the classes you want to generate');
      exit(0);
    }

    final name = argResults.rest.first;

    await checkforDartProject();

    final answers = await MultiSelect(
      prompt:
          'What do you want to generate? Select multiple by navigating with the arrow keys and de-/ selecting with spacebar. Continue with enter',
      options: ['Cubit', 'Test'],
      defaults: [true, true], // optional, will be all true by default
    ).interact();

    final path = Input(
      prompt: 'path for the generated files after lib',
      defaultValue: '/screens', // optional, will provide the user as a hint
      initialText: '', // optional, will be autofilled in the input
      validator: (String path) {
        // optional
        if (isPath(path)) {
          return true;
        } else {
          exitWithError("please enter a correct path");
          return false;
        }
      },
    ).interact();

    await generate(name,
        force: force,
        cubit: answers.contains(0),
        test: answers.contains(1),
        path: path);
  }

  Future generate(String name,
      {bool force = false,
      bool cubit = false,
      bool test = false,
      String path = '/screens'}) async {
    // make sure a name is provided
    if (name.isEmpty) {
      exitWithError('No name provided');
    }

    var projectName = await getProjectName();

    var snakeCaseName = camelToSnakeCase(name);

    var screensPath = 'lib${path}/${snakeCaseName}_screen/';
    var rootTestPath = 'test${path}/${snakeCaseName}_screen/';

    var screenFile = '$screensPath${snakeCaseName}_screen.dart';
    var cubitFile = '${screensPath}cubit/${snakeCaseName}_cubit.dart';
    var stateFile = '${screensPath}cubit/${snakeCaseName}_state.dart';

    var screenTestFile = '$rootTestPath${snakeCaseName}_screen_test.dart';
    var cubitTestFile = '${rootTestPath}cubit/${snakeCaseName}_cubit_test.dart';

    // 'package:APP_NAME/screens/SNAKE_CASE_NAME_screen/SNAKE_CASE_NAME_screen.dart';

    var screenImport =
        "package:$projectName${screenFile.replaceFirst(RegExp('lib\/'), '')}";
    var cubitImport =
        "package:$projectName${cubitFile.replaceFirst(RegExp('lib\/'), '')}";

    // import 'package:temply/lib//screens/cubit/test_screen/test_cubit.dart';

    var builders = [
      ScreenBuilder(screenFile, name),
      if (cubit) ...[
        CubitBuilder(cubitFile, name),
        StateBuilder(stateFile, name)
      ],
      if (test) ...[
        ScreenTestBuilder(screenTestFile, name,
            cubitImport: cubitImport, screenImport: screenImport),
      ],
      if (test && cubit) ...[
        CubitTestBuilder(cubitTestFile, name, cubitImport: cubitImport)
      ]
    ];

    var canExecute =
        force || await noFilesExisting(builders.map((e) => e.file).toList());

    // make sure that no files will be overwritten or force is used
    if (canExecute) {
      builders.forEach((builder) {
        builder.build();
      });
    } else {
      exitWithError(
          'Some files are already existing and would be overwritten. Please delete them or use the flag -f for force if you want to force an overwrite');
    }
  }
}
