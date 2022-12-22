import 'open_ai_image.dart';

class OpenAIData {
  final int created;
  final List<OpenAIImage> images;

  OpenAIData(this.created, this.images);
}