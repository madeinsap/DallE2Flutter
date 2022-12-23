import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import 'presentation/business_logic/bloc/change_image_prompt_bloc.dart';
import 'presentation/business_logic/bloc/get_images_bloc.dart';
import 'presentation/home/page/home_page.dart';
import 'resource/app_constant.dart';
import 'resource/app_service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: envFile);
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  AppServiceLocator.initUtil();
  AppServiceLocator.initDataSource();
  AppServiceLocator.initRepository();
  AppServiceLocator.initBloc();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.I<GetImagesBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<ChangeImagePromptBloc>(),
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
