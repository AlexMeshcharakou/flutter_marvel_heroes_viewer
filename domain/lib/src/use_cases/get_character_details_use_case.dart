

class GetCharacterDetailsUseCase {
  final MarvelRepository marvelRepository;

  GetCharacterDetailsUseCase({required this.marvelRepository});

  Future<Character> call(characterId) {
    return marvelRepository.getCharacterDetails(characterId);
  }
}
