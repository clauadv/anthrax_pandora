
import { globals } from "../utils/globals.js";
import { database } from "../utils/database.js";

export const get_all = () => {
    globals.app.route("/get_all").get((request, response) => {
        if (request.headers["user-agent"] != "Valve/Steam HTTP Client 1.0 (730)") {
            return response.sendStatus(500);
        }

        database.query("select * from configs", (error, query_response) => {
            if (error) globals.logger.error(`error: ${error}`)

            response.send(query_response);
        });
    })
}