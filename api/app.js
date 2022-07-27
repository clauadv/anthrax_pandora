import { database } from "./utils/database.js";
import { globals } from "./utils/globals.js";
import { get_all } from "./routes/get_all.js";
import { get } from "./routes/get.js";
import { save } from "./routes/save.js";

globals.app.use(globals.express.json());
globals.app.use(globals.express.urlencoded({ extended: true }));

globals.app.listen(3000, () => {
    globals.logger.log("express connected");

    get_all();
    get();
    save();
});

database.connect(async (error) => {
    if (error) globals.logger.error(error);

    globals.logger.log("mysql connected");
});