import 'package:marvel/domain/entities/character.dart';
import 'package:marvel/domain/repository/marvel_repository.dart';

class GetCharactersUseCase {
  final MarvelRepository marvelRepository;

  GetCharactersUseCase({required this.marvelRepository});

  Future<List<Character>> call([int offset = 0]) {
    return marvelRepository.getCharacters(offset);
  }
}
