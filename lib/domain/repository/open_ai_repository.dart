import '../../data/dto/open_ai_data_dto.dart';

abstract class OpenAIRepository {
  Future<OpenAIDataDTO> getImages({required String prompt, required int n, required String size});
}