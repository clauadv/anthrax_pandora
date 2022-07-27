import chalk from "chalk";

export const logger = {
    log: (message) => console.log(chalk.white("*"), chalk.rgb(164, 187, 223)("anthrax"), chalk.white(`- ${message}`)),
    error: (message) => console.log(chalk.white("*"), chalk.rgb(164, 187, 223)("anthrax"), chalk.white(`- ${message}`))
};