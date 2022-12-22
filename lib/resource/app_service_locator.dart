import 'package:get_it/get_it.dart';

import '../data/data_source/open_ai_data_source.dart';
import '../data/data_source/open_ai_data_source_impl.dart';
import '../data/repository/open_ai_repository_impl.dart';
import '../domain/repository/open_ai_repository.dart';
import '../presentation/business_logic/bloc/get_images_bloc.dart';
import '../util/api_client.dart';

class AppServiceLocator {
  static Future<void> initUtil() async {
    GetIt.I.registerLazySingleton<ApiClient>(() => ApiClient());
  }

  static Future<void> initDataSource() async {
    final ApiClient apiClient = GetIt.I<ApiClient>();

    GetIt.I.registerLazySingleton<OpenAIDataSource>(() => OpenAIDataSourceImpl(apiClient));
  }

  static Future<void> initRepository() async {
    final OpenAIDataSource openAIDataSource = GetIt.I<OpenAIDataSourceImpl>();

    GetIt.I.registerLazySingleton<OpenAIRepository>(() => OpenAIRepositoryImpl(openAIDataSource));
  }

  static Future<void> initBloc() async {
    final OpenAIRepository openAIRepository = GetIt.I<OpenAIRepositoryImpl>();

    GetIt.I.registerFactory(() => GetImagesBloc(openAIRepository));
  }
}
