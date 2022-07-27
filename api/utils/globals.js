import { logger } from "./logger.js";
import express from "express";

export const globals = {
    express: express,
    app: express(),

    logger: {
        log: logger.log,
        error: logger.error
    }
};