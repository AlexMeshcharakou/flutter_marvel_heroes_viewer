import 'package:domain/domain_module.dart';

class SearchCharactersUseCase {
  final MarvelRepository marvelRepository;

  SearchCharactersUseCase({required this.marvelRepository});

  Future<List<Character>> call(String nameStartsWith, [int offset = 0]) {
    return marvelRepository.searchCharacters(nameStartsWith, offset);
  }
}
