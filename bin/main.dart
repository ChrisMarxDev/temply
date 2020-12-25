import 'dart:io';

import 'package:args/args.dart';
import 'package:temply/temply.dart';

const forceFlag = 'force';
const testFlag = 'test';
const cubitFlag = 'cubit';
const versionFlag = 'version';

const screensPath = 'lib/screens/';
const testScreensPath = 'test/screens/';

const pubspec = './pubspec.yaml';

ArgResults argResults;

void main(List<String> arguments) async {
  exitCode = 0; // presume success
  final parser = ArgParser()
    ..addFlag(forceFlag, negatable: false, abbr: 'f')
    ..addFlag(testFlag, negatable: false, abbr: 't')
    ..addFlag(versionFlag, negatable: false, abbr: 'v')
    ..addFlag(cubitFlag, negatable: false, abbr: 'c');

  argResults = parser.parse(arguments);

  final force = argResults[forceFlag];
  final cubit = argResults[cubitFlag];
  final test = argResults[testFlag];
  final version = argResults[versionFlag];

  if (version && argResults.rest.isEmpty)
    {
      stdout.write('version 0.0.1');
      exit(0);
    }

  if (argResults.rest.isEmpty)
  {
    stdout.write('Please write the name of the classes you want to generate');
    exit(0);
  }


  final name = argResults.rest.first;

  if (await isDartProject()) {


    await generate(name, force: force, cubit: cubit, test: test);
  } else {
    exitWithError(
        'Could not find pubspec.yaml in current directory. Please use only in valid dart projects root');
  }
}
