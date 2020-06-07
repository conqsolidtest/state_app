import 'package:conq_state_app/pages/custom_bloc/bloc.dart';
import 'package:flutter/material.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;

  const BlocProvider({Key key, this.bloc, this.child}) : super(key: key);

  static T of<T extends Bloc>(BuildContext context) {
    final BlocProvider<T> provider =
        context.findAncestorWidgetOfExactType<BlocProvider<T>>();
    return provider.bloc;
  }

  @override
  _State createState() => _State();
}

class _State extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
