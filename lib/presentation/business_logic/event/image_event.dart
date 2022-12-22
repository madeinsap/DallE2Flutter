import 'package:equatable/equatable.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();
}

class GetImagesEvent extends ImageEvent {
  final String prompt;
  final int n;
  final String size;

  const GetImagesEvent(this.prompt, this.n, this.size);

  @override
  List<Object?> get props => [prompt, n, size];
}
