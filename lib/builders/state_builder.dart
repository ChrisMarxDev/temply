import '../temply.dart';
import 'builder.dart';

class StateBuilder extends CodeBuilder {
  final String name;

  StateBuilder(
    String file,
    this.name,
  ) : super(file);

  @override
  String template() {
    return """part of '${camelToSnakeCase(name)}cubit.dart';

@immutable
abstract class ${name}State {}

class ${name}Initial extends ${name}State {}

class ${name}Loading extends ${name}State {}

class ${name}Content extends ${name}State {}

class ${name}Error extends ${name}State {}
""";
  }
}