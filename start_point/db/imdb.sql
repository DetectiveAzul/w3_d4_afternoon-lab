DROP TABLE IF EXISTS castings;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS stars;


CREATE TABLE stars (
  id SERIAL8 PRIMARY KEY,
  f_name VARCHAR(255),
  l_name VARCHAR(255)
);
CREATE TABLE movies (
  id SERIAL8 PRIMARY KEY,
  title VARCHAR(255),
  genre VARCHAR(255),
  rating FLOAT(4),
  budget INT
);
CREATE TABLE castings (
  id SERIAL8 PRIMARY KEY,
  star_id INT8 REFERENCES movies(id),
  movie_id INT8 REFERENCES stars(id),
  fee INT
);
