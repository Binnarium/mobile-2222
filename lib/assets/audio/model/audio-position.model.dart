class AudioPositionData {
  AudioPositionData({
    required this.position,
    required this.bufferedPosition,
    required this.duration,
  });

  AudioPositionData.zero()
      : position = Duration.zero,
        bufferedPosition = Duration.zero,
        duration = Duration.zero;

  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}
