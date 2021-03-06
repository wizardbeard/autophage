-module(autophage_user, [Id, Email, Username, Password]).
-compile(export_all).

-define(SETEC_ASTRONOMY, "6664e2e1dae84fb4a6213b0f467d8134").

session_identifier() ->
  mochihex:to_hex(erlang:md5(?SETEC_ASTRONOMY ++ Id)).

check_password(PasswordAttempt) ->
  %Password =:=  bcrypt:hashpw(PasswordAttempt, Password).
  StoredPassword = erlang:binary_to_list(Password),
  user_lib:compare_password(PasswordAttempt, StoredPassword).

login_cookies() ->
  [
    mochiweb_cookies:cookie("autophage_user_id", Id, [{path, "/"}]),
    mochiweb_cookies:cookie("session_id", session_identifier(), [{path, "/"}])
  ].
