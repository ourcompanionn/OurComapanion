import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'profile_state.dart';

final profileProvider =
    NotifierProvider<ProfileNotifier, ProfileState>(
  ProfileNotifier.new,
);

class ProfileNotifier extends Notifier<ProfileState> {
  @override
  ProfileState build() {
    return const ProfileState();
  }

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setGender(String gender) {
    state = state.copyWith(gender: gender);
  }

  void toggleCompanion() {
    state = state.copyWith(
      showCompanion: !state.showCompanion,
    );
  }

  void toggleSkilled() {
    state = state.copyWith(
      showSkilled: !state.showSkilled,
    );
  }

  void toggleCategory(String category) {
    final list = List<String>.from(state.selectedCategories);

    if (list.contains(category)) {
      list.remove(category);
    } else {
      list.add(category);
    }

    state = state.copyWith(
      selectedCategories: list,
    );
  }

  void completeSignup(
    void Function(String message) onSuccess,
  ) {
    state = state.copyWith(
      isLoading: true,
    );

    Future.delayed(
      const Duration(milliseconds: 800),
      () {
        state = state.copyWith(
          isLoading: false,
        );

        onSuccess(
          "Profile setup completed successfully!",
        );
      },
    );
  }
}