part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

// TODO: event untuk ke SplashPage
class GoToSplashPage extends PageEvent {
  @override
  List<Object> get props => [];
}

// TODO: event untuk ke LoginPage
class GoToSignInPage extends PageEvent {
  @override
  List<Object> get props => [];
}

// TODO: event untuk ke MainPage
class GoToMainPage extends PageEvent {
  @override
  List<Object> get props => [];
}

// TODO: event untuk ke RegistrasionPage
class GotoRegistrationPage extends PageEvent {
  final RegisterUser registerUser;

  GotoRegistrationPage(this.registerUser);

  @override
  List<Object> get props => [registerUser];
}

// TODO: event untuk ke AccountConfirmationPage
class GoToAccountConfirmationPage extends PageEvent {
  final RegisterUser registerUser;

  GoToAccountConfirmationPage(this.registerUser);

  @override
  List<Object> get props => [registerUser];
}

// TODO: event untuk ke PreferencePage
class GoToPreferencePage extends PageEvent {
  final RegisterUser registerUser;

  GoToPreferencePage(this.registerUser);

  @override
  List<Object> get props => [registerUser];
}

// TODO: event untuk ke MovieDetailPage
class GoToMovieDetailPage extends PageEvent {
  final Movie movie;

  GoToMovieDetailPage(this.movie);

  @override
  List<Object> get props => [movie];
}

// TODO: event untuk ke SelectSchedulePage
class GoToSelectSchedulePage extends PageEvent {
  final MovieDetail movieDetail;

  GoToSelectSchedulePage(this.movieDetail);

  @override
  // TODO: implement props
  List<Object> get props => [movieDetail];
}

// TODO: event untuk ke SelectSeatPage
class GoToSelectSeatPage extends PageEvent {
  final Ticket ticket;

  GoToSelectSeatPage(this.ticket);

  @override
  List<Object> get props => [ticket];
}

// TODO: event ke CheckOutPage
class GoToCheckoutPage extends PageEvent {
  final Ticket ticket;

  GoToCheckoutPage(this.ticket);

  @override
  List<Object> get props => [ticket];
}

// TODO: event ke SuccessPage
class GoToSuccessPage extends PageEvent {
  final Ticket ticket;
  final FlutiveTransaction flutiveTransaction;

  GoToSuccessPage(this.ticket, this.flutiveTransaction);

  @override
  List<Object> get props => [ticket, flutiveTransaction];
}

// TODO: event ke TicketDetailPage
class GoToTicketDetailPage extends PageEvent {
  final Ticket ticket;

  GoToTicketDetailPage(this.ticket);

  @override
  List<Object> get props => [ticket];
}

// TODO: event ke ProfilePage
class GoToProfilePage extends PageEvent {
  final User user;

  GoToProfilePage(this.user);

  @override
  List<Object> get props => [user];
}

// TODO: event ke TopUpPage
class GoToTopUpPage extends PageEvent {
  final PageEvent pageEvent;

  GoToTopUpPage(this.pageEvent);

  @override
  List<Object> get props => [pageEvent];
}

// TODO: event ke kelas TicketPage
class GoToTicketPage extends PageEvent {
  @override
  List<Object> get props => [];
}

// TODO: event ke kelas WalletPage
class GoToWalletPage extends PageEvent {
  final PageEvent pageEvent;

  GoToWalletPage(this.pageEvent);

  @override
  List<Object> get props => [pageEvent];
}

// TODO: event ke kelas EditProfilePage
class GoToEditProfilePage extends PageEvent {
  final User user;

  GoToEditProfilePage(this.user);
  
  @override
  List<Object> get props => [user];
}
