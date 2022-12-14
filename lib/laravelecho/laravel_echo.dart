import 'package:laravel_echo/laravel_echo.dart';
import 'package:pusher_client/pusher_client.dart';

class LaravelEcho{
  static LaravelEcho? _singleton;
 static late Echo _echo;
 final String token;
 LaravelEcho._({
  required this.token
 }){
  _echo= createLaravelEcho(token);
 }

factory LaravelEcho.init({
  required String token,
}){
  if(_singleton==null || token!=_singleton?.token){
    _singleton=LaravelEcho._(token: token);
  }
  return _singleton!;
}

static Echo get instance=>_echo;
static String get socketId=>_echo.socketId()??'11111 11111111';
}


class PusherConfig{
  static const appId="1514600";
  static const key="025db15a3bf3466bf045";
  static const secret="a9836c072ba8fd7dd6c3";
  static const cluster="ap2";
  static const hostEndPoint="https://sc.cosmeticplugs.com";
  static const hostAuthEndPoint="$hostEndPoint/api/broadcasting/auth";
  static const port=443;
}
PusherClient createPusherClient(String token){
  PusherOptions options=PusherOptions(
    wsPort: PusherConfig.port,
    encrypted: true,
    host: PusherConfig.hostEndPoint,
    cluster: PusherConfig.cluster,
    auth: PusherAuth(PusherConfig.hostEndPoint,headers: {
      'Authorization':'Bearer $token',
      'Content-type':"application/json",
      'Accept':'application/json'
    })

  );
  PusherClient pusherClient= PusherClient(PusherConfig.key, options,autoConnect: false,enableLogging: true);
return pusherClient;
}
Echo createLaravelEcho(String token){
  return Echo(client: createPusherClient(token),
  broadcaster: EchoBroadcasterType.Pusher
  );

}