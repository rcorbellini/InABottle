import 'package:in_a_bottle/features/treasure_hunt/domain/models/locked_feature.dart';
import 'package:in_a_bottle/features/treasure_hunt/domain/models/position.dart';

class TreasureHunt {
  final String id;
  final String title;
  final String description;
  final Position startPoint;
  final List<TreasureHuntStep> steps;
  final String tipToFirstStep;
  final int maxWinners;
  final DateTime startDate;
  final DateTime endDate;
  final String userCreateId;
  final String state;
  final int? amountOfPoints;
  final List<ConfigReward>? especificRewards;
  final List<String>? commonRewardsId;
  final LockedFeature? lockedFeature;

//<editor-fold desc="Data Methods" defaultstate="collapsed">
  const TreasureHunt({
    required this.id,
    required this.title,
    required this.description,
    required this.startPoint,
    required this.steps,
    required this.tipToFirstStep,
    required this.maxWinners,
    required this.startDate,
    required this.endDate,
    required this.userCreateId,
    required this.state,
    this.amountOfPoints,
    this.especificRewards,
    this.commonRewardsId,
    this.lockedFeature,
  });

  TreasureHunt copyWith({
    String? id,
    String? title,
    String? description,
    Position? startPoint,
    List<TreasureHuntStep>? steps,
    String? tipToFirstStep,
    int? maxWinners,
    DateTime? startDate,
    DateTime? endDate,
    String? userCreateId,
    String? state,
    int? amountOfPoints,
    List<ConfigReward>? especificRewards,
    List<String>? commonRewardsId,
    LockedFeature? lockedFeature,
  }) {
    return new TreasureHunt(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startPoint: startPoint ?? this.startPoint,
      steps: steps ?? this.steps,
      tipToFirstStep: tipToFirstStep ?? this.tipToFirstStep,
      maxWinners: maxWinners ?? this.maxWinners,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      userCreateId: userCreateId ?? this.userCreateId,
      state: state ?? this.state,
      amountOfPoints: amountOfPoints ?? this.amountOfPoints,
      especificRewards: especificRewards ?? this.especificRewards,
      commonRewardsId: commonRewardsId ?? this.commonRewardsId,
      lockedFeature: lockedFeature ?? this.lockedFeature,
    );
  }

  @override
  String toString() {
    return 'TreasureHunt{id: $id, title: $title, description: $description, '
        'startPoint: $startPoint, steps: $steps, tipToFirstStep: $tipToFirstStep,'
        ' maxWinners: $maxWinners, startDate: $startDate, endDate: $endDate, '
        'userCreateId: $userCreateId, state: $state, amountOfPoints: $amountOfPoints,'
        ' especificRewards: $especificRewards, commonRewardsId: $commonRewardsId, '
        'lockedFeature: $lockedFeature}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TreasureHunt &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          startPoint == other.startPoint &&
          steps == other.steps &&
          tipToFirstStep == other.tipToFirstStep &&
          maxWinners == other.maxWinners &&
          startDate == other.startDate &&
          endDate == other.endDate &&
          userCreateId == other.userCreateId &&
          state == other.state &&
          amountOfPoints == other.amountOfPoints &&
          especificRewards == other.especificRewards &&
          commonRewardsId == other.commonRewardsId &&
          lockedFeature == other.lockedFeature);

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      startPoint.hashCode ^
      steps.hashCode ^
      tipToFirstStep.hashCode ^
      maxWinners.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      userCreateId.hashCode ^
      state.hashCode ^
      amountOfPoints.hashCode ^
      especificRewards.hashCode ^
      commonRewardsId.hashCode ^
      lockedFeature.hashCode;

  factory TreasureHunt.fromMap(Map<String, dynamic> map) {
    return new TreasureHunt(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      startPoint: map['startPoint'] as Position,
      steps: map['steps'] as List<TreasureHuntStep>,
      tipToFirstStep: map['tipToFirstStep'] as String,
      maxWinners: map['maxWinners'] as int,
      startDate: map['startDate'] as DateTime,
      endDate: map['endDate'] as DateTime,
      userCreateId: map['userCreateId'] as String,
      state: map['state'] as String,
      amountOfPoints: map['amountOfPoints'] as int?,
      especificRewards: map['especificRewards'] as List<ConfigReward>?,
      commonRewardsId: map['commonRewardsId'] as List<String>?,
      lockedFeature: map['lockedFeature'] as LockedFeature?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'startPoint': this.startPoint,
      'steps': this.steps,
      'tipToFirstStep': this.tipToFirstStep,
      'maxWinners': this.maxWinners,
      'startDate': this.startDate,
      'endDate': this.endDate,
      'userCreateId': this.userCreateId,
      'state': this.state,
      'amountOfPoints': this.amountOfPoints,
      'especificRewards': this.especificRewards,
      'commonRewardsId': this.commonRewardsId,
      'lockedFeature': this.lockedFeature,
    };
  }

//</editor-fold>

}

class TreasureHuntStep {
  final String id;
  final String title;
  final LockedFeature? lockedFeature;
  final Position position;
  final String tipToNextStep;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const TreasureHuntStep({
    required this.id,
    required this.title,
    this.lockedFeature,
    required this.position,
    required this.tipToNextStep,
  });

  TreasureHuntStep copyWith({
    String? id,
    String? title,
    LockedFeature? lockedFeature,
    Position? position,
    String? tipToNextStep,
  }) {

    return new TreasureHuntStep(
      id: id ?? this.id,
      title: title ?? this.title,
      lockedFeature: lockedFeature ?? this.lockedFeature,
      position: position ?? this.position,
      tipToNextStep: tipToNextStep ?? this.tipToNextStep,
    );
  }

  @override
  String toString() {
    return 'TreasureHuntStep{id: $id, title: $title, lockedFeature: $lockedFeature, position: $position, tipToNextStep: $tipToNextStep}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TreasureHuntStep &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          lockedFeature == other.lockedFeature &&
          position == other.position &&
          tipToNextStep == other.tipToNextStep);

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      lockedFeature.hashCode ^
      position.hashCode ^
      tipToNextStep.hashCode;

  factory TreasureHuntStep.fromMap(Map<String, dynamic> map) {
    return new TreasureHuntStep(
      id: map['id'] as String,
      title: map['title'] as String,
      lockedFeature: map['lockedFeature'] as LockedFeature,
      position: map['position'] as Position,
      tipToNextStep: map['tipToNextStep'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'lockedFeature': this.lockedFeature,
      'position': this.position,
      'tipToNextStep': this.tipToNextStep,
    } ;
  }

//</editor-fold>

}

class ConfigReward {
  int position;
  List<String> idsRewards;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  ConfigReward({
    required this.position,
    required this.idsRewards,
  });

  ConfigReward copyWith({
    int? position,
    List<String>? idsRewards,
  }) {
    return new ConfigReward(
      position: position ?? this.position,
      idsRewards: idsRewards ?? this.idsRewards,
    );
  }

  @override
  String toString() {
    return 'ConfigReward{position: $position, idsRewards: $idsRewards}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConfigReward &&
          runtimeType == other.runtimeType &&
          position == other.position &&
          idsRewards == other.idsRewards);

  @override
  int get hashCode => position.hashCode ^ idsRewards.hashCode;

  factory ConfigReward.fromMap(Map<String, dynamic> map) {
    return new ConfigReward(
      position: map['position'] as int,
      idsRewards: map['idsRewards'] as List<String>,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'position': this.position,
      'idsRewards': this.idsRewards,
    };
  }

//</editor-fold>

}
