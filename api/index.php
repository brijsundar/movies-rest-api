<?php

require 'Slim/Slim.php';

$app = new Slim();
// get movie list 
$app->get('/movies', 'getMovies');
// get movi list by Id
$app->get('/movies/:id', 'getMovie');
// search movie by name
$app->get('/movies/search/:query', 'findByName');
//add new movie
$app->post('/movies', 'addMovie');
// update movie
$app->put('/movies/:id', 'updateMovie');
// delete Movie
$app->delete('/movies/:id',	'deleteMovie');

$app->run();

// Function responsible for getting all movies list
function getMovies() {
	$sql = "select * FROM movies ORDER BY name";
	try {
		$db = getConnection();
		$stmt = $db->query($sql);  
		$movies = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		echo '{"movie": ' . json_encode($movies) . '}';
	} catch(PDOException $e) {
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

// Function responsible for getting movie list by Id
function getMovie($id) {
	$sql = "SELECT * FROM movies WHERE id=:id";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);  
		$stmt->bindParam("id", $id);
		$stmt->execute();
		$movie = $stmt->fetchObject();  
		$db = null;
		echo json_encode($movie); 
	} catch(PDOException $e) {
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

// Function responsible for adding new movie
function addMovie() {
	$request = Slim::getInstance()->request();
	$movie = json_decode($request->getBody());
	$sql = "INSERT INTO movies (name, imdb_score, genre_id, popularity, director, added_by, added_date) VALUES (:name, :imdb_score,:genre_id, :popularity, :director, :added_by, :added_date)";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);  
		$stmt->bindParam("name", $movie->name);
		$stmt->bindParam("imdb_score", $movie->imdb_score);
        $stmt->bindParam("genre_id", $movie->genre_id);
		$stmt->bindParam("popularity", $movie->popularity);
		$stmt->bindParam("director", $movie->director);
		$stmt->bindParam("added_by", $movie->added_by);
		$stmt->bindParam("added_date", @date('Y-m-d'));
        
		$stmt->execute();
        
		$movie->id = $db->lastInsertId();
		$db = null;
		echo json_encode($movie); 
	} catch(PDOException $e) {
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

// Function responsible for updating movie
function updateMovie($id) {
	$request = Slim::getInstance()->request();
	$body = $request->getBody();
	$movie = json_decode($body);
	$sql = "UPDATE movies SET name=:name, imdb_score=:imdb_score, genre_id=:genre_id, popularity=:popularity, director=:director WHERE id=:id";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);  
		$stmt->bindParam("name", $movie->name);
		$stmt->bindParam("imdb_score", $movie->imdb_score);
        $stmt->bindParam("genre_id", $movie->genre_id);
		$stmt->bindParam("popularity", $movie->popularity);
		$stmt->bindParam("director", $movie->director);
		$stmt->bindParam("id", $id);
		$stmt->execute();
		$db = null;
		echo json_encode($movie); 
	} catch(PDOException $e) {
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

// Function responsible for delete movie by Id
function deleteMovie($id) {
	$sql = "DELETE FROM movies WHERE id=:id";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);  
		$stmt->bindParam("id", $id);
		$stmt->execute();
		$db = null;
	} catch(PDOException $e) {
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

// Function responsible for getting all movies list by movies name
function findByName($query) {
	$sql = "SELECT * FROM movies WHERE UPPER(name) LIKE :query ORDER BY name";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);
		$query = "%".$query."%";  
		$stmt->bindParam("query", $query);
		$stmt->execute();
		$movies = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		echo '{"movie": ' . json_encode($movies) . '}';
	} catch(PDOException $e) {
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

// Function responsible for returning db connection object
function getConnection() {
	$dbhost="127.0.0.1";
	$dbuser="root";
	$dbpass="";
	$dbname="movies";
	$dbh = new PDO("mysql:host=$dbhost;dbname=$dbname", $dbuser, $dbpass);	
	$dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	return $dbh;
}

?>