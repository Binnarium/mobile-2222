// ignore: file_names
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/audio/services/current-audio.provider.dart';
import 'package:lab_movil_2222/assets/image/services/upload-image.service.dart';
import 'package:lab_movil_2222/assets/video/services/current-video.provider.dart';
import 'package:lab_movil_2222/chat/services/create-personal-chats.service.dart';
import 'package:lab_movil_2222/chat/services/get-chat.service.dart';
import 'package:lab_movil_2222/chat/services/list-messages.service.dart';
import 'package:lab_movil_2222/chat/services/list-player-chats.service.dart';
import 'package:lab_movil_2222/chat/services/send-message.service.dart';
import 'package:lab_movil_2222/cities/activity/services/load-activity.service.dart';
import 'package:lab_movil_2222/cities/argument-ideas/services/arguments-ideas.service.dart';
import 'package:lab_movil_2222/cities/clubhouse/services/get-clubhouse-explanation.service.dart';
import 'package:lab_movil_2222/cities/clubhouse/services/load-user-clubhouse.service.dart';
import 'package:lab_movil_2222/cities/contribution/services/contribution-activity.service.dart';
import 'package:lab_movil_2222/cities/contribution/services/get-contribution-explanation.service.dart';
import 'package:lab_movil_2222/cities/monster/services/load-monster.service.dart';
import 'package:lab_movil_2222/cities/project/services/upload-file.service.dart';
import 'package:lab_movil_2222/cities/project/services/upload-maraton-medal.service.dart';
import 'package:lab_movil_2222/city/services/cities.service.dart';
import 'package:lab_movil_2222/city/services/load-cities-with-map-position.service.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:lab_movil_2222/player/services/list-players-of-group.service.dart';
import 'package:lab_movil_2222/player/services/search-players.service.dart';
import 'package:lab_movil_2222/player/services/update-avatar.service.dart';
import 'package:lab_movil_2222/points-explanation/services/get-points-explanation.service.dart';
import 'package:lab_movil_2222/services/load-city-history.service.dart';
import 'package:lab_movil_2222/services/load-city-introduction.service.dart';
import 'package:lab_movil_2222/services/load-city-introductory-video.service.dart';
import 'package:lab_movil_2222/services/load-city-resources.service.dart';
import 'package:lab_movil_2222/services/load-contents-screen-information.service.dart';
import 'package:lab_movil_2222/services/load-login-information.service.dart';
import 'package:lab_movil_2222/services/load-player-information.service.dart';
import 'package:lab_movil_2222/services/load-project-activity.service.dart';
import 'package:lab_movil_2222/start-video/services/load-start-video.service.dart';
import 'package:lab_movil_2222/team/services/load-team.service.dart';
import 'package:lab_movil_2222/user/services/login-user.service.dart';
import 'package:lab_movil_2222/user/services/register-user.service.dart';
import 'package:lab_movil_2222/user/services/sign-out.service.dart';
import 'package:lab_movil_2222/user/services/user.service.dart';
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
            Provider(create: (_) => IsUserSignInService()),
            Provider(create: (ctx) => SignOutService(ctx)),
            Provider(create: (ctx) => RegisterService(ctx)),
            Provider(create: (ctx) => LoginService(ctx)),

            /// player services
            Provider(create: (ctx) => CurrentPlayerService(ctx)),
            Provider(create: (_) => CurrentAudioProvider()),
            Provider(create: (_) => CurrentVideoProvider()),
            Provider(create: (_) => UploadImageService()),
            Provider(create: (_) => UploadVideoService()),
            Provider(create: (_) => GetContributionExplanationService()),
            Provider(create: (_) => GetClubhouseExplanationService()),
            Provider(create: (_) => LoadMonsterService()),
            Provider(create: (_) => UploadFileService()),
            Provider(create: (_) => SearchPlayersService()),
            Provider(create: (_) => LoadPlayerService()),
            Provider(create: (_) => WelcomeService()),
            Provider(create: (_) => LoadStartVideoService()),
            Provider(create: (_) => LoadTeamService()),
            Provider(create: (_) => GetPointsExplanationService()),
            Provider(create: (_) => CitiesService()),
            Provider(create: (ctx) => CitiesMapPositionsService(ctx)),
            Provider(create: (ctx) => ListPlayerOfGroupService(ctx)),

            ///cities screens loaders
            Provider(create: (_) => LoadCityActivitiesService()),
            Provider(create: (_) => LoadFinalVideoService()),
            Provider(create: (_) => LoadManualVideoService()),
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

            Provider(create: (ctx) => UploadMaratonMedalService(ctx)),

            Provider(create: (ctx) => UploadProjectService(ctx)),


            /// chat services
            Provider(create: (ctx) => SendMessagesService(ctx)),
            Provider(create: (ctx) => CreatePersonalChatService(ctx)),
            Provider(create: (ctx) => GetChatService(ctx)),
            Provider(create: (ctx) => ListPlayerChatsService(ctx)),
            Provider(create: (ctx) => ListMessagesService(ctx)),
          ],

          /// main application
          child: child,
          key: key,
        );
}
