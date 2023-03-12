
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:meeting_mate/methods/auth_methods.dart';
import 'package:meeting_mate/methods/firestore_methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
    try {
      // FeatureFlag featureFlag = FeatureFlag();
      // featureFlag.welcomePageEnabled = false;
      // featureFlag.resolution = FeatureFlagVideoResolution
      //     .MD_RESOLUTION; // Limit video resolution to 360p
      String name;
      if (username.isEmpty) {
        name = _authMethods.user.displayName!;
      } else {
        name = username;
      }
      var options = JitsiMeetingOptions(roomNameOrUrl: roomName,
          userDisplayName : name,
          userEmail : _authMethods.user.email,
          userAvatarUrl : _authMethods.user.photoURL,
           isAudioMuted : isAudioMuted,
           isVideoMuted : isVideoMuted
      );


      _firestoreMethods.addToMeetingHistory(roomName);
      await JitsiMeetWrapper.joinMeeting( options: options);
    } catch (error) {
      print("error: $error");
    }
  }
}
