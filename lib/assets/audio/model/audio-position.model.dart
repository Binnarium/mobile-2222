class AudioPositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  AudioPositionData({
    required this.position,
    required this.bufferedPosition,
    required this.duration,
  });
  AudioPositionData.zero()
      : this.position = Duration.zero,
        this.bufferedPosition = Duration.zero,
        this.duration = Duration.zero;
}
