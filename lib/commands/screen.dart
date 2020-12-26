import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:temply/builders/cubit_builder.dart';
import 'package:temply/builders/cubit_test_builder.dart';
import 'package:temply/builders/screen_builder.dart';
import 'package:temply/builders/screen_test_builder.dart';
import 'package:temply/builders/state_builder.dart';

import '../util.dart';

class ScreenCommand extends Command {
  static final String forceFlag = 'force';
  static final String testFlag = 'test';
  static final String cubitFlag = 'cubit';
  static final String versionFlag = 'version';

  @override
  final name = 'screen';
  @override
  final description = 'Generates a standard screen component';

  ScreenCommand() {
    // [argParser] is automatically created by the parent class.
    argParser
      ..addFlag(forceFlag, negatable: false, abbr: 'f', help: 'force generate classes, overwriting existing classes')
      ..addFlag(testFlag, negatable: false, abbr: 't', help: 'generate for tests screen')
      ..addFlag(cubitFlag, negatable: false, abbr: 'c', help: 'generate for cubits screen');
  }

  // [run] may also return a Future.
  void run() async {
    // [argResults] is set before [run()] is called and contains the options
    // passed to this command.
    final force = argResults[forceFlag];
    final cubit = argResults[cubitFlag];
    final test = argResults[testFlag];

    if (argResults.rest.isEmpty) {
      stdout.write('Please write the name of the classes you want to generate');
      exit(0);
    }

    final name = argResults.rest.first;

    await checkforDartProject();
    await generate(name, force: force, cubit: cubit, test: test);
  }

  Future generate(String name,
      {bool force = false, bool cubit = false, bool test = false}) async {
    // make sure a name is provided
    if (name.isEmpty) {
      exitWithError('No name provided');
    }

    var snakeCaseName = camelToSnakeCase(name);

    var screenFile =
        'lib/screens/${snakeCaseName}_screen/${snakeCaseName}_screen.dart';
    var cubitFile =
        'lib/screens/state/${snakeCaseName}_screen/${snakeCaseName}_cubit.dart';
    var stateFile =
        'lib/screens/state/${snakeCaseName}_screen/${snakeCaseName}_state.dart';

    var screenTestFile =
        'test/screens/${snakeCaseName}_screen/${snakeCaseName}_screen_test.dart';
    var cubitTestFile =
        'test/screens/${snakeCaseName}_screen/${snakeCaseName}_cubit_test.dart';

    var builders = [
      ScreenBuilder(screenFile, name),
      if (cubit) ...[
        CubitBuilder(cubitFile, name),
        StateBuilder(stateFile, name)
      ],
      if (test) ...[
        ScreenTestBuilder(screenTestFile),
      ],
      if (test && cubit) ...[CubitTestBuilder(cubitTestFile)]
    ];

    var canExecute =
        force || await noFilesExisting(builders.map((e) => e.file));

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
