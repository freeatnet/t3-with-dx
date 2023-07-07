with module authentication
insert Account {
  type := <str>$type,
  provider := <str>$provider,
  providerAccountId := <str>$providerAccountId,

  access_token := <optional str>$access_token,
  refresh_token := <optional str>$refresh_token,
  expires_at := <optional int64>$expires_at,
  token_type := <optional str>$token_type,
  scope := <optional str>$scope,
  id_token := <optional str>$id_token,

  session_state := <optional str>$session_state,

  user := (select User filter .id = <uuid>$userId)
}
