import 'package:flutter/material.dart';
import 'package:state_app/pages/custom_bloc/bloc.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget {
  const BlocProvider({Key key, this.bloc, this.child}) : super(key: key);

  final Widget child;
  final T bloc;

  static T of<T extends Bloc>(BuildContext context) {
    final BlocProvider<T> provider =
        context.findAncestorWidgetOfExactType<BlocProvider<T>>();
    return provider.bloc;
  }

  @override
  _State<T> createState() => _State<T>();
}

class _State<T extends Bloc> extends State<BlocProvider<T>> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
