import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:marvel/data/data_sources/local_data_source.dart';
import 'package:marvel/data/data_sources/marvel_api_client.dart';
import 'package:marvel/data/data_sources/remote_data_source.dart';
import 'package:marvel/data/repository/default_marvel_repository.dart';

import 'package:domain/domain_module.dart';

GetIt getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<BaseOptions>(BaseOptions(connectTimeout: 8000, receiveTimeout: 8000));

  getIt.registerSingleton<Dio>(Dio(getIt<BaseOptions>()));

  getIt.registerSingleton<MarvelApiClient>(
      MarvelApiClient(getIt<Dio>(), baseUrl: 'https://gateway.marvel.com:443/v1/public/'));

  getIt.registerSingleton<RemoteDataSource>(DioDataSource(marvelClient: getIt<MarvelApiClient>()));

  getIt.registerSingleton<MarvelRepository>(
      DefaultMarvelRepository(localDataSource: HiveDataSource(), remoteDataSource: getIt<RemoteDataSource>()));

  getIt.registerFactory<GetCharactersUseCase>(() => GetCharactersUseCase(marvelRepository: getIt<MarvelRepository>()));

  getIt.registerFactory<GetCharacterDetailsUseCase>(
      () => GetCharacterDetailsUseCase(marvelRepository: getIt<MarvelRepository>()));

  getIt.registerFactory<GetAllSeriesUseCase>(() => GetAllSeriesUseCase(marvelRepository: getIt<MarvelRepository>()));
}
