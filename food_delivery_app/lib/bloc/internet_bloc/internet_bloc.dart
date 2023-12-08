import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'internet_bloc_event.dart';
part 'internet_bloc_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _connectivitySubscription;

  InternetBloc() : super(InternetGainedState()) {
    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));
    on<InternetGainedEvent>((event, emit) => emit(InternetGainedState()));

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        add(InternetLostEvent());
      } else if (event != ConnectivityResult.none) {
        add(InternetGainedEvent());
      }
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
