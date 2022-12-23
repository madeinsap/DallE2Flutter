import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/model/open_ai_data.dart';
import '../event/image_event.dart';
import '../state/change_image_prompt_state.dart';

class ChangeImagePromptBloc extends Bloc<ImageEvent, ChangeImagePromptState> {
  ChangeImagePromptBloc() : super(const ChangeImagePromptState(prompt: '')) {
    on<ChangeImagePromptEvent>((event, emit) async {
      if (!isClosed) emit(state.copyWith(event.prompt));
    });
  }
}
