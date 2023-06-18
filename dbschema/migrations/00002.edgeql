CREATE MIGRATION m1kgz2lzi5nlkksb62qbasrauxzxmo75sw54mying5b7nxsss2rutq
    ONTO m1fwhuifffbua6vxg56dydttv7r4csid6flgg3z4zg4vvhii3s4vya
{
  ALTER TYPE authentication::User {
      CREATE LINK accounts := (.<user[IS authentication::Account]);
  };
};
