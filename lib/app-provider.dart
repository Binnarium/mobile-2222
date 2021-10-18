import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/audio/services/current-audio.provider.dart';
import 'package:lab_movil_2222/assets/image/services/upload-image.service.dart';
import 'package:lab_movil_2222/assets/video/services/load-better-video.service.dart';
import 'package:lab_movil_2222/authentication/login/login-user.service.dart';
import 'package:lab_movil_2222/authentication/register/register-user.service.dart';
import 'package:lab_movil_2222/authentication/sign-out/sign-out.service.dart';
import 'package:lab_movil_2222/authentication/splash/is-user-signed-in.service.dart';
import 'package:lab_movil_2222/authentication/start-video/load-start-video.service.dart';
import 'package:lab_movil_2222/chat/chats/services/create-personal-chat.service.dart';
import 'package:lab_movil_2222/chat/chats/services/get-chat.service.dart';
import 'package:lab_movil_2222/chat/chats/services/list-chats-folders.service.dart';
import 'package:lab_movil_2222/chat/chats/services/list-chats.service.dart';
import 'package:lab_movil_2222/chat/services/delete-message.service.dart';
import 'package:lab_movil_2222/chat/services/list-messages.service.dart';
import 'package:lab_movil_2222/chat/services/send-message.service.dart';
import 'package:lab_movil_2222/cities/activity/services/load-activity.service.dart';
import 'package:lab_movil_2222/cities/argument-ideas/services/arguments-ideas.service.dart';
import 'package:lab_movil_2222/cities/clubhouse/services/get-clubhouse-explanation.service.dart';
import 'package:lab_movil_2222/cities/clubhouse/services/load-user-clubhouse.service.dart';
import 'package:lab_movil_2222/cities/contribution/services/contribution-activity.service.dart';
import 'package:lab_movil_2222/cities/contribution/services/get-contribution-explanation.service.dart';
import 'package:lab_movil_2222/cities/monster/services/load-monster.service.dart';
import 'package:lab_movil_2222/cities/project/services/upload-file.service.dart';
import 'package:lab_movil_2222/city/services/cities.service.dart';
import 'package:lab_movil_2222/city/services/load-cities-with-map-position.service.dart';
import 'package:lab_movil_2222/player/gamification-explanation/services/gamification-explanation.service.dart';
import 'package:lab_movil_2222/player/services/current-player.service.dart';
import 'package:lab_movil_2222/player/services/list-players-of-group.service.dart';
import 'package:lab_movil_2222/player/services/search-players.service.dart';
import 'package:lab_movil_2222/player/services/update-avatar.service.dart';
import 'package:lab_movil_2222/project-awards/services/medals.service.dart';
import 'package:lab_movil_2222/services/load-city-history.service.dart';
import 'package:lab_movil_2222/services/load-city-introduction.service.dart';
import 'package:lab_movil_2222/services/load-city-introductory-video.service.dart';
import 'package:lab_movil_2222/services/load-city-resources.service.dart';
import 'package:lab_movil_2222/services/load-contents-screen-information.service.dart';
import 'package:lab_movil_2222/services/load-login-information.service.dart';
import 'package:lab_movil_2222/services/load-player-information.service.dart';
import 'package:lab_movil_2222/services/load-players-scoreboard.service.dart';
import 'package:lab_movil_2222/services/load-project-activity.service.dart';
import 'package:lab_movil_2222/team/services/load-team.service.dart';
import 'package:lab_movil_2222/thanks-videos/services/load-thanks-video.service.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/services/connectivity-check.service.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/services/show-user-guide.service.dart';
import 'package:provider/provider.dart';

import 'assets/video/services/upload-video.service.dart';
import 'cities/clubhouse/services/clubhouse.service.dart';
import 'cities/final-video/services/load-final-video.service.dart';
import 'cities/manual-video/services/load-manual-video.service.dart';
import 'cities/micro-meso-macro/services/load-micro-meso-macro.service.dart';
import 'cities/project-video/services/load-project-video.service.dart';
import 'cities/project/services/load-project-files.service.dart';
import 'cities/project/services/upload-project.service.dart';

class AppProvider extends MultiProvider {
  AppProvider({
    Key? key,
    required Widget child,
  }) : super(
          providers: [
            /// user services
            Provider(create: (_) => IsUserSignedInService()),
            Provider(create: (_) => SignOutService()),
            Provider(create: (ctx) => RegisterService()),
            Provider(create: (ctx) => LoginService()),
            Provider(create: (_) => ConnectivityCheckService()),

            /// player services
            Provider(create: (_) => CurrentPlayerService()),
            Provider(create: (_) => CurrentAudioProvider()),
            Provider(create: (_) => UploadImageService()),
            Provider(create: (_) => GetContributionExplanationService()),
            Provider(create: (_) => GetClubhouseExplanationService()),
            Provider(create: (_) => LoadMonsterService()),
            Provider(create: (_) => UploadFileService()),
            Provider(create: (_) => SearchPlayersService()),
            Provider(create: (_) => LoadPlayerService()),
            Provider(create: (_) => LoadPlayerScoreboardService()),
            Provider(create: (_) => WelcomeService()),
            Provider(create: (_) => LoadStartVideoService()),
            Provider(create: (_) => LoadTeamService()),
            Provider(create: (_) => GamificationExplanationService()),
            Provider(create: (_) => CitiesService()),
            Provider(create: (ctx) => CitiesMapPositionsService(ctx)),
            Provider(create: (ctx) => ListPlayerOfGroupService(ctx)),

            ///cities screens loaders
            Provider(create: (_) => LoadCityActivitiesService()),
            Provider(create: (_) => ShowUserGuideService()),
            Provider(create: (_) => LoadFinalVideoService()),
            Provider(create: (_) => LoadManualVideoService()),
            Provider(create: (_) => LoadThanksVideoService()),
            Provider(create: (_) => LoadMicroMesoMacroService()),
            Provider(create: (_) => LoadProjectVideoService()),
            Provider(create: (_) => LoadCityIntroductionService()),
            Provider(create: (_) => LoadProjectDtoService()),
            Provider(create: (_) => LoadCityIntroductoryVideoService()),
            Provider(create: (_) => LoadCityResourcesService()),
            Provider(create: (_) => LoadCityHistoryService()),
            Provider(create: (_) => LoadContentsScreenInformationService()),
            Provider(create: (_) => ArgumentIdeasService()),

            /// player services
            Provider(create: (ctx) => UpdateAvatarService(ctx)),

            /// contribution services
            Provider(create: (ctx) => ContributionActivityService(ctx)),

            /// clubhouse services
            Provider(create: (ctx) => LoadUserClubhouseService(ctx)),
            Provider(create: (ctx) => ClubhouseActivityService(ctx)),

            /// project services
            Provider(create: (ctx) => LoadProjectFiles(ctx)),

            Provider(create: (ctx) => MedalsService(ctx)),

            Provider(create: (ctx) => UploadProjectService(ctx)),

            /// chat services
            Provider(create: (ctx) => ListChatsService(ctx)),
            Provider(create: (ctx) => SendMessagesService(ctx)),
            Provider(create: (ctx) => CreatePersonalChatService(ctx)),
            Provider(create: (ctx) => GetChatService(ctx)),
            Provider(create: (ctx) => ListChatsFoldersService(ctx)),
            Provider(create: (ctx) => ListMessagesService(ctx)),
            Provider(create: (ctx) => DeleteMessageService(ctx)),

            /// video assets services
            ...[
              Provider(create: (_) => LoadBetterVideoService()),
              Provider(create: (_) => UploadVideoService()),
            ],
          ],

          /// main application
          child: child,
          key: key,
        );
}
