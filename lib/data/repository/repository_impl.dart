import 'package:marvel/data/data_sources/remote_data_source.dart';
import 'package:marvel/domain/entities/character.dart';
import 'package:marvel/domain/entities/series.dart';
import 'package:marvel/domain/repository/marvel_repository.dart';

class RepositoryImpl implements MarvelRepository {
  final RemoteDataSource remoteDataSource;

  RepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Character>> getCharacters(int offset) async {
    return await remoteDataSource.getCharacters(offset);
  }

  @override
  Future<Character> getCharacterDetails(int characterId) async {
    return await remoteDataSource.getCharacterDetails(characterId);
  }

  @override
  Future<List<Series>> getAllSeries(int characterId) async {
    return await remoteDataSource.getAllSeries(characterId);
  }
}
