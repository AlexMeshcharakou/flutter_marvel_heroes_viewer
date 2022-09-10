import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marvel/presentation/features/search/bloc/search_bloc.dart';
import 'package:marvel/presentation/features/search/bloc/search_event.dart';
import 'package:marvel/presentation/features/search/widgets/search_bottom_error.dart';
import 'package:marvel/presentation/navigation/app_routes.dart';
import 'package:marvel/presentation/view_data/character_view_data.dart';
import 'package:marvel/presentation/widgets/bottom_loader.dart';
import 'package:marvel/presentation/widgets/character_card_widget.dart';
import 'package:marvel/presentation/widgets/error_page.dart';

class SearchList extends StatefulWidget {
  final bool loading;
  final String nameStartsWith;
  final Function onScroll;
  final bool hasReachedMax;
  final bool? afterScroll;
  final List<CharacterViewData>? characters;
  final bool? emptySearchField;
  final Exception? error;
  final bool? noResult;

  const SearchList({
    Key? key,
    required this.loading,
    required this.nameStartsWith,
    required this.onScroll,
    required this.hasReachedMax,
    this.afterScroll,
    this.characters,
    this.emptySearchField,
    this.error,
    this.noResult,
  }) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  final ScrollController _scrollController = ScrollController();
  late VoidCallback listener;

  @override
  void initState() {
    super.initState();
    listener = () {
      if (_isBottom) widget.onScroll();
      FocusScope.of(context).unfocus();
    };
    _scrollController.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    final bool loading = widget.loading;
    final String nameStartsWith = widget.nameStartsWith;
    final bool hasReachedMax = widget.hasReachedMax;
    final bool? afterScroll = widget.afterScroll;
    final characters = widget.characters;
    final bool? emptySearchField = widget.emptySearchField;
    final Exception? error = widget.error;
    final bool? noResult = widget.noResult;
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
          error: error,
        );
      }
      if (noResult == true) {
        return Center(
          child: Text(
            AppLocalizations.of(context)!.noResults,
            style: const TextStyle(fontSize: 25),
          ),
        );
      }
      return const SizedBox.shrink();
    }());
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(listener)
      ..dispose();
    super.dispose();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
