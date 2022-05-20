import 'package:marvel/data/models/character_model.dart';
import 'package:marvel/data/models/series_model.dart';
import 'package:marvel/domain/entities/character.dart';
import 'package:marvel/domain/entities/series.dart';

extension CharacterToDomainModel on CharacterModel {
  Character characterToDomainModel(CharacterModel character) {
    return Character(
        id: character.id,
        name: character.name,
        description: character.description,
        smallThumbnailUrl: character.thumbnail.path + '/landscape_medium.' + character.thumbnail.extension);
  }
}

extension DetailsToDomainModel on CharacterModel {
  Character detailsToDomainModel(CharacterModel character) {
    return Character(
        id: character.id,
        name: character.name,
        description: character.description,
        bigThumbnailUrl: character.thumbnail.path + '/landscape_xlarge.' + character.thumbnail.extension);
  }
}

extension SeriesToDomainModel on SeriesModel {
  Series seriesToDomainModel(SeriesModel series) {
    return Series(
        title: series.title, thumbnailUrl: series.thumbnail.path + '/portrait_medium.' + series.thumbnail.extension);
  }
}
