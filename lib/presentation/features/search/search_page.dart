import 'package:domain/domain_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/features/search/bloc/search_bloc.dart';
import 'package:marvel/presentation/features/search/bloc/search_event.dart';
import 'package:marvel/presentation/widgets/search_list.dart';
import 'package:marvel/service_locator.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
            onChanged: (text) {},
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Search character'),
            showCursor: true),
      ),
      body: BlocProvider<SearchBloc>(
        create: (context) =>
            SearchBloc(searchCharactersUseCase: getIt.get<SearchCharactersUseCase>())..add(SearchedCharacterEvent('n')),
        child: const SearchList(),
      ),
    );
  }
}
