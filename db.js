
const Pool = require("pg").Pool;

const pool = new Pool({
    user: "postgres",
    host: "127.0.0.1", // Change this line
    database: "aquartic",
    password: "tish1997!!",
    port: 5432,
});

module.exports = pool;






// const Pool = require("pg").Pool;

// const pool = new Pool({
//     user: "postgres",
//     host: "localhost",
//     database: "aquartic",
//     password: "tish1997!!",
//     port:543,

// });

// module.exports =pool;
