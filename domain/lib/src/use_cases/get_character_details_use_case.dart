import 'package:domain/domain_module.dart';

class GetCharacterDetailsUseCase {
  final MarvelRepository marvelRepository;

  GetCharacterDetailsUseCase({required this.marvelRepository});

  Future<Character> call(int characterId) {
    return marvelRepository.getCharacterDetails(characterId);
  }
}
