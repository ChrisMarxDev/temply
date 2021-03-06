import 'package:temply/builders/builder.dart';

import '../util.dart';

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

import 'cubit/${camelToSnakeCase(name)}_cubit.dart';
  
// Add the following to your routes
// ${name}Screen.routeName: (context) => BlocProvider(
//     create: (context) => ${name}Cubit),
//     child: const ${name}Screen()),

class ${name}Screen extends StatelessWidget {
  static String routeName = '${camelToSnakeCase(name)}';
  
  const ${name}Screen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<${name}Cubit, ${name}State>(
                builder: (context, state) {
                  if(state is ${name}Initial){
                    return Container();
                  }
                  else if(state is ${name}Content){
                    return Container();
                  }
                  return Container();
                }
                ),
    );
  }
}""";
  }
}
