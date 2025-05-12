
import 'abstract_auth_event.dart';

class LoginEvent extends AbstractAuthEvent {
  final String username;
  LoginEvent(this.username);
}
