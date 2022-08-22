import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/features/search/bloc/search_bloc.dart';
import 'package:marvel/presentation/features/search/bloc/search_event.dart';
import 'package:marvel/presentation/features/search/bloc/search_state.dart';
import 'package:marvel/presentation/navigation/app_routes.dart';
import 'package:marvel/presentation/widgets/bottom_error.dart';
import 'package:marvel/presentation/widgets/bottom_loader.dart';
import 'package:marvel/presentation/widgets/character_card_widget.dart';
import 'package:marvel/presentation/widgets/error_page.dart';

class SearchList extends StatelessWidget {
  const SearchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final characters = state.charactersViewData;
        if (state.loading == true && characters == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (characters != null) {
          return ListView.builder(
            itemCount: characters.length,
            itemBuilder: (BuildContext context, int index) {
              Widget endOfPage;
              if (state.error != null && !state.loading) {
                endOfPage = const BottomError();
              } else {
                endOfPage = const BottomLoader();
              }
              return index == characters.length
                  ? endOfPage
                  : SizedBox(
                      height: 95,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.detailPage, arguments: characters[index].id);
                        },
                        child: CharacterCardWidget(characters[index]),
                      ),
                    );
            },
          );
        }
        if (state.error != null) {
          return ErrorPage(
            onRetry: () {
              BlocProvider.of<SearchBloc>(context).add(SearchedCharacterEvent(nameStartsWith: ''));
            },
            error: state.error.toString(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
