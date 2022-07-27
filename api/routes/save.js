
import { globals } from "../utils/globals.js";
import { database } from "../utils/database.js";

export const save = () => {
    globals.app.route("/save").post((request, response) => {
        if (request.headers["user-agent"] != "Valve/Steam HTTP Client 1.0 (730)") {
            return response.sendStatus(500);
        }

        if (!request.body.user && !request.body.config) {
            return res.sendStatus(500);
        }

        database.query("SELECT id FROM configs WHERE user = ?", [request.body.user], (error, query_response) => {
            if (error) globals.logger.error(`error: ${error}`)

            if (query_response.length > 0) {
                database.query("UPDATE configs SET config = ? WHERE user = ?", [request.body.config, request.body.user], (error) => {
                    if (error) globals.logger.error(`error: ${error}`)
                });

                globals.logger.log(`${request.body.user} updated this config`);
                return response.send(`${request.body.user} updated this config`)
            }

            database.query("INSERT INTO configs SET ?", { user: request.body.user, config: request.body.config }, (error) => {
                if (error) globals.logger.error(`error: ${error}`)
            });

            globals.logger.log(`${request.body.user} added a config`);
            response.send(`${request.body.user} added a config`);
        });
    })
}