import "package:rxdart/rxdart.dart";

class Bloc {

  BehaviorSubject<double> _probability = BehaviorSubject<double>();


  Observable<double> get probability => _probability.stream;

  Function(double) get probabilitySink => _probability.sink.add;

  void dispose() {

    _probability.close();

  }
}