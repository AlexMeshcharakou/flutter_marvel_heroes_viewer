import 'package:marvel/domain/entities/character.dart';
import 'package:marvel/domain/entities/series.dart';
import 'package:marvel/presentation/features/details/bloc/details_bloc.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_bloc.dart';
import 'package:marvel/presentation/view_models/view_data_character.dart';
import 'package:marvel/presentation/view_models/view_data_details.dart';
import 'package:marvel/presentation/view_models/view_data_series.dart';

extension CharactersToViewData on HeroesBloc {
  static toViewData(List<dynamic> characters) {
    return characters
        .map((characterEntity) => ViewDataCharacter(
            id: characterEntity.id, name: characterEntity.name, smallThumbnailUrl: characterEntity.smallThumbnailUrl))
        .toList();
  }
}

extension DetailsToViewData on DetailsBloc {
  static toViewData(Character character) {
    return ViewDataCharacterDetails(
        id: character.id,
        name: character.name,
        description: character.description,
        bigThumbnailUrl: character.bigThumbnailUrl);
  }
}

extension SeriesToViewData on DetailsBloc {
  static toViewData(List<Series> series) {
    return series
        .map(
          (seriesEntity) => ViewDataSeries(title: seriesEntity.title, thumbnailUrl: seriesEntity.thumbnailUrl),
        )
        .toList();
  }
}
