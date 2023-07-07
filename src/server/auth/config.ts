import { type DefaultSession, type NextAuthOptions } from "next-auth";
import { type JWT } from "next-auth/jwt";
import GithubProvider from "next-auth/providers/github";

import { env } from "~/env.mjs";
import { edgedbClient } from "~/server/edgedb";

import { EdgeDBAdapter } from "./adapters/edgedb";

/**
 * Module augmentation for `next-auth` types. Allows us to add custom properties to the `session`
 * object and keep type safety.
 *
 * @see https://next-auth.js.org/getting-started/typescript#module-augmentation
 */
declare module "next-auth" {
  interface Session extends DefaultSession {
    user: {
      id: string;
      // ...other properties
      // role: UserRole;
    } & DefaultSession["user"];
  }

  // interface User {
  //   // ...other properties
  //   // role: UserRole;
  // }
}

const edgedbAdapter = new EdgeDBAdapter(edgedbClient);

/**
 * Options for NextAuth.js used to configure adapters, providers, callbacks, etc.
 *
 * @see https://next-auth.js.org/configuration/options
 */
export const authOptions: NextAuthOptions = {
  callbacks: {
    session: async (opts: {
      session: DefaultSession;
      token: JWT;
      user: unknown; // not provided when using an adapter
    }) => {
      const { session, token } = opts;

      const { sub } = token;
      if (!sub) {
        throw new Error("Unauthorized: no sub in token");
      }

      const user = await edgedbAdapter.getUser(sub);
      if (!user) {
        throw new Error("Unauthorized: user not found");
      }

      return {
        ...session,
        user: {
          ...session.user,
          id: user.id,
        },
      };
    },
  },
  adapter: edgedbAdapter,
  providers: [
    GithubProvider({
      clientId: env.GITHUB_CLIENT_ID,
      clientSecret: env.GITHUB_CLIENT_SECRET,
    }),
    /**
     * ...add more providers here.
     *
     * Most other providers require a bit more work than the Discord provider. For example, the
     * GitHub provider requires you to add the `refresh_token_expires_in` field to the Account
     * model. Refer to the NextAuth.js docs for the provider you want to use. Example:
     *
     * @see https://next-auth.js.org/providers/github
     */
  ],
  session: {
    strategy: "jwt",
  },
};
