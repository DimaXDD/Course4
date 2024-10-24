import 'Work.dart';

class TeamIterator implements Iterator<Work> {
  final List<Work> _teams;
  int _currentIndex = -1;

  TeamIterator(this._teams);

  @override
  Work get current => _teams[_currentIndex];

  @override
  bool moveNext() {
    _currentIndex++;
    return _currentIndex < _teams.length;
  }
}

class TeamCollection extends Iterable<Work> {
  final List<Work> _teams;

  TeamCollection(this._teams);

  @override
  Iterator<Work> get iterator => TeamIterator(_teams);
}


