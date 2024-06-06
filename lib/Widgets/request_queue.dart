import 'dart:async';
import 'dart:math';
import 'dart:collection';

class RequestQueue {
  final Duration initialDelay;
  final Duration maxDelay;
  final int maxRetries;

  final Queue<_RequestEntry> _queue = Queue();
  Timer? _timer;
  Duration _currentDelay;

  RequestQueue({
    this.initialDelay = const Duration(seconds: 1),
    this.maxDelay = const Duration(minutes: 1),
    this.maxRetries = 5,
  }) : _currentDelay = initialDelay;

  Future<T> enqueue<T>(Future<T> Function() request) {
    final completer = Completer<T>();
    _queue.add(_RequestEntry(request, completer));
    _processQueue();
    return completer.future;
  }

  void _processQueue() {
    if (_timer != null || _queue.isEmpty) return;

    final entry = _queue.removeFirst();
    _timer = Timer(_currentDelay, () async {
      try {
        final result = await entry.request();
        entry.completer.complete(result);
        _currentDelay = initialDelay;
      } catch (e) {
        if (entry.retries < maxRetries) {
          entry.retries++;
          _currentDelay = _currentDelay * 2;
          if (_currentDelay > maxDelay) _currentDelay = maxDelay;
          _queue.addFirst(entry);
        } else {
          entry.completer.completeError(e);
        }
      } finally {
        _timer = null;
        _processQueue();
      }
    });
  }
}

class _RequestEntry<T> {
  final Future<T> Function() request;
  final Completer<T> completer;
  int retries = 0;

  _RequestEntry(this.request, this.completer);
}
