import 'package:equatable/equatable.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();
}

class GetImagesEvent extends ImageEvent {
  final String prompt;
  final int n;
  final String size;

  const GetImagesEvent({required this.prompt, required this.n, required this.size});

  @override
  List<Object?> get props => [prompt, n, size];
}

class ClearImageEvent extends ImageEvent {
  @override
  List<Object?> get props => [];
}

class ChangeImagePromptEvent extends ImageEvent {
  final String prompt;

  const ChangeImagePromptEvent({required this.prompt});

  @override
  List<Object?> get props => [prompt];
}
