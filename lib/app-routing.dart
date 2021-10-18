import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/assets/audio/services/current-audio.provider.dart';
import 'package:lab_movil_2222/assets/video/ui/screens/detailed-video.screen.dart';
import 'package:lab_movil_2222/authentication/login/login.screen.dart';
import 'package:lab_movil_2222/authentication/register/register.screen.dart';
import 'package:lab_movil_2222/authentication/splash/splash.screen.dart';
import 'package:lab_movil_2222/authentication/start-video/start-video.screen.dart';
import 'package:lab_movil_2222/chat/chats/ui/screens/chats.screen.dart';
import 'package:lab_movil_2222/chat/chats/ui/screens/personal-chats.screen.dart';
import 'package:lab_movil_2222/chat/ui/screens/chat-participants.screen.dart';
import 'package:lab_movil_2222/chat/ui/screens/detailed-image.screen.dart';
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
import 'package:lab_movil_2222/player/ui/screens/scoreboard.screen.dart';
import 'package:lab_movil_2222/project-awards/ui/screens/project-awards.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/city-introduction.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/content.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/introductory-video.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/resources.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageHistory.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageobjectives.screen.dart';
import 'package:lab_movil_2222/screens/welcome.screen.dart';
import 'package:lab_movil_2222/team/ui/screens/team.screen.dart';
import 'package:lab_movil_2222/thanks-videos/widgets/next-phase-video.screen.dart';
import 'package:provider/provider.dart';

import 'cities/micro-meso-macro/ui/screens/micro-meso-macro.screen.dart';

class Lab2222Routing extends MaterialPageRoute<Widget> {
  Lab2222Routing(RouteSettings settings)
      : super(
          builder: (context) {
            /// podcast provider
            final CurrentAudioProvider audioProvider =
                Provider.of<CurrentAudioProvider>(context, listen: false);

            try {
              if (audioProvider.player != null &&
                  audioProvider.player.playing) {
                audioProvider.player.pause();
              }
            } catch (e) {
              print('Error al pausar podcast $e');
            }

            if (settings.name == SplashScreen.route) {
              return const SplashScreen();
            }

            if (settings.name == StartVideoScreen.route)
              return const StartVideoScreen();

            if (settings.name == WelcomeScreen.route) {
              return WelcomeScreen();
            }

            if (settings.name == TeamScreen.route) {
              return TeamScreen();
            }

            if (settings.name == LoginScreen.route) {
              return LoginScreen();
            }

            if (settings.name == RegisterScreen.route) {
              return const RegisterScreen();
            }

            if (settings.name == HomeScreen.route) {
              return const HomeScreen();
            }

            if (settings.name == ProfileScreen.route) {
              return ProfileScreen();
            }

            /// all chats screens
            if (settings.name == ChatsScreen.route) {
              return const ChatsScreen();
            }
            if (settings.name == PersonalChatsScreen.route) {
              return const PersonalChatsScreen();
            }

            if (settings.name == CityIntroductionScreen.route) {
              final args = settings.arguments! as CityIntroductionScreen;
              return CityIntroductionScreen(
                city: args.city,
              );
            }
            if (settings.name == MessagesScreen.route) {
              final args = settings.arguments! as MessagesScreen;
              return MessagesScreen(
                chat: args.chat,
              );
            }
            if (settings.name == ChatParticipantsScreen.route) {
              final args = settings.arguments! as ChatParticipantsScreen;
              return ChatParticipantsScreen(
                chat: args.chat,
              );
            }

            /// to go to the multimedia detailed screen in the chat
            if (settings.name == DetailedVideoScreen.route) {
              final args = settings.arguments! as DetailedVideoScreen;
              return DetailedVideoScreen(
                video: args.video,
              );
            }
            if (settings.name == DetailedImageScreen.route) {
              final args = settings.arguments! as DetailedImageScreen;
              return DetailedImageScreen(
                image: args.image,
              );
            }
            if (settings.name == IntroductoryVideoScreen.route) {
              final args = settings.arguments! as IntroductoryVideoScreen;
              return IntroductoryVideoScreen(
                city: args.city,
              );
            }
            if (settings.name == StageHistoryScreen.route) {
              final args = settings.arguments! as StageHistoryScreen;
              return StageHistoryScreen(
                city: args.city,
              );
            }
            if (settings.name == StageMonsterScreen.route) {
              final args = settings.arguments! as StageMonsterScreen;
              return StageMonsterScreen(
                city: args.city,
              );
            }
            if (settings.name == ArgumentIdeasScreen.route) {
              final args = settings.arguments! as ArgumentIdeasScreen;
              return ArgumentIdeasScreen(
                city: args.city,
              );
            }
            if (settings.name == StageObjetivesScreen.route) {
              final args = settings.arguments! as StageObjetivesScreen;
              return StageObjetivesScreen(
                city: args.city,
              );
            }
            if (settings.name == ContentScreen.route) {
              final args = settings.arguments! as ContentScreen;
              return ContentScreen(
                city: args.city,
              );
            }
            if (settings.name == ResourcesScreen.route) {
              final args = settings.arguments! as ResourcesScreen;
              return ResourcesScreen(
                city: args.city,
              );
            }
            if (settings.name == ActivitiesScreen.route) {
              final args = settings.arguments! as ActivitiesScreen;
              return ActivitiesScreen(
                city: args.city,
              );
            }

            ///
            if (settings.name == ContributionExplanationScreen.route) {
              final args = settings.arguments! as ContributionExplanationScreen;
              return ContributionExplanationScreen(
                city: args.city,
              );
            }

            ///
            if (settings.name == ContributionScreen.route) {
              final args = settings.arguments! as ContributionScreen;
              return ContributionScreen(
                city: args.city,
              );
            }
            if (settings.name == ClubhouseExplanationScreen.route) {
              final args = settings.arguments! as ClubhouseExplanationScreen;
              return ClubhouseExplanationScreen(
                city: args.city,
              );
            }
            if (settings.name == ClubhouseScreen.route) {
              final args = settings.arguments! as ClubhouseScreen;
              return ClubhouseScreen(
                city: args.city,
              );
            }
            if (settings.name == AddClubhouseScreen.route) {
              final args = settings.arguments! as AddClubhouseScreen;
              return AddClubhouseScreen(
                city: args.city,
              );
            }

            if (settings.name == MicroMesoMacroScreen.route) {
              final args = settings.arguments! as MicroMesoMacroScreen;
              return MicroMesoMacroScreen(
                city: args.city,
              );
            }
            if (settings.name == ProjectVideoScreen.route) {
              final args = settings.arguments! as ProjectVideoScreen;
              return ProjectVideoScreen(
                city: args.city,
              );
            }
            if (settings.name == CityProjectScreen.route) {
              final args = settings.arguments! as CityProjectScreen;
              return CityProjectScreen(
                city: args.city,
              );
            }
            if (settings.name == ProjectAwardsProject.route) {
              final args = settings.arguments! as ProjectAwardsProject;
              return ProjectAwardsProject(
                city: args.city,
              );
            }
            if (settings.name == ManualVideoScreen.route) {
              final args = settings.arguments! as ManualVideoScreen;
              return ManualVideoScreen(
                city: args.city,
              );
            }
            if (settings.name == NextPhaseVideoScreen.route) {
              final args = settings.arguments! as NextPhaseVideoScreen;
              return NextPhaseVideoScreen(
                city: args.city,
              );
            }

            ///Scoreboard Screen
            if (settings.name == ScoreboardPlayersScreen.route) {
              return const ScoreboardPlayersScreen();
            }

            if (settings.name == FinalVideoScreen.route) {
              final args = settings.arguments! as FinalVideoScreen;
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
