// Tools View

import 'dart:convert';

extension Capitalise on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class Note {
  Note({
    required this.name,
    required this.date,
    required this.content,
    this.renderMath,
  });

  late String name;
  late DateTime date;
  late String content;
  late bool? renderMath;

  String get base64EncodedLink {
    return notesURLAccessor +
        base64Encode(utf8
            .encode("$name ␢␆␝⎠⎡⍰⎀ $content ␢␆␝⎠⎡⍰⎀ ${renderMath ?? true}"));
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date.toIso8601String(),
      'content': content,
      'renderMath': renderMath == true ? 1 : 0,
    };
  }

  factory Note.fromDeepLink(String link) {
    String encodedText = link.replaceAll(notesURLAccessor, "");
    String decodedData = utf8.decode(base64Decode(encodedText));
    List<String> data = decodedData.split(" ␢␆␝⎠⎡⍰⎀ ");

    return Note(
        name: data[0],
        content: data[1].replaceAll("~", "~~"),
        renderMath: data[2] == "true" ? true : false,
        date: DateTime.now());
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      name: map['name'],
      date: DateTime.parse(map['date']),
      content: map['content'],
      renderMath: map['renderMath'] == 1 ? true : false,
    );
  }
}

enum HCFLCM { hcf, lcm }

enum HCFOptions { primeNumberOnly }

enum Averages { mean, median, mode, standardDeviation }

enum RandomizerPages { recent, occurences }

enum SetEvalType { union, intersection }

class CheatsheetDetails {
  String title;
  SecondaryLevel secondaryLevel;
  bool isComingSoon;
  bool isStarred;

  CheatsheetDetails(
    this.title,
    this.secondaryLevel, [
    this.isComingSoon = false,
    this.isStarred = false,
  ]);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'secondaryLevel': secondaryLevel.toString(),
      'isComingSoon': isComingSoon ? 1 : 0,
      'isStarred': isStarred ? 1 : 0,
    };
  }

  factory CheatsheetDetails.fromMap(Map<String, dynamic> map) {
    return CheatsheetDetails(
      map['title'],
      _parseSecondaryLevel(map['secondaryLevel']),
      map['isComingSoon'] == 1,
      map['isStarred'] == 1,
    );
  }

  static SecondaryLevel _parseSecondaryLevel(String level) {
    switch (level) {
      case 'SecondaryLevel.one':
        return SecondaryLevel.one;
      case 'SecondaryLevel.two':
        return SecondaryLevel.two;
      case 'SecondaryLevel.three':
        return SecondaryLevel.three;
      case 'SecondaryLevel.four':
        return SecondaryLevel.four;
      default:
        throw ArgumentError('Invalid secondary level: $level');
    }
  }
}

enum SecondaryLevel { one, two, three, four }

const calculatorURLAccessor = "mathx:///calculator?source=";
const notesURLAccessor = "mathx:///notes?source=";
