import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../resource/app_constant.dart';
import '../../business_logic/bloc/change_image_prompt_bloc.dart';
import '../../business_logic/bloc/get_images_bloc.dart';
import '../../business_logic/event/image_event.dart';
import '../../business_logic/state/get_images_state.dart';
import '../../component/component_loading.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            16,
          ),
          child: BlocBuilder<GetImagesBloc, GetImagesState>(
            builder: (context, state) {
              if (!state.isLoading && state.error == null && state.data == null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 192,
                      child: OverflowBox(
                        minHeight: 300,
                        maxHeight: 300,
                        child: Lottie.asset(
                          emptyAnim,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text(
                      'DALL-E image generator',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      initialValue: BlocProvider.of<ChangeImagePromptBloc>(context).state.prompt,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Describe image here',
                        suffixIcon: IconButton(
                          onPressed: () {
                            final String prompt = BlocProvider.of<ChangeImagePromptBloc>(context).state.prompt;

                            if (prompt.isNotEmpty) {
                              BlocProvider.of<GetImagesBloc>(context).add(
                                GetImagesEvent(prompt: prompt, n: 10, size: '256x256'),
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.search,
                          ),
                        ),
                      ),
                      onFieldSubmitted: (_) {
                        final String prompt = BlocProvider.of<ChangeImagePromptBloc>(context).state.prompt;

                        if (prompt.isNotEmpty) {
                          BlocProvider.of<GetImagesBloc>(context).add(
                            GetImagesEvent(prompt: prompt, n: 10, size: '256x256'),
                          );
                        }
                      },
                      onChanged: (value) => BlocProvider.of<ChangeImagePromptBloc>(context).add(ChangeImagePromptEvent(
                        prompt: value,
                      )),
                    ),
                  ],
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DALL-E image generator',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    initialValue: BlocProvider.of<ChangeImagePromptBloc>(context).state.prompt,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Describe image here',
                      suffixIcon: IconButton(
                        onPressed: () {
                          final String prompt = BlocProvider.of<ChangeImagePromptBloc>(context).state.prompt;

                          if (prompt.isNotEmpty) {
                            BlocProvider.of<GetImagesBloc>(context).add(
                              GetImagesEvent(prompt: prompt, n: 10, size: '1024x1024'),
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.search,
                        ),
                      ),
                    ),
                    onFieldSubmitted: (_) {
                      final String prompt = BlocProvider.of<ChangeImagePromptBloc>(context).state.prompt;

                      if (prompt.isNotEmpty) {
                        BlocProvider.of<GetImagesBloc>(context).add(
                          GetImagesEvent(prompt: prompt, n: 10, size: '1024x1024'),
                        );
                      }
                    },
                    onChanged: (value) => BlocProvider.of<ChangeImagePromptBloc>(context).add(ChangeImagePromptEvent(
                      prompt: value,
                    )),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<ChangeImagePromptBloc>(context).add(const ChangeImagePromptEvent(prompt: ''));
                          BlocProvider.of<GetImagesBloc>(context).add(ClearImageEvent());
                        },
                        child: Text(
                          'Clear',
                          style: Theme.of(context).textTheme.button?.copyWith(
                                color: Colors.blue,
                              ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<GetImagesBloc, GetImagesState>(
                    builder: (context, state) {
                      // LOADING
                      if (state.isLoading) {
                        return const Expanded(
                          child: ComponentLoading(),
                        );
                      }

                      // ERROR
                      if (!state.isLoading && state.error != null) {
                        return Expanded(
                          child: Center(
                            child: Text(
                              state.error!,
                            ),
                          ),
                        );
                      }

                      // SUCCESS
                      if (!state.isLoading && state.data != null) {
                        if (state.data!.images.isEmpty) {
                          return const Expanded(
                            child: Center(
                              child: Text(
                                'Images not found',
                              ),
                            ),
                          );
                        }

                        return Expanded(
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: true,
                              scrollDirection: Axis.horizontal,
                            ),
                            items: state.data!.images.map(
                              (image) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return FadeInImage(
                                      image: NetworkImage(image.url),
                                      placeholder: const AssetImage(loadingImage),
                                      fit: BoxFit.fitWidth,
                                    );
                                  },
                                );
                              },
                            ).toList(),
                          ),
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
