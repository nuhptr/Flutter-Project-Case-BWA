part of 'transaction_cubit.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionSuccess extends TransactionState {
  TransactionSuccess(this.transactions);

  final List<TransactionModel> transactions;

  @override
  List<Object> get props => [transactions];
}

class TransactionFailed extends TransactionState {
  TransactionFailed(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
