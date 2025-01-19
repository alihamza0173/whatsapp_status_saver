class OnBoardingState {
  final bool isStoragePermissionAllowed;
  final bool isWhatsappPermissionAllowed;
  final bool isWhatsappBusinessPermissionAllowed;

  OnBoardingState({
    this.isStoragePermissionAllowed = false,
    this.isWhatsappPermissionAllowed = false,
    this.isWhatsappBusinessPermissionAllowed = false,
  });

  OnBoardingState copyWith({
    bool? isStoragePermissionAllowed,
    bool? isWhatsappPermissionAllowed,
    bool? isWhatsappBusinessPermissionAllowed,
  }) {
    return OnBoardingState(
      isStoragePermissionAllowed:
          isStoragePermissionAllowed ?? this.isStoragePermissionAllowed,
      isWhatsappPermissionAllowed: isWhatsappPermissionAllowed ??
          this.isWhatsappBusinessPermissionAllowed,
      isWhatsappBusinessPermissionAllowed:
          isWhatsappBusinessPermissionAllowed ??
              this.isWhatsappBusinessPermissionAllowed,
    );
  }
}
