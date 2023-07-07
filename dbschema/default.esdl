module default {
  abstract type HasTimestamps {
    required property createdAt -> datetime {
      readonly := true;
      rewrite insert using (
        datetime_of_statement()
        if not __specified__.createdAt
        else .createdAt
      );
    }

    required property updatedAt -> datetime {
      rewrite insert, update using (
        datetime_of_statement()
        if not __specified__.updatedAt
        else .updatedAt
      );
    }
  }
}

module authentication {
  type User extending default::HasTimestamps {
    required property email -> str {
      constraint exclusive on (str_lower(__subject__));
    };
    property emailVerified -> datetime;

    property name -> str {
      annotation description := "Display name of the User";
    };
    property image -> str;

    link accounts := .<user[is authentication::Account];
  }

  type Account extending default::HasTimestamps {
    required property type -> str;
    required property provider -> str;
    required property providerAccountId -> str;

    property access_token -> str;
    property refresh_token -> str;
    property expires_at -> int64;
    property token_type -> str;
    property scope -> str;
    property id_token -> str;

    property session_state -> str;

    required link user -> User {
      on target delete delete source;
    };

    constraint exclusive on ((.provider, .providerAccountId));
  }
}
