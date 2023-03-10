const mysql = require("mysql");

const db = mysql.createConnection({
  host: "localhost",
  database: "griha",
  user: "root",
  password: "",
});

db.connect(function (err) {
  if (err) {
    console.error("error connecting: " + err.stack);
    return;
  }

  console.log("connected as id " + db.threadId);
});

module.exports = db;
