import '../../domain/model/open_ai_data.dart';
import 'open_ai_image_dto.dart';

class OpenAIDataDTO {
  int? created;
  List<OpenAIImageDTO>? images;

  OpenAIDataDTO({
    this.created,
    this.images,
  });

  OpenAIDataDTO.fromJson(Map<String, dynamic> json) {
    created = json['created'];
    images = (json['data'] as List<dynamic>?)?.map((e) => OpenAIImageDTO.fromJson(e as Map<String, dynamic>)).toList();
  }

  OpenAIData toOpenAIData() {
    if (created == null) throw Exception('Created response not found');
    if (images == null) throw Exception('Images response not found');

    return OpenAIData(
      created!,
      images!.map((e) => e.toOpenAIImage()).toList(),
    );
  }
}
