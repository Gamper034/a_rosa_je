import 'package:a_rosa_je/models/guard.dart';

enum GuardStatus { aVenir, enCours, termine, enAttente, defaultStatus }

class GuardService {
  static const List<String> monthNames = [
    'Janv.',
    'Fév.',
    'Mars',
    'Avr.',
    'Mai',
    'Juin',
    'Juil.',
    'août',
    'Sept.',
    'Oct.',
    'Nov.',
    'Déc.'
  ];

  static const List<String> fullMonthNames = [
    'Janvier',
    'Février',
    'Mars',
    'Avril',
    'Mai',
    'Juin',
    'Juillet.',
    'août',
    'Septembre',
    'Octobre',
    'Novembre',
    'Décembre'
  ];
  GuardStatus getStatus(Guard guard) {
    DateTime today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    DateTime startDate = DateTime(
        guard.startDate.year, guard.startDate.month, guard.startDate.day);
    DateTime endDate =
        DateTime(guard.endDate.year, guard.endDate.month, guard.endDate.day);
    if ((startDate.isBefore(today) || startDate.isAtSameMomentAs(today)) &&
        (endDate.isAfter(today) || endDate.isAtSameMomentAs(today))) {
      return GuardStatus.enCours;
    } else if (startDate.isAfter(today)) {
      if (guard.applicants!.length > 0) {
        return GuardStatus.enAttente;
      } else {
        return GuardStatus.aVenir;
      }
    } else if (endDate.isBefore(today)) {
      return GuardStatus.termine;
    }
    return GuardStatus.defaultStatus;
  }
}
