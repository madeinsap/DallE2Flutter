import '../dto/open_ai_data_dto.dart';

abstract class OpenAIDataSource {
  Future<OpenAIDataDTO> getImages({required String prompt, required int n, required String size});
}