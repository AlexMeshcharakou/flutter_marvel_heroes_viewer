import 'package:marvel/data/models/local_models/local_character.dart';
import 'package:marvel/data/models/remote_models/character_model.dart';
import 'package:marvel/data/models/remote_models/series_model.dart';

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

extension LocalCharacterToDomainModel on LocalCharacter {
  Character localCharacterToDomainModel(LocalCharacter localCharacter) {
    return Character(
        id: localCharacter.id,
        name: localCharacter.name,
        description: localCharacter.description,
        smallThumbnailUrl: localCharacter.smallThumbnailUrl,
        bigThumbnailUrl: localCharacter.bigThumbnailUrl);
  }
}

extension DomainModelToLocalCharacter on Character {
  LocalCharacter domainModelToLocalCharacter(Character character) {
    return LocalCharacter(
        id: character.id,
        name: character.name,
        description: character.description,
        smallThumbnailUrl: character.smallThumbnailUrl,
        bigThumbnailUrl: character.bigThumbnailUrl);
  }
}
