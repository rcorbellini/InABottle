abstract class InteractDirectMessageEvent{

}

class LoadDirectMessage extends InteractDirectMessageEvent{
    final String selector;

  LoadDirectMessage(this.selector);

}