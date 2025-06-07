<?php
// Database connection settings
$host = 'cssql.seattleu.edu:3306';     
$dbname = 'll_aquibuyen';  
$username = 'll_aquibuyen';      
$password = '+XFGTZhVp6i8JEIs';          

try {
    // Create PDO connection
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    
    // Set the PDO error mode to exception
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // Set default fetch mode to associative array
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    
} catch(PDOException $e) {
    // If connection fails, display error message
    die("Connection failed: " . $e->getMessage());
}
?> 