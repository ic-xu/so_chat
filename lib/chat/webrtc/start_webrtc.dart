// import 'package:flutter_webrtc/flutter_webrtc.dart';
//
//
// class samp{
//
//   //本地流
//   RTCVideoRenderer _localRenderer = RTCVideoRenderer();
//
//   //远端流
//   RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
//
//
//   Future<void> _createOffer(Session session, String media) async {
//     try {
//       RTCSessionDescription s = await session.pc.createOffer(media == 'data' ? _dcConstraints : {});
//       await session.pc.setLocalDescription(s);
//       _send('offer', {
//         'to': session.pid,
//         'from': _selfId,
//         'description': {'sdp': s.sdp, 'type': s.type},
//         'session_id': session.sid,
//         'media': media,
//       });
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//
//   Future<MediaStream> createStream(String media, bool userScreen) async {
//     final Map<String, dynamic> mediaConstraints = {
//       'audio': true,
//       'video': {
//         'mandatory': {
//           'minWidth':
//           '640', // Provide your own width, height and frame rate here
//           'minHeight': '480',
//           'minFrameRate': '30',
//         },
//         'facingMode': 'user',
//         'optional': [],
//       }
//     };
//
//     MediaStream stream = userScreen
//         ? await navigator.mediaDevices.getDisplayMedia(mediaConstraints)
//         : await navigator.mediaDevices.getUserMedia(mediaConstraints);
//     onLocalStream?.call(null, stream);
//     return stream;
//   }
//
// }