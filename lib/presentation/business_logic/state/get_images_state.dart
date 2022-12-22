import 'package:equatable/equatable.dart';

import '../../../domain/model/open_ai_data.dart';

class GetImagesState extends Equatable {
  final bool isLoading;
  final String? error;
  final OpenAIData? data;

  const GetImagesState({
    required this.isLoading,
    this.error,
    this.data,
  });

  GetImagesState copyWith(bool isLoading, String? error, OpenAIData? data) {
    return GetImagesState(
      isLoading: isLoading,
      error: error,
      data: data,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, data];
}
