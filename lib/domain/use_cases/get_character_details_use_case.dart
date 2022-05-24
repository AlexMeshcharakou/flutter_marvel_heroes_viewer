import 'package:marvel/domain/entities/character.dart';
import 'package:marvel/domain/repository/marvel_repository.dart';

class GetCharacterDetailsUseCase {
  final MarvelRepository marvelRepository;

  GetCharacterDetailsUseCase({required this.marvelRepository});

  Future<Character> call(characterId) {
    return marvelRepository.getCharacterDetails(characterId);
  }
}
