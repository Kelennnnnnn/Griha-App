const jwt = require("jsonwebtoken");
const db = require("../db");
const bcrypt = require("bcrypt");

//VERITY THE USER TOKEN
const verifyToken = (req, res, next) => {
  const bearer = req.headers.authorization;

  if (!bearer) return res.status(401).json("Token not found!");
  const authToken = bearer.split(" ")[1];
  try {
    jwt.verify(authToken, process.env.jwt_pass, (err, user) => {
      if (err) return res.status(500).json(err);
      req.user = user;

      next();
    });
  } catch (error) {}
};

//VERIFY

const verifyAndAuthorize = (req, res, next) => {
  verifyToken(req, res, () => {
    if (req.user.id.toString() === req.params.id) {
      next();
    } else {
      res.status(500).json("You are not authorized!");
    }
  });
};

const verifyCredentials = (req, res, next) => {
  const query = `select * from users where email='${req.body.email}'`;
  db.query(query, async (err, data) => {
    if (err) return res.status(500).json(err);

    if (data.length === 0) return res.status(404).json("User not found");

    bcrypt.compare(req.body.password, data[0].password, (error, result) => {
      if (!result) return res.status(409).json("Incorrect Password!");
      if (error) return res.status(500).json(error);
      req.data = data[0];
      next();
    });
  });
};
const verifyAdmin = (req, res, next) => {
  verifyToken(req, res, () => {
    if (req.user.isAdmin) {
      next();
    } else {
      res
        .status(403)
        .send(getJsonFormat(null, "You are not allowed! Admin only!", false));
    }
  });
};

module.exports = {
  verifyToken,
  verifyAndAuthorize,
  verifyCredentials,
  verifyAdmin,
};
