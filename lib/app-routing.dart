import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            print('called router at: ${settings.name}');
            if (settings.name == SplashScreen.route) return SplashScreen();

            if (settings.name == StartVideoScreen.route)
              return StartVideoScreen();

            if (settings.name == WelcomeScreen.route) return WelcomeScreen();

            if (settings.name == TeamScreen.route) return TeamScreen();

            if (settings.name == LoginScreen.route) return LoginScreen();

            if (settings.name == RegisterScreen.route) return RegisterScreen();

            if (settings.name == HomeScreen.route) return HomeScreen();

            if (settings.name == ProfileScreen.route) return ProfileScreen();

            /// all chats screens
            if (settings.name == ChatsScreen.route) return ChatsScreen();

            if (settings.name == CityIntroductionScreen.route) {
              final args = settings.arguments as CityIntroductionScreen;
              return CityIntroductionScreen(
                city: args.city,
              );
            }
            if (settings.name == MessagesScreen.route) {
              final args = settings.arguments as MessagesScreen;
              return MessagesScreen(
                chat: args.chat,
              );
            }
            if (settings.name == ChatParticipantsScreen.route) {
              final args = settings.arguments as ChatParticipantsScreen;
              return ChatParticipantsScreen(
                chat: args.chat,
              );
            }

            /// to go to the multimedia detailed screen in the chat
            if (settings.name == DetailedMultimediaScreen.route) {
              final args = settings.arguments as DetailedMultimediaScreen;
              return DetailedMultimediaScreen(
                isVideo: args.isVideo,
                multimedia: args.multimedia,
              );
            }
            if (settings.name == IntroductoryVideoScreen.route) {
              final args = settings.arguments as IntroductoryVideoScreen;
              return IntroductoryVideoScreen(
                city: args.city,
              );
            }
            if (settings.name == StageHistoryScreen.route) {
              final args = settings.arguments as StageHistoryScreen;
              return StageHistoryScreen(
                city: args.city,
              );
            }
            if (settings.name == StageMonsterScreen.route) {
              final args = settings.arguments as StageMonsterScreen;
              return StageMonsterScreen(
                city: args.city,
              );
            }
            if (settings.name == ArgumentIdeasScreen.route) {
              final args = settings.arguments as ArgumentIdeasScreen;
              return ArgumentIdeasScreen(
                city: args.city,
              );
            }
            if (settings.name == StageObjetivesScreen.route) {
              final args = settings.arguments as StageObjetivesScreen;
              return StageObjetivesScreen(
                city: args.city,
              );
            }
            if (settings.name == ContentScreen.route) {
              final args = settings.arguments as ContentScreen;
              return ContentScreen(
                city: args.city,
              );
            }
            if (settings.name == ResourcesScreen.route) {
              final args = settings.arguments as ResourcesScreen;
              return ResourcesScreen(
                city: args.city,
              );
            }
            if (settings.name == ActivitiesScreen.route) {
              final args = settings.arguments as ActivitiesScreen;
              return ActivitiesScreen(
                city: args.city,
              );
            }

            ///
            if (settings.name == ContributionExplanationScreen.route) {
              final args = settings.arguments as ContributionExplanationScreen;
              return ContributionExplanationScreen(
                city: args.city,
              );
            }

            ///
            if (settings.name == ContributionScreen.route) {
              final args = settings.arguments as ContributionScreen;
              return ContributionScreen(
                city: args.city,
              );
            }
            if (settings.name == ClubhouseExplanationScreen.route) {
              final args = settings.arguments as ClubhouseExplanationScreen;
              return ClubhouseExplanationScreen(
                city: args.city,
              );
            }
            if (settings.name == ClubhouseScreen.route) {
              final args = settings.arguments as ClubhouseScreen;
              return ClubhouseScreen(
                city: args.city,
              );
            }
            if (settings.name == AddClubhouseScreen.route) {
              final args = settings.arguments as AddClubhouseScreen;
              return AddClubhouseScreen(
                city: args.city,
              );
            }

            if (settings.name == MicroMesoMacroScreen.route) {
              final args = settings.arguments as MicroMesoMacroScreen;
              return MicroMesoMacroScreen(
                city: args.city,
              );
            }
            if (settings.name == ProjectVideoScreen.route) {
              final args = settings.arguments as ProjectVideoScreen;
              return ProjectVideoScreen(
                city: args.city,
              );
            }
            if (settings.name == CityProjectScreen.route) {
              final args = settings.arguments as CityProjectScreen;
              return CityProjectScreen(
                city: args.city,
              );
            }
            if (settings.name == ProjectAwardsProject.route) {
              final args = settings.arguments as ProjectAwardsProject;
              return ProjectAwardsProject(
                city: args.city,
              );
            }
            if (settings.name == ManualVideoScreen.route) {
              final args = settings.arguments as ManualVideoScreen;
              return ManualVideoScreen(
                city: args.city,
              );
            }
            if (settings.name == FinalVideoScreen.route) {
              final args = settings.arguments as FinalVideoScreen;
              return FinalVideoScreen(
                city: args.city,
              );
            }

            print('-----------------');
            print('ROUTE NOT DEFINED');
            print('-----------------');

            ///TODO: Fix this bad gateway
            /// to exit the application (in theory)
            throw SystemChannels.platform
                .invokeMethod<String>('SystemNavigator.pop');
          },
        );
}
