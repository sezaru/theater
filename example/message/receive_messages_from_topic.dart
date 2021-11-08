import 'package:theater/src/actor.dart';
import 'package:theater/src/dispatch.dart';

// Create first actor class
class FirstTestActor extends UntypedActor {
  // Override onStart method which will be executed at actor startup
  @override
  Future<void> onStart(UntypedActorContext context) async {
    // Send message to actor system topic with name 'test_topic'
    context.sendToTopic('test_topic', 'Hello, from first test actor!');
  }
}

// Create second actor class
class SecondTestActor extends UntypedActor {
  // Override onStart method which will be executed at actor startup
  @override
  Future<void> onStart(UntypedActorContext context) async {
    // Send message to actor system topic with name 'test_topic'
    context.sendToTopic('test_topic', 'Hello, from second test actor!');
  }
}

void main(List<String> arguments) async {
  // Create actor system
  var system = ActorSystem('test_system');

  // Initialize actor system before work with her
  await system.initialize();

  // Create handler to messages as String from topic with name 'test_topic'
  system.listenTopic<String>('test_topic', (message) async {
    print(message);
  });

  // Create top-level actor in actor system with name 'first_test_actor'
  await system.actorOf('first_test_actor', FirstTestActor());

  // Create top-level actor in actor system with name 'second_test_actor'
  await system.actorOf('second_test_actor', SecondTestActor());
}
