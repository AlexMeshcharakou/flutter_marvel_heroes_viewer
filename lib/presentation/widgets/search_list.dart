import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/features/search/bloc/search_bloc.dart';
import 'package:marvel/presentation/features/search/bloc/search_event.dart';
import 'package:marvel/presentation/navigation/app_routes.dart';
import 'package:marvel/presentation/widgets/bottom_loader.dart';
import 'package:marvel/presentation/widgets/character_card_widget.dart';
import 'package:marvel/presentation/widgets/error_page.dart';
import 'package:marvel/presentation/widgets/search_bottom_error.dart';

class SearchList extends StatefulWidget {
  final String nameStartsWith;

  const SearchList({Key? key, required this.nameStartsWith}) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    final loading = BlocProvider.of<SearchBloc>(context).state.loading;
    final characters = BlocProvider.of<SearchBloc>(context).state.charactersViewData;
    final error = BlocProvider.of<SearchBloc>(context).state.error;
    final noResult = BlocProvider.of<SearchBloc>(context).state.noResult;
    final emptySearchField = BlocProvider.of<SearchBloc>(context).state.emptySearchField;
    final hasReachedMax = BlocProvider.of<SearchBloc>(context).state.hasReachedMax;
    final afterScroll = BlocProvider.of<SearchBloc>(context).state.afterScroll;

    String nameStartsWith = widget.nameStartsWith;
    return Container(child: () {
      if (emptySearchField == true) {
        return Container();
      }
      if (loading == true && afterScroll == false) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (characters != null && noResult == false) {
        return ListView.builder(
          controller: _scrollController,
          itemCount: hasReachedMax ? characters.length : characters.length + 1,
          itemBuilder: (BuildContext context, int index) {
            Widget endOfPage;
            if (error != null) {
              endOfPage = SearchBottomError(nameStartsWith: nameStartsWith);
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
      if (error != null) {
        return ErrorPage(
          onRetry: () {
            BlocProvider.of<SearchBloc>(context).add(SearchedCharacterEvent(nameStartsWith: nameStartsWith));
          },
          error: error.toString(),
        );
      }
      if (noResult == true) {
        return const Center(
          child: Text(
            'No Results',
            style: TextStyle(fontSize: 25),
          ),
        );
      }
      return const SizedBox.shrink();
    }());
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
    FocusScope.of(context).unfocus();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
