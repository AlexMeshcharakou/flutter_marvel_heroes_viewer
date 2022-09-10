import 'package:domain/domain_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/features/search/bloc/search_bloc.dart';
import 'package:marvel/presentation/features/search/bloc/search_event.dart';
import 'package:marvel/presentation/features/search/bloc/search_state.dart';
import 'package:marvel/presentation/features/search/widgets/search_list.dart';
import 'package:marvel/service_locator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = '';
    return BlocProvider<SearchBloc>(
      create: (context) => SearchBloc(
        searchCharactersUseCase: getIt.get<SearchCharactersUseCase>(),
      ),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: TextField(
                  onChanged: (text) {
                    if (text.isNotEmpty) {
                      BlocProvider.of<SearchBloc>(context).add(SearchedCharacterEvent(nameStartsWith: text));
                      name = text;
                    } else {
                      BlocProvider.of<SearchBloc>(context).add(GotEmptySearchField());
                    }
                  },
                  autofocus: true,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(hintText: AppLocalizations.of(context)!.searchCharacter),
                  showCursor: true),
            ),
            body: SearchList(
                onScroll: () {
                  context.read<SearchBloc>().add(ScrolledToEndSearchEvent(nameStartsWith: name));
                },
                nameStartsWith: name,
                loading: state.loading,
                characters: state.charactersViewData,
                error: state.error,
                noResult: state.noResult,
                emptySearchField: state.emptySearchField,
                hasReachedMax: state.hasReachedMax,
                afterScroll: state.afterScroll),
          );
        },
      ),
    );
  }
}
