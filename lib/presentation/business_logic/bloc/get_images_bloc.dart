import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/dto/open_ai_data_dto.dart';
import '../../../domain/repository/open_ai_repository.dart';
import '../event/image_event.dart';
import '../state/get_images_state.dart';

class GetImagesBloc extends Bloc<ImageEvent, GetImagesState> {
  final OpenAIRepository repository;

  GetImagesBloc(this.repository) : super(const GetImagesState(isLoading: false)) {
    on<GetImagesEvent>((event, emit) async {
      if (!isClosed) emit(const GetImagesState(isLoading: true));

      try {
        final OpenAIDataDTO response = await repository.getImages(prompt: event.prompt, n: event.n, size: event.size);

        if (!isClosed) emit(GetImagesState(isLoading: false, data: response.toOpenAIData()));
      } catch (error) {
        if (!isClosed) emit(GetImagesState(isLoading: false, error: error.toString()));
      }
    });
  }
}
