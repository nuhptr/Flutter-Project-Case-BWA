import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/ui/pages/profile_edit.dart';
import '/ui/pages/wallet_page.dart';
import '/ui/pages/topup_page.dart';
import '/ui/pages/checkout_page.dart';
import '/ui/pages/select_seat_page.dart';
import '/ui/pages/select_schedule_page.dart';
import '/ui/pages/moviedetail_page.dart';
import '/ui/pages/account_confirmation.dart';
import '/ui/pages/signup_page.dart';
import '/ui/pages/preference_page.dart';
import '/bloc/user_bloc.dart';
import '/bloc/page_bloc.dart';
import '/ui/pages/main_page.dart';
import 'pages/sign_in_page.dart';
import '/ui/pages/splash_page.dart';
import '/shared/shared_value.dart';
import '/bloc/ticket_bloc.dart';
import '/ui/pages/profile_page.dart';
import '/ui/pages/success_page.dart';
import '/ui/pages/ticket_detail.dart';
import 'pages/ticket_page.dart';

class ManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: provider.of
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);

    if (firebaseUser == null) {
      // TODO: jika event bukan gotosplash maka kesini
      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();
        context.read<PageBloc>().add(GoToSplashPage());
      }
    } else {
      if (!(prevPageEvent is GoToMainPage)) {
        context.read<UserBloc>().add(LoadUser(firebaseUser.uid));
        context.read<TicketBloc>().add(GetTickets(firebaseUser.uid));

        prevPageEvent = GoToMainPage();
        context.read<PageBloc>().add(GoToMainPage());
      }
    }

    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnSplashPage)
            ? SplashPage()
            : (pageState is OnLoginPage)
                ? SignInPage()
                : (pageState is OnRegistrationPage)
                    ? SignUpPage(pageState.registerUser)
                    : (pageState is OnPreferencePage)
                        ? PreferenceGenreAndLanguagePage(pageState.registerUser)
                        : (pageState is OnAccountConfirmationPage)
                            ? AccountConfirmationPage(pageState.registerUser)
                            : (pageState is OnMovieDetailPage)
                                ? MovieDetailPage(pageState.movie)
                                : (pageState is OnSelectSchedulePage)
                                    ? SelectSchedulePage(pageState.movieDetail)
                                    : (pageState is OnSelectSeatPage)
                                        ? SelectSeatPage(pageState.ticket)
                                        : (pageState is OnCheckoutPage)
                                            ? CheckOutPage(pageState.ticket)
                                            : (pageState is OnSuccessPage)
                                                ? SuccessPage(
                                                    pageState.ticket,
                                                    pageState
                                                        .flutiveTransaction,
                                                  )
                                                : (pageState
                                                        is OnTicketDetailPage)
                                                    ? TicketDetailPage(
                                                        pageState.ticket)
                                                    : (pageState
                                                            is OnProfilePage)
                                                        ? ProfilePage(
                                                            pageState.user)
                                                        : (pageState
                                                                is OnTopUpPage)
                                                            ? TopUpPage(
                                                                pageState
                                                                    .pageEvent)
                                                            : (pageState
                                                                    is OnTicketPage)
                                                                ? TicketPage()
                                                                : (pageState
                                                                        is OnWalletPage)
                                                                    ? WalletPage(
                                                                        pageState
                                                                            .pageEvent)
                                                                    : (pageState
                                                                            is OnEditProfilePage)
                                                                        ? EditProfilePage(
                                                                            pageState.user)
                                                                        : MainPage());
  }
}
