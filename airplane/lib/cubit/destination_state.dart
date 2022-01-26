part of 'destination_cubit.dart';

abstract class DestinationState extends Equatable {
  const DestinationState();

  @override
  List<Object> get props => [];
}

class DestinationInitial extends DestinationState {}

class DestinationLoading extends DestinationState {}

class DestinationSuccess extends DestinationState {
  DestinationSuccess(this.destinationModel);

  final List<DestinationModel> destinationModel;

  @override
  List<Object> get props => [destinationModel];
}

class DestinationFailed extends DestinationState {
  DestinationFailed(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
