import 'package:bloc/bloc.dart';

abstract class CounterStates {}

class CounterInitialState extends CounterStates {}

class CounterMinusState extends CounterStates {}

class CounterPlusState extends CounterStates {}
