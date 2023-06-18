import {
  type NextApiResponse,
  type GetServerSidePropsContext,
  type NextApiRequest,
} from "next";
import { getServerSession } from "next-auth";

import { authOptions } from "./config";

type GetSeverSessionReqParam =
  | GetServerSidePropsContext["req"]
  | NextApiRequest;
type GetSeverSessionResParam =
  | GetServerSidePropsContext["res"]
  | NextApiResponse;

/**
 * Wrapper for `getServerSession` so that you don't need to import the `authOptions` in every file.
 * @param ctx An object containing either `req` and `res` received by a `getServerSideProps` function,
 * or `req` and `res` received by an API route.
 * @see https://next-auth.js.org/configuration/nextjs
 */
export function getServerAuthSession(ctx: {
  req: GetSeverSessionReqParam;
  res: GetSeverSessionResParam;
}) {
  return getServerSession(ctx.req, ctx.res, authOptions);
}
