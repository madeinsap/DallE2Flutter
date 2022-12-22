import '../../domain/model/open_ai_image.dart';

class OpenAIImageDTO {
  String? url;

  OpenAIImageDTO({
    this.url,
  });

  OpenAIImageDTO.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  OpenAIImage toOpenAIImage() {
    if (url == null) throw Exception('Url response not found');

    return OpenAIImage(url!);
  }
}
