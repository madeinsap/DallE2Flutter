import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/data_source/open_ai_data_source.dart';
import 'data/data_source/open_ai_data_source_impl.dart';
import 'data/repository/open_ai_repository_impl.dart';
import 'domain/repository/open_ai_repository.dart';
import 'presentation/business_logic/bloc/get_images_bloc.dart';
import 'presentation/home/page/home_page.dart';
import 'util/api_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ApiClient apiClient = ApiClient();
  OpenAIDataSource dataSource = OpenAIDataSourceImpl(apiClient);
  OpenAIRepository repository = OpenAIRepositoryImpl(dataSource);
  GetImagesBloc getImagesBloc = GetImagesBloc(repository);

  runApp(MyApp(getImagesBloc: getImagesBloc));
}

class MyApp extends StatelessWidget {
  final GetImagesBloc getImagesBloc;

  const MyApp({super.key, required this.getImagesBloc});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getImagesBloc,
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          backgroundColor: Colors.white,
        ),
        home: const HomePage(),
      ),
    );
  }
}
