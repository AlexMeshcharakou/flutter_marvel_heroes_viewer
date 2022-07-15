import '../../domain_module.dart';

class GetCharactersUseCase {
  final MarvelRepository marvelRepository;

  GetCharactersUseCase({required this.marvelRepository});

  Future<List<Character>> call([int offset = 0]) {
    return marvelRepository.getCharacters(offset);
  }
}
