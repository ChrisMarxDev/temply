import 'dart:io';
import 'package:yaml/yaml.dart';

const pubspecPath = './pubspec.yaml';

Future checkforDartProject() async {
  if (!await File(pubspecPath).exists()) {
    exitWithError(
        'Could not find pubspec.yaml in current directory. Please use only in valid dart projects root');
  }
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

Future<String> getProjectName() async {
  return (await getPubspec())['name'];
}

Future<String> getProjectVersion() async {
  return (await getPubspec())['version'];
}

Future<YamlMap> getPubspec() async {
  var pubspecFile = File(pubspecPath);
  final contents = await pubspecFile.readAsString();
  return loadYaml(contents);
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

bool isPath(String input) {
  var regExp = RegExp('^[/](.+)([^/]+)\$');
  return regExp.hasMatch(input);
}
