const router = require("express").Router();
const {
  verifyToken,
  verifyAndAuthorize,
  verifyCredentials,
  verifyAdmin,
} = require("./verifytoken");
const db = require("../db");
const { getJsonFormat } = require("../utils/constants");

//GET ALL CATEGORIES

router.get("/", verifyToken, async (req, res) => {
  const query = `select * from categories`;
  try {
    db.query(query, (error, data) => {
      if (error) return res.status(500).json(error);
      if (data) {
        return res
          .status(200)
          .send(getJsonFormat(data, "Categories fetched successfully!", true));
      }
    });
  } catch (error) {}
});

router.delete("/:id", verifyToken, async (req, res) => {
  const query = `delete from categories where category_id=${req.params.id}`;
  try {
    db.query(query, (error, data) => {
      if (error.errno == 1451)
        return res
          .status(500)
          .send(
            getJsonFormat(
              "You can't delete this category because it is used in a post!",
              false
            )
          );
      if (error) return res.status(500).json(error);
      if (data) {
        return res
          .status(200)
          .send(getJsonFormat("Categories deleted successfully!", true));
      }
    });
  } catch (error) {}
});

const checkCategory = (req, res, next) => {
  try {
    const query = "select * from categories where title=?";
    const values = [req.body.title];
    db.query(query, [values], (err, results) => {
      if (err) return res.status(500).json(err);

      if (results.length > 0) {
        return res
          .status(500)
          .send(getJsonFormat(null, "Category already exists!", false));
      } else {
        next();
      }
    });
  } catch (err) {
    res.status(500).json(err);
  }
};

//INSERT CATEGORY IN THE DATABASE
router.post("/", verifyToken, checkCategory, async (req, res) => {
  try {
    const query = "insert into categories (title, image_url) values (?)";

    const values = [req.body.title, req.body.imageUrl];
    db.query(query, [values], (err, results) => {
      if (err) return res.status(500).json(err);

      res.status(200).send(getJsonFormat("Category added successfully!", true));
    });
  } catch (err) {
    res.status(500).json(err);
  }
});

module.exports = router;
