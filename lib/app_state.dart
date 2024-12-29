sealed class AppState {
  const AppState();
}

class Input extends AppState {
  const Input() : super();
}

class Loading extends AppState {
  const Loading() : super();
}

class Data extends AppState {
  final String sentence;
  const Data(this.sentence);
}
