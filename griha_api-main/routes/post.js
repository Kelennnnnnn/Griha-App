const router = require("express").Router();
const multer = require("multer");
const { verifyToken, verifyAndAuthorize } = require("./verifytoken");
const db = require("../db");
const e = require("express");
const { json } = require("body-parser");
const { getJsonFormat } = require("../utils/constants");
const { send } = require("process");
const { upload } = require("./upload_image");

//GET POSTS

//publish post

//GETS POSTS BY CATEGORY
router.get("/", verifyToken, async (req, res) => {
  try {
    const query = `SELECT 
    posts.post_id,
    posts.title,
    description,
    price,
    total_rooms,
    total_bedroom,
    number_of_kitchen,
    facilities,
    street_address,
    posted_by,
    categories.title AS category_title,
    categories.image_url AS category_image,
    users.full_name AS fullname,
    users.email AS email,
    users.phone_number,
    GROUP_CONCAT(post_pictures.image_url) AS picture_urls,
    cities.city_name AS city_name
  
FROM 
    posts
    LEFT JOIN categories ON posts.category_id=categories.category_id
    LEFT JOIN users ON users.user_id=posts.posted_by 
    LEFT JOIN cities ON cities.city_id=posts.city_id
    LEFT JOIN post_pictures ON post_pictures.post_id = posts.post_id
GROUP BY posts.post_id;`;

    db.query(query, (error, data) => {
      if (error) return res.status(500).json(error);
      if (data) {
        const posts = data.map((row) => {
          const post = {
            post_id: row.post_id,
            title: row.title,
            description: row.description,
            price: row.price,
            total_rooms: row.total_rooms,
            total_bedroom: row.total_bedroom,
            number_of_kitchen: row.number_of_kitchen,
            facilities: row.facilities,
            street_address: row.street_address,
            posted_by: row.posted_by,
            category_title: row.category_title,
            category_image: row.category_image,
            city_id: row.city_id,
            city_name: row.city_name,
            fullname: row.fullname,
            phone_number: row.phone_number,
            email: row.email,
            applied_users_count: row.applied_users_count,
            picture_urls: row.picture_urls?.split(",") ?? [],
          };
          return post;
        });
        return res.status(200).json(posts);
      }
    });
  } catch (error) {}
});

//GETS POSTS BY CATEGORY
router.get("/c/:categoryId", verifyToken, async (req, res) => {
  try {
    const query = `select * from posts where post_category="${req.params.categoryId}";`;
    db.query(query, (error, data) => {
      if (error) return res.status(500).json(error);
      if (data) {
        return res.status(200).json(data);
      }
    });
  } catch (error) {}
});

//Apply to post
router.post("/book/:id", upload.none(), verifyToken, async (req, res) => {
  try {
    if (!req.body.post_id) {
      return res.status(400).json({
        success: false,
        message: "Post id is required",
      });
    } else if (!req.body.start_date) {
      return res.status(400).json({
        success: false,
        message: "Start date is required",
      });
    } else if (!req.body.end_date) {
      return res.status(400).json({
        success: false,
        message: "End date is required",
      });
    } else if (!req.params.id) {
      return res.status(400).json({
        success: false,
        message: "User id is required",
      });
    } else if (!req.body.total_amount) {
      return res.status(400).json({
        success: false,
        message: "Total amount is required",
      });
    } else if (!req.body.is_paid) {
      return res.status(400).json({
        success: false,
        message: "Is paid is required",
      });
    }

    const query = `select * from bookings where post_id=${req.body.post_id}`;

    db.query(query, (err, results) => {
      if (err) return res.status(500).json(err);
      if (results.length > 0) {
        //check if start date and end date is in between the start and end date of the post
        // Parse the start and end dates of the new booking
        const newBookingStartDate = new Date(req.body.start_date);
        const newBookingEndDate = new Date(req.body.end_date);
        var breakLoop = false;

        results.forEach((result) => {
          if (breakLoop) return;
          // Parse the start and end dates of the previous booking
          const prevBookingStartDate = new Date(result.start_date);
          const prevBookingEndDate = new Date(result.end_date);

          // Compare the dates as timestamps
          if (
            (newBookingStartDate.getTime() >= prevBookingStartDate.getTime() &&
              newBookingStartDate.getTime() <= prevBookingEndDate.getTime()) ||
            (newBookingEndDate.getTime() >= prevBookingStartDate.getTime() &&
              newBookingEndDate.getTime() <= prevBookingEndDate.getTime())
          ) {
            breakLoop = true;
            return res
              .status(409)
              .send(
                getJsonFormat(
                  null,
                  "This property is already booked for this period!",
                  false
                )
              );
          }
        });
        if (!breakLoop) insertBooking(req, res);
      } else {
        insertBooking(req, res);
      }

      //else insert into bookings
    });
  } catch (error) {
    res.status(500).send(getJsonFormat(error, false));
  }
});

//Get bookings by user id
router.get("/bookings/:id", verifyToken, async (req, res) => {
  try {
    const query = `select * from bookings where user_id=${req.params.id}`;
  } catch (error) {}
});

//Get bookings made on user owned post
router.get("/bookingRequests/:id", verifyToken, async (req, res) => {
  try {
    const query = `SELECT 
    bookings.booking_id,
    bookings.post_id,
    bookings.user_id,
    bookings.start_date,
    bookings.end_date,
    bookings.total_amount,
    bookings.is_paid,
    bookings.payment_mode,
    bookings.additional_payment_data,
    bookings.created_at,
    bookings.updated_at,
    posts.title,
    posts.description,
    posts.price,
    posts.total_rooms,
    posts.total_bedroom,
    posts.number_of_kitchen,
    posts.facilities,
    posts.street_address,
    posts.posted_by
FROM bookings
JOIN posts ON bookings.post_id = posts.post_id
WHERE posts.posted_by = ?
AND bookings.user_id IS NOT NULL ORDER BY bookings.created_at desc;`;

    const values = [req.params.id];

    db.query(query, values, (err, results) => {
      if (err) return res.status(500).json(err);
      if (results) {
        return res.status(200).json(results);
      }
    });
  } catch (error) {}
});

//Get bookings made by user on other posts
router.get("/mybookings/:id", verifyToken, async (req, res) => {
  try {
    const query = `SELECT 
    bookings.booking_id,
    bookings.post_id,
    bookings.user_id,
    bookings.start_date,
    bookings.end_date,
    bookings.total_amount,
    bookings.is_paid,
    bookings.payment_mode,
    bookings.additional_payment_data,
    bookings.created_at,
    bookings.updated_at,
    posts.title,
    posts.description,
    posts.price,
    posts.total_rooms,
    posts.total_bedroom,
    posts.number_of_kitchen,
    posts.facilities,
    posts.street_address,
    posts.posted_by
FROM bookings
JOIN posts ON bookings.post_id = posts.post_id
WHERE bookings.user_id = ? ORDER BY bookings.created_at desc;`;

    const values = [req.params.id];

    db.query(query, values, (err, results) => {
      if (err) return res.status(500).json(err);
      if (results) {
        return res.status(200).json(results);
      }
    });
  } catch (error) {}
});

//Apply to post
router.post(
  "/checkBooking/:id",
  upload.none(),
  verifyToken,
  async (req, res) => {
    try {
      if (!req.body.post_id) {
        return res.status(400).json({
          success: false,
          message: "Post id is required",
        });
      } else if (!req.body.start_date) {
        return res.status(400).json({
          success: false,
          message: "Start date is required",
        });
      } else if (!req.body.end_date) {
        return res.status(400).json({
          success: false,
          message: "End date is required",
        });
      } else if (!req.params.id) {
        return res.status(400).json({
          success: false,
          message: "User id is required",
        });
      } else if (!req.body.total_amount) {
        return res.status(400).json({
          success: false,
          message: "Total amount is required",
        });
      } else if (!req.body.is_paid) {
        return res.status(400).json({
          success: false,
          message: "Is paid is required",
        });
      }

      const query = `select * from bookings where post_id=${req.body.post_id}`;

      db.query(query, (err, results) => {
        if (err) return res.status(500).json(err);
        if (results.length > 0) {
          //check if start date and end date is in between the start and end date of the post
          // Parse the start and end dates of the new booking
          const newBookingStartDate = new Date(req.body.start_date);
          const newBookingEndDate = new Date(req.body.end_date);
          var breakLoop = false;

          results.forEach((result) => {
            if (breakLoop) return;
            // Parse the start and end dates of the previous booking
            const prevBookingStartDate = new Date(result.start_date);
            const prevBookingEndDate = new Date(result.end_date);

            // Compare the dates as timestamps
            if (
              (newBookingStartDate.getTime() >=
                prevBookingStartDate.getTime() &&
                newBookingStartDate.getTime() <=
                  prevBookingEndDate.getTime()) ||
              (newBookingEndDate.getTime() >= prevBookingStartDate.getTime() &&
                newBookingEndDate.getTime() <= prevBookingEndDate.getTime())
            ) {
              breakLoop = true;
              return res
                .status(409)
                .send(
                  getJsonFormat(
                    null,
                    "This property is already booked for this period!",
                    false
                  )
                );
            }
          });
          if (!breakLoop) {
            res
              .status(200)
              .send(getJsonFormat(results, "No bookings found", true));
          }
        } else {
          res
            .status(200)
            .send(getJsonFormat(results, "No bookings found", true));
        }

        //else insert into bookings
      });
    } catch (error) {
      res.status(500).send(getJsonFormat(error, false));
    }
  }
);

const insertBooking = (req, res) => {
  try {
    const query1 =
      "insert into bookings (post_id,user_id,start_date,end_date,total_amount,is_paid,payment_mode,additional_payment_data) values (?)";
    const values1 = [
      req.body.post_id,
      req.params.id,
      req.body.start_date,
      req.body.end_date,
      req.body.total_amount,
      req.body.is_paid == "true" ? 1 : 0,
      req.body.payment_mode,
      req.body.additional_payment_data,
    ];

    db.query(query1, [values1], (err, results) => {
      if (err) return res.status(500).json(err);

      res.status(200).send(getJsonFormat(null, "Booked Successfully!", true));
    });
  } catch (error) {
    res.status(500).send(getJsonFormat(error, false));
  }
};

//INSERT INTO FAVOURITE
router.put("/favourite/:id", verifyAndAuthorize, (req, res) => {
  try {
    console.log(req.body);
    if (!req.body.postId) {
      return res.status(400).json({
        success: false,
        message: "Post id is required",
      });
    } else if (!req.params.id) {
      return res.status(400).json({
        success: false,
        message: "User id is required",
      });
    }

    const query = "select * from favourites where post_id=? and user_id=?;";
    const values = [req.body.postId, req.params.id];

    db.query(query, values, (err, data) => {
      if (err) {
        return res.status(500).json(err);
      }
      if (data.length) {
        const query = "delete from favourites where post_id=? and user_id=?;";

        db.query(query, values, (err, data) => {
          if (err) {
            return res.status(500).json(err);
          } else {
            return res.status(200).json({
              success: true,
              message: "Post removed from favourites",
            });
          }
        });
      } else {
        const query = "insert into favourites (post_id,user_id) values(?);";

        db.query(query, [values], (err, data) => {
          if (err) {
            return res.status(500).json(err);
          } else {
            return res.status(200).json({
              success: true,
              message: "Post added to favourites",
            });
          }
        });
      }
    });
  } catch (error) {
    return res.status(500).json(error);
  }
});

//INSERT CATEGORY IN THE DATABASE
router.post(
  "/:id",

  verifyAndAuthorize,
  upload.array("images"),
  async (req, res) => {
    //create transaction
    db.beginTransaction(function (err) {
      if (err) {
        throw err;
      }
      try {
        const query =
          "INSERT INTO `posts` (`category_id`,`city_id`, `title`, `description`, `price`, `total_rooms`, `total_bedroom`, `number_of_kitchen`, `facilities`,`street_address`, `posted_by`) VALUES (?);";

        const values = [
          req.body.category_id,
          req.body.city_id,
          req.body.title,
          req.body.description,
          req.body.price,
          req.body.total_rooms,
          req.body.total_bedroom,
          req.body.number_of_kitchen,
          req.body.facilities,
          req.body.street_address,
          req.params.id,
        ];
        console.log("before query");
        db.query(query, [values], (err, results) => {
          if (err) {
            db.rollback(function () {
              console.log("rollback");
              console.log(err);
              return res.status(500).json(err);
            });
          }
          const query1 =
            "INSERT INTO post_pictures (post_id, image_url) VALUES ?";
          const values1 = [];
          req.files.forEach((file) => {
            values1.push([results.insertId, file.path]);
          });
          db.query(query1, [values1], (err, results) => {
            if (err) {
              db.rollback(function () {
                throw err;
              });
            } else {
              db.commit(function (err) {
                if (err) {
                  db.rollback(function () {
                    throw err;
                  });
                }
                res
                  .status(200)
                  .send(getJsonFormat("Post Created Successfully!", true));
              });
            }
          });
        });
      } catch (err) {
        res.status(500).json(err);
      }
    });
  }
);

module.exports = router;
