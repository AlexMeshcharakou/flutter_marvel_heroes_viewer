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

class SearchList extends StatefulWidget {
  final String nameStartsWith;

  const SearchList({Key? key, required this.nameStartsWith}) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  final ScrollController _scrollController = ScrollController();

  @override
  SearchList get widget => super.widget;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    String nameStartsWith = widget.nameStartsWith;
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
            controller: _scrollController,
            itemCount: state.hasReachedMax ? characters.length : characters.length + 1,
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
              BlocProvider.of<SearchBloc>(context).add(SearchedCharacterEvent(nameStartsWith: nameStartsWith));
            },
            error: state.error.toString(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<SearchBloc>().add(ScrolledToEndSearchEvent(nameStartsWith: widget.nameStartsWith));
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
