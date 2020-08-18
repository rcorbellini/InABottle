abstract class InteractEvent{

}

class InteractLoadChat extends InteractEvent{
    final String selector;

  InteractLoadChat(this.selector);

}