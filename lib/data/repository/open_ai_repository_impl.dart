import '../../data/dto/open_ai_data_dto.dart';
import '../../domain/repository/open_ai_repository.dart';
import '../data_source/open_ai_data_source.dart';

class OpenAIRepositoryImpl implements OpenAIRepository {
  final OpenAIDataSource dataSource;

  const OpenAIRepositoryImpl(this.dataSource);

  @override
  Future<OpenAIDataDTO> getImages({required String prompt, required int n, required String size}) {
    return dataSource.getImages(prompt: prompt, n: n, size: size);
  }
}