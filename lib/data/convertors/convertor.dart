import 'package:marvel/data/models/character_model.dart';
import 'package:marvel/data/models/series_model.dart';
import 'package:marvel/data/repository/repository_impl.dart';
import 'package:marvel/domain/entities/character.dart';
import 'package:marvel/domain/entities/series.dart';

extension CharacterToDomainModel on CharacterModel {
   toDomainModel(CharacterModel character) {
    return Character(
        id: character.id,
        name: character.name,
        description: character.description,
        smallThumbnailUrl:
        character.thumbnail.path + '/landscape_medium.' + character.thumbnail.extension);
  }
}

extension DetailsToDomainModel on RepositoryImpl {
  static toDomainModel(List<CharacterModel> characters) {
    return characters
        .map((characterResponse) => Character(
            id: characterResponse.id,
            name: characterResponse.name,
            description: characterResponse.description,
            bigThumbnailUrl:
                characterResponse.thumbnail.path + '/landscape_xlarge.' + characterResponse.thumbnail.extension))
        .single;
  }
}

extension SeriesToDomainModel on RepositoryImpl {
  static toDomainModel(List<SeriesModel> series) {
    return series
        .map(
          (seriesResponse) => Series(
              title: seriesResponse.title,
              thumbnailUrl: seriesResponse.thumbnail.path + '/portrait_medium.' + seriesResponse.thumbnail.extension),
        )
        .toList();
  }
}
