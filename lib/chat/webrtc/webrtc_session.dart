// import 'package:flutter_webrtc/flutter_webrtc.dart';
//
// class WebRtcSession {
//   WebRtcSession({required this.sid, required this.pid});
//
//   String pid;
//   String sid;
//   RTCPeerConnection pc;
//   RTCDataChannel dc;
//   List<RTCIceCandidate> remoteCandidates = [];
//   MediaStream _localStream;
//   List<MediaStream> _remoteStreams = <MediaStream>[];
//
//   Future<WebRtcSession> createSession(
//       {required WebRtcSession session,
//       required String peerId,
//       required String sessionId,
//       required String media,
//       required bool screenSharing}) async {
//     var newSession = session ?? WebRtcSession(sid: sessionId, pid: peerId);
//     if (media != 'data')
//       _localStream = await createStream(media, screenSharing);
//     print(_iceServers);
//     RTCPeerConnection pc = await createPeerConnection({
//       ..._iceServers,
//       ...{'sdpSemantics': sdpSemantics}
//     }, _config);
//     if (media != 'data') {
//       switch (sdpSemantics) {
//         case 'plan-b':
//           pc.onAddStream = (MediaStream stream) {
//             onAddRemoteStream?.call(newSession, stream);
//             _remoteStreams.add(stream);
//           };
//           await pc.addStream(_localStream);
//           break;
//         case 'unified-plan':
//           // Unified-Plan
//           pc.onTrack = (event) {
//             if (event.track.kind == 'video') {
//               onAddRemoteStream?.call(newSession, event.streams[0]);
//             }
//           };
//           _localStream.getTracks().forEach((track) {
//             pc.addTrack(track, _localStream);
//           });
//           break;
//       }
//
//       // Unified-Plan: Simuclast
//       /*
//       await pc.addTransceiver(
//         track: _localStream.getAudioTracks()[0],
//         init: RTCRtpTransceiverInit(
//             direction: TransceiverDirection.SendOnly, streams: [_localStream]),
//       );
//
//       await pc.addTransceiver(
//         track: _localStream.getVideoTracks()[0],
//         init: RTCRtpTransceiverInit(
//             direction: TransceiverDirection.SendOnly,
//             streams: [
//               _localStream
//             ],
//             sendEncodings: [
//               RTCRtpEncoding(rid: 'f', active: true),
//               RTCRtpEncoding(
//                 rid: 'h',
//                 active: true,
//                 scaleResolutionDownBy: 2.0,
//                 maxBitrate: 150000,
//               ),
//               RTCRtpEncoding(
//                 rid: 'q',
//                 active: true,
//                 scaleResolutionDownBy: 4.0,
//                 maxBitrate: 100000,
//               ),
//             ]),
//       );*/
//       /*
//         var sender = pc.getSenders().find(s => s.track.kind == "video");
//         var parameters = sender.getParameters();
//         if(!parameters)
//           parameters = {};
//         parameters.encodings = [
//           { rid: "h", active: true, maxBitrate: 900000 },
//           { rid: "m", active: true, maxBitrate: 300000, scaleResolutionDownBy: 2 },
//           { rid: "l", active: true, maxBitrate: 100000, scaleResolutionDownBy: 4 }
//         ];
//         sender.setParameters(parameters);
//       */
//     }
//     pc.onIceCandidate = (candidate) {
//       if (candidate == null) {
//         print('onIceCandidate: complete!');
//         return;
//       }
//       _send('candidate', {
//         'to': peerId,
//         'from': _selfId,
//         'candidate': {
//           'sdpMLineIndex': candidate.sdpMlineIndex,
//           'sdpMid': candidate.sdpMid,
//           'candidate': candidate.candidate,
//         },
//         'session_id': sessionId,
//       });
//     };
//
//     pc.onIceConnectionState = (state) {};
//
//     pc.onRemoveStream = (stream) {
//       onRemoveRemoteStream?.call(newSession, stream);
//       _remoteStreams.removeWhere((it) {
//         return (it.id == stream.id);
//       });
//     };
//
//     pc.onDataChannel = (channel) {
//       _addDataChannel(newSession, channel);
//     };
//
//     newSession.pc = pc;
//     return newSession;
//   }
// }
