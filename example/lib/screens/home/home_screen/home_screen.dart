import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/home_cubit.dart';
    
class HomeScreen extends StatelessWidget {
  static String routeName = 'home';

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if(state is HomeInitial){
                    return Container();
                  }
                  else if(state is HomeContent){
                    return Container();
                  }
                  return Container();
                }
                ),
    );
  }
}