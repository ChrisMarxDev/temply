import 'package:temply/builders/builder.dart';

import '../temply.dart';

class ScreenBuilder extends CodeBuilder {
  final String name;

  ScreenBuilder(
    String file,
    this.name,
  ) : super(file);

  @override
  String template() {
    return """import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'state/${camelToSnakeCase(name)}_cubit.dart';
    
    class ${name}Screen extends StatelessWidget {
  static String routeName = '${camelToSnakeCase(name)}';

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(),
        body: Container(),
    );
  }
}""";
  }
}
