abstract class InteractTalkEvent{

}

class LoadTalk extends InteractTalkEvent{
    final String selector;

  LoadTalk(this.selector);

}