import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:temply/commands/screen.dart';
import 'package:temply/util.dart';

const screensPath = 'lib/screens/';
const testScreensPath = 'test/screens/';

const pubspec = './pubspec.yaml';

ArgResults argResults;
const String versionFlag = 'version';

void main(List<String> arguments) async {
  exitCode = 0; // presume success

  var runner = CommandRunner('temply', "boilerplate flutter code generation")
    ..addCommand(ScreenCommand());

  runner.argParser
      .addFlag(versionFlag, negatable: false, abbr: 'v', help: "Print version");

  var argResults = runner.parse(arguments);
  if (argResults[versionFlag] && argResults.command == null) {
    stdout.write(await getProjectVersion());
    exit(0);
  }

  try {
    await runner.run(arguments);
  } on Exception catch (e) {
    stderr.write(e.toString());
  }
}
