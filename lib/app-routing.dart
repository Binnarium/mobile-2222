import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/ui/screens/chat-participants.screen.dart';
import 'package:lab_movil_2222/chat/ui/screens/chats.screen.dart';
import 'package:lab_movil_2222/chat/ui/screens/detailed-multimedia.screen.dart';
import 'package:lab_movil_2222/chat/ui/screens/messages.screen.dart';
import 'package:lab_movil_2222/cities/activity/widgets/activities.screen.dart';
import 'package:lab_movil_2222/cities/argument-ideas/ui/screens/argument-ideas.screen.dart';
import 'package:lab_movil_2222/cities/clubhouse/ui/screens/add-clubhouse.screen.dart';
import 'package:lab_movil_2222/cities/clubhouse/ui/screens/clubhouse-explanation.screen.dart';
import 'package:lab_movil_2222/cities/clubhouse/ui/screens/clubhouse.screen.dart';
import 'package:lab_movil_2222/cities/contribution/ui/screens/city-contribution.screen.dart';
import 'package:lab_movil_2222/cities/contribution/ui/screens/contribution-explanation.screen.dart';
import 'package:lab_movil_2222/cities/final-video/widgets/final-video.screen.dart';
import 'package:lab_movil_2222/cities/manual-video/widgets/manual-video.screen.dart';
import 'package:lab_movil_2222/cities/monster/ui/screens/stageMonster.screen.dart';
import 'package:lab_movil_2222/cities/project-video/widgets/project-video.screen.dart';
import 'package:lab_movil_2222/cities/project/ui/screens/project.screen.dart';
import 'package:lab_movil_2222/city/ui/screen/home.screen.dart';
import 'package:lab_movil_2222/player/ui/screens/profile.screen.dart';
import 'package:lab_movil_2222/project-awards/ui/screens/project-awards.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/city-introduction.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/content.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/introductory-video.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/resources.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageHistory.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageobjectives.screen.dart';
import 'package:lab_movil_2222/screens/welcome.screen.dart';
import 'package:lab_movil_2222/start-video/widgets/start-video.screen.dart';
import 'package:lab_movil_2222/team/ui/screens/team.screen.dart';
import 'package:lab_movil_2222/user/widgets/login.screen.dart';
import 'package:lab_movil_2222/user/widgets/register.screen.dart';
import 'package:lab_movil_2222/user/widgets/splash.screen.dart';

import 'cities/micro-meso-macro/ui/screens/micro-meso-macro.screen.dart';

class Lab2222Routing extends MaterialPageRoute<Widget> {
  Lab2222Routing(RouteSettings settings)
      : super(
          builder: (context) {
            switch (settings.name) {
              case SplashScreen.route:
                return SplashScreen();

              case StartVideoScreen.route:
                return StartVideoScreen();

              case WelcomeScreen.route:
                return WelcomeScreen();

              case TeamScreen.route:
                return TeamScreen();

              case LoginScreen.route:
                return const LoginScreen();

              case RegisterScreen.route:
                return RegisterScreen();

              case HomeScreen.route:
                return HomeScreen();

              case ProfileScreen.route:
                return ProfileScreen();

              /// all chats screens
              case ChatsScreen.route:
                return const ChatsScreen();

              case CityIntroductionScreen.route:
                final args = settings.arguments! as CityIntroductionScreen;
                return CityIntroductionScreen(
                  city: args.city,
                );

              case MessagesScreen.route:
                final args = settings.arguments! as MessagesScreen;
                return MessagesScreen(
                  chat: args.chat,
                );
              case ChatParticipantsScreen.route:
                final args = settings.arguments! as ChatParticipantsScreen;
                return ChatParticipantsScreen(
                  chat: args.chat,
                );

              /// to go to the multimedia detailed screen in the chat
              case DetailedMultimediaScreen.route:
                final args = settings.arguments! as DetailedMultimediaScreen;
                return DetailedMultimediaScreen(
                  message: args.message,
                );

              case IntroductoryVideoScreen.route:
                final args = settings.arguments! as IntroductoryVideoScreen;
                return IntroductoryVideoScreen(
                  city: args.city,
                );

              case StageHistoryScreen.route:
                final args = settings.arguments! as StageHistoryScreen;
                return StageHistoryScreen(
                  city: args.city,
                );

              case StageMonsterScreen.route:
                final args = settings.arguments! as StageMonsterScreen;
                return StageMonsterScreen(
                  city: args.city,
                );

              case ArgumentIdeasScreen.route:
                final args = settings.arguments! as ArgumentIdeasScreen;
                return ArgumentIdeasScreen(
                  city: args.city,
                );

              case StageObjetivesScreen.route:
                final args = settings.arguments! as StageObjetivesScreen;
                return StageObjetivesScreen(
                  city: args.city,
                );

              case ContentScreen.route:
                final args = settings.arguments! as ContentScreen;
                return ContentScreen(
                  city: args.city,
                );

              case ResourcesScreen.route:
                final args = settings.arguments! as ResourcesScreen;
                return ResourcesScreen(
                  city: args.city,
                );

              case ActivitiesScreen.route:
                final args = settings.arguments! as ActivitiesScreen;
                return ActivitiesScreen(
                  city: args.city,
                );

              ///
              case ContributionExplanationScreen.route:
                final args =
                    settings.arguments! as ContributionExplanationScreen;
                return ContributionExplanationScreen(
                  city: args.city,
                );

              ///
              case ContributionScreen.route:
                final args = settings.arguments! as ContributionScreen;
                return ContributionScreen(
                  city: args.city,
                );

              case ClubhouseExplanationScreen.route:
                final args = settings.arguments! as ClubhouseExplanationScreen;
                return ClubhouseExplanationScreen(
                  city: args.city,
                );

              case ClubhouseScreen.route:
                final args = settings.arguments! as ClubhouseScreen;
                return ClubhouseScreen(
                  city: args.city,
                );

              case AddClubhouseScreen.route:
                final args = settings.arguments! as AddClubhouseScreen;
                return AddClubhouseScreen(
                  city: args.city,
                );

              case MicroMesoMacroScreen.route:
                final args = settings.arguments! as MicroMesoMacroScreen;
                return MicroMesoMacroScreen(
                  city: args.city,
                );

              case ProjectVideoScreen.route:
                final args = settings.arguments! as ProjectVideoScreen;
                return ProjectVideoScreen(
                  city: args.city,
                );

              case CityProjectScreen.route:
                final args = settings.arguments! as CityProjectScreen;
                return CityProjectScreen(
                  city: args.city,
                );

              case ProjectAwardsProject.route:
                final args = settings.arguments! as ProjectAwardsProject;
                return ProjectAwardsProject(
                  city: args.city,
                );

              case ManualVideoScreen.route:
                final args = settings.arguments! as ManualVideoScreen;
                return ManualVideoScreen(
                  city: args.city,
                );
              case FinalVideoScreen.route:
                final args = settings.arguments! as FinalVideoScreen;
                return FinalVideoScreen(
                  city: args.city,
                );

              default:
                return SplashScreen();
            }
          },
        );
}