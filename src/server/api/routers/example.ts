import { z } from "zod";

import {
  createTRPCRouter,
  protectedProcedure,
  publicProcedure,
} from "~/server/api/trpc";
import { e } from "~/server/edgedb";

export const exampleRouter = createTRPCRouter({
  hello: publicProcedure
    .input(z.object({ text: z.string() }))
    .query(({ input }) => {
      return {
        greeting: `Hello ${input.text}`,
      };
    }),
  currentTime: publicProcedure.query(async ({ ctx: { edgedbClient } }) => {
    const query = e.select(e.cast(e.str, e.datetime_current()));
    const time = await query.run(edgedbClient);

    return time;
  }),

  getSecretMessage: protectedProcedure.query(() => {
    return "you can now see this secret message!";
  }),
});
