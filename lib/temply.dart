import 'dart:io';

import 'package:temply/builders/cubit_builder.dart';
import 'package:temply/builders/screen_builder.dart';
import 'package:temply/builders/state_builder.dart';

import 'builders/cubit_test_builder.dart';
import 'builders/screen_test_builder.dart';

const pubspec = './pubspec.yaml';

Future<bool> isDartProject() async {
  return await File(pubspec).exists();
}

Future<bool> noFilesExisting(List<String> paths) async {
  for (var path in paths) {
    if (await File(path).exists()) {
      stderr.writeln('$path already exists');

      return false;
    }
  }

  return true;
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

  var canExecute = force || await noFilesExisting(builders.map((e) => e.file));

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

String camelToSnakeCase(String camel) {
  var exp = RegExp(r'(?<=[a-z])[A-Z]');
  var snake = camel
      .replaceAllMapped(exp, (Match m) => ('_' + m.group(0)))
      .toLowerCase();
  return snake;
}

Future writeFile(String path, String content) async {
  try {
    final file = await File(path).create(recursive: true);
    final writableSink = file.openWrite(mode: FileMode.write);

    writableSink.write(content);

    await writableSink.close();
    stdout.writeln('created file: $path');
  } catch (e) {
    exitWithError(e.toString());
  }
}

void exitWithError(String error) {
  stderr.writeln('error: $error');
  exitCode = 2;
  exit(exitCode);
}
