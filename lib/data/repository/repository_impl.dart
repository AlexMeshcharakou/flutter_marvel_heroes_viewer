import 'package:hive_flutter/hive_flutter.dart';
import 'package:marvel/data/data_sources/local_data_source.dart';
import 'package:marvel/data/data_sources/remote_data_source.dart';
import 'package:marvel/data/models/local_models/local_character.dart';
import 'package:marvel/domain/entities/character.dart';
import 'package:marvel/domain/entities/series.dart';
import 'package:marvel/domain/repository/marvel_repository.dart';

class RepositoryImpl implements MarvelRepository {
  final RemoteDataSourceImpl? remoteDataSource;
  final LocalDataSourceImpl? localDataSource;

  RepositoryImpl({this.localDataSource, this.remoteDataSource});

  @override
  Future<List<Character>> getCharacters(int offset) async {
    try {
      List<Character> characters = await remoteDataSource!.getCharacters(offset);
      List<LocalCharacter> list = characters
          .map((e) => LocalCharacter(
              id: e.id,
              name: e.name,
              description: e.description,
              smallThumbnailUrl: e.smallThumbnailUrl,
              bigThumbnailUrl: e.bigThumbnailUrl))
          .toList();
      if (Hive.box('characters').isEmpty) {
        for (var element in list) {
          localDataSource?.charactersToDB(element);
        }
      }
      return characters;
    } catch (DioError) {
      List<LocalCharacter> list = localDataSource!.getCharactersFromDB();
      List<Character> characters = list
          .map((e) => Character(
              id: e.id,
              name: e.name,
              description: e.description,
              smallThumbnailUrl: e.smallThumbnailUrl,
              bigThumbnailUrl: e.bigThumbnailUrl))
          .toList();
      return characters;
    }
  }

  @override
  Future<Character> getCharacterDetails(int characterId) async {
    return await remoteDataSource!.getCharacterDetails(characterId);
  }

  @override
  Future<List<Series>> getAllSeries(int characterId) async {
    return await remoteDataSource!.getAllSeries(characterId);
  }
}
