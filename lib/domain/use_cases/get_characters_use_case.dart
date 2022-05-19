import 'package:marvel/domain/repository/marvel_repository.dart';

class GetCharactersUseCase {
  final MarvelRepository marvelRepository;

  GetCharactersUseCase({required this.marvelRepository});

  Future<List<dynamic>> call() {
    return marvelRepository.getCharacters();
  }
}
