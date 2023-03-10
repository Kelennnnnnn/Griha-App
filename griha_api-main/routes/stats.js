const router = require("express").Router();
const {
  verifyToken,
  verifyAndAuthorize,
  verifyCredentials,
} = require("./verifytoken");
const db = require("../db");
const e = require("express");

//method to search for post or category or users

router.get("/search", verifyToken, async (req, res) => {
  try {
    const query = `select * from posts where title like '%${req.query.q}%' or description like '%${req.query.q}%' or category like '%${req.query.q}%' or username like '%${req.query.q}%'`;
  } catch (err) {
    res.status(500).json(err);
  }
});

module.exports = router;
