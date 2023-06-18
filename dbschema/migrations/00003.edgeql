CREATE MIGRATION m1nkbee7ztdoxaqz7c4g3r4pvg4v6cyzcpr2nq6wbefjdjl7ghmfpq
    ONTO m1kgz2lzi5nlkksb62qbasrauxzxmo75sw54mying5b7nxsss2rutq
{
  ALTER TYPE authentication::Account {
      CREATE CONSTRAINT std::exclusive ON ((.provider, .providerAccountId));
  };
};
