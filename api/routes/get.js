
import { globals } from "../utils/globals.js";
import { database } from "../utils/database.js";

export const get = () => {
    globals.app.route("/get").post((request, response) => {
        if (request.headers["user-agent"] != "Valve/Steam HTTP Client 1.0 (730)") {
            return response.sendStatus(500);
        }

        if (!request.body.id) {
            return res.sendStatus(500);
        }

        database.query("SELECT config FROM configs WHERE id = ?", [request.body.id], (error, query_response) => {
            if (error) globals.logger.error(`error: ${error}`)

            response.send(query_response);
        });
    })
}