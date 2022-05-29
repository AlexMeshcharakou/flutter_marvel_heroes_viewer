import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_bloc.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_event.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_state.dart';
import 'package:marvel/presentation/navigation/app_routes.dart';
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
                endOfPage = _bottomError();
              } else {
                endOfPage = _bottomLoader();
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
                        child: _buildCharacterCard(state.charactersViewData![index]),
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

  Widget _bottomError() {
    return SizedBox(
      height: 70,
      child: ElevatedButton(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Check internet connection and Tap',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.refresh_rounded,
              size: 35.0,
            ),
          ],
        ),
        onPressed: () {
          context.read<HeroesBloc>().add(ScrolledToEndEvent());
        },
      ),
    );
  }

  Widget _bottomLoader() {
    return const Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(strokeWidth: 4.0),
      ),
    );
  }
}

Widget _buildCharacterCard(item) {
  return Card(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(6),
      ),
    ),
    elevation: 3,
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomLeft: Radius.circular(6),
            ),
            child: (item.smallThumbnailUrl != null)
                ? Image.network(
                    item.smallThumbnailUrl,
                    fit: BoxFit.fitWidth,
                    errorBuilder: (_, __, ___) {
                      return const Icon(Icons.broken_image);
                    },
                  )
                : Image.asset("assets/images/placeholder.png"),
          ),
        ),
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              item.name,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ),
  );
}
