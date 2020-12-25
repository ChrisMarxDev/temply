import '../temply.dart';
import 'builder.dart';

class CubitBuilder extends CodeBuilder {
  final String name;

  CubitBuilder(
    String file,
    this.name,
  ) : super(file);

  @override
  String template() {
    return """import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part '${camelToSnakeCase(name)}_state.dart';

class ${name}Cubit extends Cubit<${name}State> {
  ${name}Cubit() : super(${name}Initial());
}""";
  }
}
