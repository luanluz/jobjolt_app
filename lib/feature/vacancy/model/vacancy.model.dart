import 'package:easy_localization/easy_localization.dart';

class Vacancy {
  int? id;
  String? position;
  String? positionSpecification;
  double? salary;
  String? observation;
  WorkShiftEnum? workShift;
  EmploymentTypeEnum? employmentType;
  bool? isRemote;
  String? city;
  String? state;

  Vacancy({
    this.id,
    this.position,
    this.positionSpecification,
    this.salary,
    this.observation,
    this.workShift,
    this.employmentType,
    this.isRemote,
    this.city,
    this.state,
  });

  factory Vacancy.fromJson(Map<String, dynamic> json) {
    return Vacancy(
      id: json['id'],
      position: json['position'],
      positionSpecification: json['positionSpecification'],
      salary: json['salary'],
      observation: json['observation'],
      workShift: WorkShiftEnum.parseWorkShift(json['workShift']),
      employmentType: EmploymentTypeEnum.parseEmploymentType(json['employmentType']),
      isRemote: json['isRemote'],
      city: json['city'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'position': position,
      'positionSpecification': positionSpecification,
      'salary': salary,
      'observation': observation,
      'workShift': workShift?.name,
      'employmentType': employmentType?.name,
      'isRemote': isRemote,
      'city': city,
      'state': state,
    };
  }

  String get salaryFormatted =>
      NumberFormat.compactCurrency(locale: "pt_BR", decimalDigits: 2)
          .format(salary);
}

enum WorkShiftEnum {
  morning,
  afternoon,
  evening,
  night,
  flexible;

  String get desc {
    switch (this) {
      case WorkShiftEnum.morning:
        return 'Manhã';
      case WorkShiftEnum.afternoon:
        return 'Tarde';
      case WorkShiftEnum.evening:
        return 'A tardinha';
      case WorkShiftEnum.night:
        return 'Noite';
      case WorkShiftEnum.flexible:
        return 'Flexível';
    }
  }

  String get name {
    switch (this) {
      case WorkShiftEnum.morning:
        return 'morning';
      case WorkShiftEnum.afternoon:
        return 'afternoon';
      case WorkShiftEnum.evening:
        return 'evening';
      case WorkShiftEnum.night:
        return 'night';
      case WorkShiftEnum.flexible:
        return 'flexible';
    }
  }

  static WorkShiftEnum? parseWorkShift(String input) {
    switch (input) {
      case 'morning':
        return WorkShiftEnum.morning;
      case 'afternoon':
        return WorkShiftEnum.afternoon;
      case 'evening':
        return WorkShiftEnum.evening;
      case 'night':
        return WorkShiftEnum.night;
      case 'flexible':
        return WorkShiftEnum.flexible;
      default:
        return null;
    }
  }

  static bool isWorkShiftValid(String input) {
    return parseWorkShift(input) != null;
  }
}

enum EmploymentTypeEnum {
  clt,
  pj,
  internship,
  temporary,
  partTime,
  fullTime,
  freelance,
  other;

  String get desc {
    switch (this) {
      case EmploymentTypeEnum.clt:
        return 'CLT';
      case EmploymentTypeEnum.pj:
        return 'PJ';
      case EmploymentTypeEnum.internship:
        return 'Estágio';
      case EmploymentTypeEnum.temporary:
        return 'Temporário';
      case EmploymentTypeEnum.partTime:
        return 'Meio Turno';
      case EmploymentTypeEnum.fullTime:
        return 'Tempo Integral';
      case EmploymentTypeEnum.freelance:
        return 'Freelance';
      case EmploymentTypeEnum.other:
        return 'Outro';
    }
  }

  String get name {
    switch (this) {
      case EmploymentTypeEnum.clt:
        return 'clt';
      case EmploymentTypeEnum.pj:
        return 'pj';
      case EmploymentTypeEnum.internship:
        return 'internship';
      case EmploymentTypeEnum.temporary:
        return 'temporary';
      case EmploymentTypeEnum.partTime:
        return 'partTime';
      case EmploymentTypeEnum.fullTime:
        return 'fullTime';
      case EmploymentTypeEnum.freelance:
        return 'freelance';
      case EmploymentTypeEnum.other:
        return 'other';
    }
  }

  static EmploymentTypeEnum? parseEmploymentType(String input) {
    switch (input) {
      case 'clt':
        return EmploymentTypeEnum.clt;
      case 'pj':
        return EmploymentTypeEnum.pj;
      case 'internship':
        return EmploymentTypeEnum.internship;
      case 'temporary':
        return EmploymentTypeEnum.temporary;
      case 'partTime':
        return EmploymentTypeEnum.partTime;
      case 'fullTime':
        return EmploymentTypeEnum.fullTime;
      case 'freelance':
        return EmploymentTypeEnum.freelance;
      case 'other':
        return EmploymentTypeEnum.other;
      default:
        return null;
    }
  }

  static bool isEmploymentTypeValid(String input) {
    return parseEmploymentType(input) != null;
  }
}
