class OnBoardingState {
  final bool isStoragePermissionAllowed;
  final bool isWhatsappPermissionAllowed;
  final bool isWhatsappBznsPermissionAllowed;

  OnBoardingState({
    this.isStoragePermissionAllowed = false,
    this.isWhatsappPermissionAllowed = false,
    this.isWhatsappBznsPermissionAllowed = false,
  });

  OnBoardingState copyWith({
    bool? isStoragePermissionAllowed,
    bool? isWhatsappPermissionAllowed,
    bool? isWhatsappBznsPermissionAllowed,
  }) {
    return OnBoardingState(
      isStoragePermissionAllowed:
          isStoragePermissionAllowed ?? this.isStoragePermissionAllowed,
      isWhatsappPermissionAllowed:
          isWhatsappPermissionAllowed ?? this.isWhatsappBznsPermissionAllowed,
      isWhatsappBznsPermissionAllowed: isWhatsappBznsPermissionAllowed ??
          this.isWhatsappBznsPermissionAllowed,
    );
  }
}
