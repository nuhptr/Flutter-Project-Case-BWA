import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/model/ticket.dart';
import '/model/movie_detail.dart';
import '/model/movie.dart';
import '/model/register_user.dart';
import '/model/flutive_transaction.dart';
import '/model/user.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc(PageState initialState) : super(OnInitialPage());

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    // TODO: Masukannya event
    if (event is GoToSplashPage) {
      // TODO: akan mengembalikan sebuah state
      yield OnSplashPage();
    } //*
    else if (event is GoToSignInPage) {
      yield OnLoginPage();
    } //*
    else if (event is GoToMainPage) {
      yield OnMainPage();
    } //*
    // TODO: akan mengembalikan sebuah state dengan data
    else if (event is GotoRegistrationPage) {
      yield OnRegistrationPage(event.registerUser);
    } //*
    else if (event is GoToPreferencePage) {
      yield OnPreferencePage(event.registerUser);
    } //*
    else if (event is GoToAccountConfirmationPage) {
      yield OnAccountConfirmationPage(event.registerUser);
    }
    //*
    else if (event is GoToMovieDetailPage) {
      yield OnMovieDetailPage(event.movie);
    }
    //*
    else if (event is GoToSelectSchedulePage) {
      yield OnSelectSchedulePage(event.movieDetail);
    }
    //*
    else if (event is GoToSelectSeatPage) {
      yield OnSelectSeatPage(event.ticket);
    }
    //*
    else if (event is GoToCheckoutPage) {
      yield OnCheckoutPage(event.ticket);
    }
    //*
    else if (event is GoToSuccessPage) {
      yield OnSuccessPage(event.ticket, event.flutiveTransaction);
    }
    //*
    else if (event is GoToTicketDetailPage) {
      yield OnTicketDetailPage(event.ticket);
    }
    //*
    else if (event is GoToProfilePage) {
      yield OnProfilePage(event.user);
    }
    //*
    else if (event is GoToTopUpPage) {
      yield OnTopUpPage(event.pageEvent);
    }
    //*
    else if (event is GoToTicketPage) {
      yield OnTicketPage();
    }
    //*
    else if (event is GoToWalletPage) {
      yield OnWalletPage(event.pageEvent);
    }
    //*
    else if (event is GoToEditProfilePage) {
      yield OnEditProfilePage(event.user);
    }
  }
}
