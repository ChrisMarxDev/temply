import '../temply.dart';

abstract class CodeBuilder {
  String file;

  CodeBuilder(this.file);

  Future build() async {
    await writeFile(file, template());
  }

  String template();
}
