import 'package:mobile/core/models/Message.dart';
import 'package:mobile/core/models/TimeCustom.dart';

final List<Message> listMessages = [
  Message(
      id: 0,
      text: "Hello, I’m Phonic Phil!",
      starttime: Time.fromString("00:00:03.452"),
      endtime: Time.fromString("00:00:06.203"),
      character: "Phil",
      type: TYPE.ONE_HUMAN),
  Message(
      id: 1,
      text: "… and I’m Super Sue!",
      starttime: Time.fromString("00:00:06.686"),
      endtime: Time.fromString("00:00:06.686"),
      character: "Sue",
      type: TYPE.TWO_HUMAN),
  Message(
      id: 2,
      text: "Grandmother, I’ve got a toothache.",
      starttime: Time.fromString("00:00:12.909"),
      endtime: Time.fromString("00:00:16.953"),
      character: "girl1",
      type: TYPE.ONE_HUMAN),
  Message(
      id: 3,
      text: "And I’ve got a sore thumb",
      starttime: Time.fromString("00:00:17.866"),
      endtime: Time.fromString("00:00:20.332"),
      character: "boy",
      type: TYPE.TWO_HUMAN),
  Message(
      id: 4,
      text: "Oh dear...",
      starttime: Time.fromString("00:00:21.154"),
      endtime: Time.fromString("00:00:22.980"),
      character: "ba",
      type: TYPE.ONE_HUMAN),
  Message(
      id: 5,
      text: "Is it a plane?",
      starttime: Time.fromString("00:00:28.953"),
      endtime: Time.fromString("00:00:30.580"),
      character: "boy",
      type: TYPE.TWO_HUMAN),
  Message(
      id: 6,
      text: "Is it a kite?",
      starttime: Time.fromString("00:00:31.347"),
      endtime: Time.fromString("00:00:32.991"),
      character: "girl1",
      type: TYPE.ONE_HUMAN),
  Message(
      id: 7,
      text: "No It’s Phil and Sue!",
      starttime: Time.fromString("00:00:34.180"),
      endtime: Time.fromString("00:00:37.500"),
      character: "boy",
      type: TYPE.TWO_HUMAN),
  Message(
      id: 8,
      text: "What’s the matter, Grandmother?",
      starttime: Time.fromString("00:00:45.928"),
      endtime: Time.fromString("00:00:48.391"),
      character: "Sue",
      type: TYPE.ONE_HUMAN),
  Message(
      id: 9,
      text: "She has a toothache, and he has a sore thumb.",
      starttime: Time.fromString("00:00:49.214"),
      endtime: Time.fromString("00:00:55.531"),
      character: "ba",
      type: TYPE.TWO_HUMAN),
  Message(
      id: 10,
      text: "Let’s go!",
      starttime: Time.fromString("00:01:02.147"),
      endtime: Time.fromString("00:01:04.785"),
      character: "Sue",
      type: TYPE.ONE_HUMAN),
  Message(
      id: 11,
      text: "To the hospital!",
      starttime: Time.fromString("00:01:05.052"),
      endtime: Time.fromString("00:01:05.052"),
      character: "Phil",
      type: TYPE.TWO_HUMAN),
  Message(
      id: 12,
      text: "Thank you, Phil and Sue!",
      starttime: Time.fromString("00:01:08.85"),
      endtime: Time.fromString("00:01:12.080"),
      character: "ba",
      type: TYPE.ONE_HUMAN),
];