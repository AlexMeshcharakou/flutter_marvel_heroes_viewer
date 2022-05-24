import 'package:marvel/domain/entities/character.dart';
import 'package:marvel/domain/entities/series.dart';
import 'package:marvel/presentation/view_models/view_data_character.dart';
import 'package:marvel/presentation/view_models/view_data_details.dart';
import 'package:marvel/presentation/view_models/view_data_series.dart';

extension CharactersToViewData on Character {
  ViewDataCharacter charactersToViewData(Character character) {
    return ViewDataCharacter(id: character.id, name: character.name, smallThumbnailUrl: character.smallThumbnailUrl);
  }
}

extension DetailsToViewData on Character {
  ViewDataCharacterDetails detailsToViewData(Character character) {
    return ViewDataCharacterDetails(
        id: character.id,
        name: character.name,
        description: character.description,
        bigThumbnailUrl: character.bigThumbnailUrl);
  }
}

extension SeriesToViewData on Series {
  ViewDataSeries seriesToViewData(Series series) {
    return ViewDataSeries(title: series.title, thumbnailUrl: series.thumbnailUrl);
  }
}
