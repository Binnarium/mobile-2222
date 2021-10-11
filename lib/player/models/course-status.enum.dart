enum CourseStatus {
  /// when a course status has not been defined
  notDefined,

  ///
  notStarted,

  ///
  inProgress,

  ///
  continueNextPhase,

  ///
  canNotContinueNextPhase,

  /// not implemented yet
  notImplemented,
}

CourseStatus courseStatusFromString(String? value) {
  const Map<String?, CourseStatus> _statusMap = {
    null: CourseStatus.notDefined,
    'COURSE#NOT_STARTED': CourseStatus.notStarted,
    'COURSE#IN_PROGRESS': CourseStatus.inProgress,
    'COURSE#CONTINUE_NEXT_PHASE': CourseStatus.continueNextPhase,
    'COURSE#CAN_NOT_CONTINUE_NEXT_PHASE': CourseStatus.canNotContinueNextPhase,
  };
  final CourseStatus status = _statusMap[value] ?? CourseStatus.notImplemented;
  return status;
}
