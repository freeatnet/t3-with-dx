CREATE MIGRATION m1lrarqonlle7iwtk5nettwxwvlp6vvbwdhorj2yx3ytq3utsjkhgq
    ONTO initial
{
  CREATE MODULE authentication IF NOT EXISTS;
  CREATE FUTURE nonrecursive_access_policies;
  CREATE ABSTRACT TYPE default::HasTimestamps {
      CREATE REQUIRED PROPERTY createdAt -> std::datetime {
          SET default := (std::datetime_of_statement());
          SET readonly := true;
      };
      CREATE REQUIRED PROPERTY updatedAt -> std::datetime {
          SET default := (std::datetime_of_statement());
      };
  };
  CREATE TYPE authentication::Account EXTENDING default::HasTimestamps {
      CREATE REQUIRED PROPERTY provider -> std::str;
      CREATE REQUIRED PROPERTY providerAccountId -> std::str;
      CREATE CONSTRAINT std::exclusive ON ((.provider, .providerAccountId));
      CREATE PROPERTY access_token -> std::str;
      CREATE PROPERTY expires_at -> std::int64;
      CREATE PROPERTY id_token -> std::str;
      CREATE PROPERTY refresh_token -> std::str;
      CREATE PROPERTY scope -> std::str;
      CREATE PROPERTY session_state -> std::str;
      CREATE PROPERTY token_type -> std::str;
      CREATE REQUIRED PROPERTY type -> std::str;
  };
  CREATE TYPE authentication::User EXTENDING default::HasTimestamps {
      CREATE REQUIRED PROPERTY email -> std::str {
          CREATE CONSTRAINT std::exclusive ON (std::str_lower(__subject__));
      };
      CREATE PROPERTY emailVerified -> std::datetime;
      CREATE PROPERTY image -> std::str;
      CREATE PROPERTY name -> std::str {
          CREATE ANNOTATION std::description := 'Display name of the User';
      };
  };
  ALTER TYPE authentication::Account {
      CREATE REQUIRED LINK user -> authentication::User {
          ON TARGET DELETE DELETE SOURCE;
      };
  };
  ALTER TYPE authentication::User {
      CREATE LINK accounts := (.<user[IS authentication::Account]);
  };
};
