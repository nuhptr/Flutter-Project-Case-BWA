part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  PageState();
}

// TODO: belum diinisialisasi sama sekali
class OnInitialPage extends PageState {
  @override
  List<Object> get props => [];
}

// TODO: state untuk kelas loginPage
class OnLoginPage extends PageState {
  @override
  List<Object> get props => [];
}

// TODO: state untuk kelas SplashPage
class OnSplashPage extends PageState {
  @override
  List<Object> get props => [];
}

// TODO: state untuk kelas SchedulePage
class OnMainPage extends PageState {
  @override
  List<Object> get props => [];
}

// TODO: state data untuk kelas RegistrationPage
class OnRegistrationPage extends PageState {
  final RegisterUser registerUser;

  OnRegistrationPage(this.registerUser);

  @override
  List<Object> get props => [registerUser];
}

// TODO: state data untuk kelas PreferencePage
class OnPreferencePage extends PageState {
  final RegisterUser registerUser;

  OnPreferencePage(this.registerUser);

  @override
  List<Object> get props => [registerUser];
}

// TODO: state data untuk kelas AccountConfirmationPage
class OnAccountConfirmationPage extends PageState {
  final RegisterUser registerUser;

  OnAccountConfirmationPage(this.registerUser);

  @override
  List<Object> get props => [registerUser];
}

// TODO: state data untuk kelas MovieDetailPage
class OnMovieDetailPage extends PageState {
  final Movie movie;

  OnMovieDetailPage(this.movie);

  @override
  List<Object> get props => [movie];
}

// TODO: state data untuk kelas SchedulePage
class OnSelectSchedulePage extends PageState {
  final MovieDetail movieDetail;

  OnSelectSchedulePage(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

// TODO: state untuk data kelas SelectSeatPage
class OnSelectSeatPage extends PageState {
  final Ticket ticket;

  OnSelectSeatPage(this.ticket);

  @override
  List<Object> get props => [ticket];
}

// TODO: state untuk data kelas CheckOutPage
class OnCheckoutPage extends PageState {
  final Ticket ticket;

  OnCheckoutPage(this.ticket);

  @override
  List<Object> get props => [ticket];
}

// TODO: state untuk data kelas Suceess Page
class OnSuccessPage extends PageState {
  final Ticket ticket;
  final FlutiveTransaction flutiveTransaction;

  OnSuccessPage(this.ticket, this.flutiveTransaction);

  @override
  List<Object> get props => [ticket, flutiveTransaction];
}

// TODO: state untuk data kelas TicketDetailPage
class OnTicketDetailPage extends PageState {
  final Ticket ticket;

  OnTicketDetailPage(this.ticket);

  @override
  List<Object> get props => [ticket];
}

// TODO: state kelas ProfilePage
class OnProfilePage extends PageState {
  final User user;

  OnProfilePage(this.user);

  @override
  List<Object> get props => [user];
}

// TODO: state data kelas TopUpPage
class OnTopUpPage extends PageState {
  final PageEvent pageEvent;

  OnTopUpPage(this.pageEvent);

  @override
  List<Object> get props => [pageEvent];
}

// TODO: state kelas TicketPage
class OnTicketPage extends PageState {
  @override
  List<Object> get props => [];
}

// TODO: state kelas TicketPage
class OnWalletPage extends PageState {
  final PageEvent pageEvent;

  OnWalletPage(this.pageEvent);

  @override
  List<Object> get props => [pageEvent];
}

// TODO: state data kelas EditProfilePage
class OnEditProfilePage extends PageState {
  final User user;

  OnEditProfilePage(this.user);

  @override
  List<Object> get props => [user];
}
