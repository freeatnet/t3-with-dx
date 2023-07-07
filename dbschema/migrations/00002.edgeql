CREATE MIGRATION m1suxqtfrci7s3mjq5znjzlmwpkf6mavzrvyhm4g6yrp5476surwca
    ONTO m1lrarqonlle7iwtk5nettwxwvlp6vvbwdhorj2yx3ytq3utsjkhgq
{
  ALTER TYPE default::HasTimestamps {
      ALTER PROPERTY createdAt {
          RESET default;
          CREATE REWRITE
              INSERT 
              USING ((std::datetime_of_statement() IF NOT (__specified__.createdAt) ELSE .createdAt));
      };
      ALTER PROPERTY updatedAt {
          RESET default;
          CREATE REWRITE
              INSERT 
              USING ((std::datetime_of_statement() IF NOT (__specified__.updatedAt) ELSE .updatedAt));
          CREATE REWRITE
              UPDATE 
              USING ((std::datetime_of_statement() IF NOT (__specified__.updatedAt) ELSE .updatedAt));
      };
  };
};
