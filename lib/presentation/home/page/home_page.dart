import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/bloc/get_images_bloc.dart';
import '../../business_logic/event/image_event.dart';
import '../../business_logic/state/get_images_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(
          16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'IPAL the AI BOY',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .5,
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Cari apa?',
                ),
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    BlocProvider.of<GetImagesBloc>(context).add(
                      GetImagesEvent(value, 10, '256x256'),
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            BlocBuilder<GetImagesBloc, GetImagesState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (!state.isLoading && state.error != null) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        state.error!,
                      ),
                    ),
                  );
                }

                if (!state.isLoading && state.data != null) {
                  if (state.data!.images.isEmpty) {
                    return const Expanded(
                      child: Center(
                        child: Text(
                          'Image not found',
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        children: state.data!.images
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 250,
                                  height: 250,
                                  child: Image.network(
                                    e.url,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
