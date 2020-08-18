abstract class InteractChatEvent{

}

class LoadChat extends InteractChatEvent{
    final String selector;

  LoadChat(this.selector);

}