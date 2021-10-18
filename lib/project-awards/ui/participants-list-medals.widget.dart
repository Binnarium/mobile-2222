import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/models/coinsImages.model.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class AssignMedalListItem extends ListTile {
  AssignMedalListItem({
    Key? key,
    required Function callback,
    required PlayerModel participant,
    required BuildContext context,
    required bool isAssigned,
    required bool canAssign,
  }) : super(
          key: key,
          contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.08,
          ),
          title: Text(
            participant.displayName,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Colors2222.white,
                ),
          ),

          /// add button when callback is sended
          trailing: IconButton(
            onPressed: () {
              if (canAssign) {
                showDialog<Widget>(
                    context: context,
                    builder: (BuildContext context) {
                      final TextTheme textTheme = Theme.of(context).textTheme;
                      return AlertDialog(
                        backgroundColor: Colors2222.backgroundBottomBar,
                        title: const Text('Otorgarás una medalla a:'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              participant.displayName,
                              style: textTheme.bodyText2!,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                                'Esta acción no se puede deshacer.\n¿Estás seguro?'),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      callback();
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Sí',
                                      style: textTheme.headline6
                                          ?.apply(color: Colors.blue),
                                    )),
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      'No',
                                      style: textTheme.headline6
                                          ?.apply(color: Colors.blue),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              }
            },
            icon: Image(
              image: isAssigned
                  ? const MedalImage.marathon()
                  : const MedalImage.marathonGrey(),
            ),
          ),
        );
}
