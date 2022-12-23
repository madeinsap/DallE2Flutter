import 'package:equatable/equatable.dart';

import '../../../domain/model/open_ai_data.dart';

class ChangeImagePromptState extends Equatable {
  final String prompt;

  const ChangeImagePromptState({
    required this.prompt,
  });

  ChangeImagePromptState copyWith(String prompt) {
    return ChangeImagePromptState(
      prompt: prompt,
    );
  }

  @override
  List<Object?> get props => [prompt];
}
