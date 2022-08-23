import 'package:domain/domain_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/features/search/bloc/search_bloc.dart';
import 'package:marvel/presentation/features/search/bloc/search_event.dart';
import 'package:marvel/presentation/features/search/bloc/search_state.dart';
import 'package:marvel/presentation/widgets/search_list.dart';
import 'package:marvel/service_locator.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = '';
    return BlocProvider<SearchBloc>(
      create: (context) => SearchBloc(
        searchCharactersUseCase: getIt.get<SearchCharactersUseCase>(),
        context: context,
      ),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: TextField(
                  onChanged: (text) {
                    BlocProvider.of<SearchBloc>(context).add(SearchedCharacterEvent(nameStartsWith: text));
                    name = text;
                  },
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Search character'),
                  showCursor: true),
            ),
            body: SearchList(nameStartsWith: name),
          );
        },
      ),
    );
  }
}
