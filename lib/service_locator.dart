import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:domain/domain_module.dart';
import 'package:data/data_module.dart';

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

  getIt.registerFactory<SearchCharactersUseCase>(
      () => SearchCharactersUseCase(marvelRepository: getIt<MarvelRepository>()));
}
