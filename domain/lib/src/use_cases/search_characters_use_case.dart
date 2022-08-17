import 'package:domain/domain_module.dart';

class SearchCharactersUseCase {
  final MarvelRepository marvelRepository;

  SearchCharactersUseCase({required this.marvelRepository});

  Future<List<Character>> call(String nameStartsWith) {
    return marvelRepository.searchCharacters(nameStartsWith);
  }
}