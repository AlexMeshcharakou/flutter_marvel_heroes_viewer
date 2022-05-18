import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_bloc.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_state.dart';
import 'package:marvel/presentation/navigation/app_routes.dart';

class ListCharacters extends StatelessWidget {
  const ListCharacters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HeroesBloc, HeroesState>(
      builder: (context, state) {
        if (state.loading == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.loading == false && state.charactersViewData != null) {
          return ListView.builder(
            itemCount: state.charactersViewData?.length,
            itemBuilder: (BuildContext context, int index) {
              final item = state.charactersViewData![index];
              return SizedBox(
                height: 100,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.detailPage, arguments: item.id);
                  },
                  child: _buildCharacterCard(item),
                ),
              );
            },
          );
        }
        if (state.loading == false && state.error != null) {
          return const Center(
            child: Text('ERROR'),
          );
        }
        return const SizedBox.shrink();
      },
    );
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
              child: Image.network(item.smallThumbnailUrl, fit: BoxFit.fitWidth),
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
}
