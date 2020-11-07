import 'dart:async';

typedef Future DebounceCallback();

class Debounce {
  Duration duration;
  Timer timer;
  DebounceCallback callbackCancel;

  Debounce(this.duration);

  cancel() {
    if (timer != null) {
      timer.cancel();
    }
    if (this.callbackCancel != null) {
      this.callbackCancel();
      this.callbackCancel = null;
    }
    return this;
  }

  onCancel(DebounceCallback callback) {
    this.callbackCancel = callback;
    return this;
  }

  run(DebounceCallback callback) {
    if (timer != null) {
      timer.cancel();
    }
    timer = new Timer(duration, () {
      callback().then((value) {
        this.callbackCancel = null;
      }).catchError((error) {
        this.cancel();
      });
    });
    return this;
  }
}
