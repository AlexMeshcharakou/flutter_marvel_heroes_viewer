import 'package:domain/domain_module.dart';
import 'package:marvel/presentation/view_data/character_view_data.dart';
import 'package:marvel/presentation/view_data/details_view_data.dart';
import 'package:marvel/presentation/view_data/series_view_data.dart';

extension CharactersToViewData on Character {
  CharacterViewData charactersToViewData(Character character) {
    return CharacterViewData(id: character.id, name: character.name, smallThumbnailUrl: character.smallThumbnailUrl);
  }
}

extension DetailsToViewData on Character {
  DetailsViewData detailsToViewData(Character character) {
    return DetailsViewData(
        id: character.id,
        name: character.name,
        description: character.description,
        bigThumbnailUrl: character.bigThumbnailUrl);
  }
}

extension SeriesToViewData on Series {
  SeriesViewData seriesToViewData(Series series) {
    return SeriesViewData(title: series.title, thumbnailUrl: series.thumbnailUrl);
  }
}
