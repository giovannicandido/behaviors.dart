part of behaviors;

class Movable extends Behavior {
  List<StreamSubscription> _subscriptions;
  bool _dragging = false;
  Point _offset;

  Movable(Element element) : super(element) {
  
    var parent = element.offsetParent;

    _subscriptions = [
      element.onMouseDown.listen((event) {
        _dragging = true;
        _offset = element.offset.topLeft - event.client;
        element.classes.add('moving');
      }),
      parent.onMouseUp.listen((event) {
        _dragging = false;
        element.classes.remove('moving');
      }),
      parent.onMouseMove.listen((MouseEvent event) {
        if (_dragging) {
          element.style.left = '${event.client.x + _offset.x}px';
          element.style.top = '${event.client.y + _offset.y}px';
        }
      })];
  }

  detach() {
    _subscriptions.forEach((s) => s.cancel());
    _subscriptions.clear();
    super.detach();
  }
}