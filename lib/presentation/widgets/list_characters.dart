import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_bloc.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_event.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_state.dart';
import 'package:marvel/presentation/navigation/app_routes.dart';
import 'package:marvel/presentation/widgets/bottom_error.dart';
import 'package:marvel/presentation/widgets/bottom_loader.dart';
import 'package:marvel/presentation/widgets/build_character_card.dart';
import 'package:marvel/presentation/widgets/error_page.dart';

class ListCharacters extends StatefulWidget {
  const ListCharacters({Key? key}) : super(key: key);

  @override
  State<ListCharacters> createState() => _ListCharactersState();
}

class _ListCharactersState extends State<ListCharacters> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HeroesBloc, HeroesState>(
      builder: (context, state) {
        if (state.loading == true && state.charactersViewData == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.charactersViewData != null) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.hasReachedMax ? state.charactersViewData!.length : state.charactersViewData!.length + 1,
            itemBuilder: (BuildContext context, int index) {
              Widget endOfPage;
              if (state.error != null && !state.loading) {
                endOfPage = const BottomError();
              } else {
                endOfPage = const BottomLoader();
              }
              return index == state.charactersViewData!.length
                  ? endOfPage
                  : SizedBox(
                      height: 95,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.detailPage,
                              arguments: state.charactersViewData![index].id);
                        },
                        child: BuildCharacterCard(state.charactersViewData![index]),
                      ),
                    );
            },
          );
        }
        if (state.error != null) {
          return ErrorPage(
            onRetry: () {
              context.read<HeroesBloc>().add(ReadyForDataEvent());
            },
            error: state.error!
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
    if (_isBottom) context.read<HeroesBloc>().add(ScrolledToEndEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
