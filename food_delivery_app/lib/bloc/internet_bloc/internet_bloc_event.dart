part of 'internet_bloc.dart';

abstract class InternetEvent{}

class InternetInitialEvent extends InternetEvent{}
class InternetLostEvent extends InternetEvent{}
class InternetGainedEvent extends InternetEvent{}