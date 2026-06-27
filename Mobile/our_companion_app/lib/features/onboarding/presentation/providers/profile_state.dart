class ProfileState {
  final String name;

  final String gender;

  final bool showCompanion;

  final bool showSkilled;

  final List<String> selectedCategories;

  final bool isLoading;

  const ProfileState({
    this.name = '',
    this.gender = '',
    this.showCompanion = true,
    this.showSkilled = false,
    this.selectedCategories = const [],
    this.isLoading = false,
  });

  ProfileState copyWith({
    String? name,
    String? gender,
    bool? showCompanion,
    bool? showSkilled,
    List<String>? selectedCategories,
    bool? isLoading,
  }) {
    return ProfileState(
      name: name ?? this.name,
      gender: gender ?? this.gender,
      showCompanion: showCompanion ?? this.showCompanion,
      showSkilled: showSkilled ?? this.showSkilled,
      selectedCategories:
          selectedCategories ??
          this.selectedCategories,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}