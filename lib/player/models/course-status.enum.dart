enum CourseStatus {
  /// when a course status has not been defined
  notDefined,

  ///
  notStarted,

  ///
  inProgress,

  ///
  approvedContinueNextPhaseWithContentAccess,

  ///
  approvedCanContinueNextPhaseNoContentAccess,

  ///
  approvedCanNotContinueNextPhase,

  ///
  notApproved,

  /// not implemented yet
  notImplemented,
}

CourseStatus courseStatusFromString(String? value) {
  const Map<String?, CourseStatus> _statusMap = {
    null: CourseStatus.notDefined,
    'COURSE#NOT_STARTED': CourseStatus.notStarted,
    'COURSE#IN_PROGRESS': CourseStatus.inProgress,
    'COURSE#APPROVE_CONTINUE_NEXT_PHASE_HAS_CONTENT_ACCESS':
        CourseStatus.approvedContinueNextPhaseWithContentAccess,
    'COURSE#APPROVE_CONTINUE_NEXT_PHASE_HAS_NO_CONTENT_ACCESS':
        CourseStatus.approvedCanContinueNextPhaseNoContentAccess,
    'COURSE#APPROVE_CAN_NOT_CONTINUE_NEXT_PHASE':
        CourseStatus.approvedCanNotContinueNextPhase,
    'COURSE#NOT_APPROVED': CourseStatus.notApproved,
  };
  final CourseStatus status = _statusMap[value] ?? CourseStatus.notImplemented;
  return status;
}
