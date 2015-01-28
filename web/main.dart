import 'dart:html';
import 'dart:typed_data';

bool canSend;
WebSocket ws;

void main() {
  canSend = false;
  ws = new WebSocket('ws://localhost:8080/sock');
  ws.onOpen.first.then((e) => canSend = true);
  ws.onMessage.listen((MessageEvent m) => print(m.data));
  querySelector('#output').text = 'Dart is running.';

  loop(window.performance.now());
}

loop(double time) {
  window.requestAnimationFrame(loop);
  if (canSend) {
    var ab = new Uint64List(1);
    ab[0] = 8;
    ws.send(ab);
  }
}
