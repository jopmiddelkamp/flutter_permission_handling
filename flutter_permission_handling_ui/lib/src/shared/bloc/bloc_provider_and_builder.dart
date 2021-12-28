import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class BlocProviderAndBuilder<B extends BlocBase<S>, S> extends StatelessWidget {
  const BlocProviderAndBuilder({
    Key? key,
    required this.create,
    this.lazy = true,
    required this.builder,
    this.buildWhen,
  }) : super(key: key);

  final Create<B> create;
  final bool lazy;
  final BlocWidgetBuilder<S> builder;
  final BlocBuilderCondition<S>? buildWhen;

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocProvider<B>(
      create: create,
      lazy: lazy,
      child: BlocBuilder<B, S>(
        builder: builder,
        buildWhen: buildWhen,
      ),
    );
  }
}
