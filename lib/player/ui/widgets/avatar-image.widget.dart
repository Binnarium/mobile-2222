import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/asset.dto.dart';

class AvatarImage extends StatelessWidget {
  /// constructor
  const AvatarImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  /// Participant
  final ImageDto? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(),
      child: SizedBox(
        height: 150,
        child: (image == null || image!.url.isEmpty == true)
            ? const CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/backgrounds/decorations/elipse_profile.png'),
                maxRadius: 40,
              )
            : CircleAvatar(
                backgroundImage: NetworkImage(
                  image!.url,
                ),
                maxRadius: 40,
              ),
      ),
    );
  }
}
