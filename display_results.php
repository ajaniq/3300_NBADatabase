<?php
require_once 'config.php';

// Display a relation table if requested
if (isset($_POST['relation'])) {
    $relation = preg_replace('/[^a-zA-Z0-9_]/', '', $_POST['relation']); 
    try {
        $stmt = $pdo->query("SELECT * FROM $relation");
        $results = $stmt->fetchAll();
        echo '<!DOCTYPE html>
        <html>
        <head>
            <title>' . htmlspecialchars($relation) . ' Table</title>
            <link rel="stylesheet" href="styles.css">
        </head>
        <body>
            <div class="container">
                <h1>' . htmlspecialchars($relation) . ' Table</h1>
                <div class="results-container">';
        if (count($results) > 0) {
            echo '<table class="results-table">
                    <thead><tr>';
            foreach (array_keys($results[0]) as $column) {
                echo '<th>' . htmlspecialchars($column) . '</th>';
            }
            echo '</tr></thead><tbody>';
            foreach ($results as $row) {
                echo '<tr>';
                foreach ($row as $value) {
                    echo '<td>' . htmlspecialchars($value) . '</td>';
                }
                echo '</tr>';
            }
            echo '</tbody></table>';
        } else {
            echo '<p>No results found.</p>';
        }
        echo '</div>
                <a href="index.html" class="back-button">Back to Home</a>
            </div>
        </body>
        </html>';
    } catch(Exception $e) {
        echo '<!DOCTYPE html>
        <html>
        <head>
            <title>Error</title>
            <link rel="stylesheet" href="styles.css">
        </head>
        <body>
            <div class="container">
                <h1>Error</h1>
                <p class="error-message">' . htmlspecialchars($e->getMessage()) . '</p>
                <a href="index.html" class="back-button">Back to Home</a>
            </div>
        </body>
        </html>';
    }
    exit;
}

// Get the query type from POST data
$query_type = $_POST['query_type'] ?? '';
$sql_query = $_POST['sql_query'] ?? '';

try {
    switch($query_type) {
        case 'query1':
            $stmt = $pdo->query("SELECT 
    p.F_Name,
    p.L_Name,
    p.Position,
    p.Points,
    p.Rebounds,
    p.Assists,
    t.Team_Name,
    t.Location AS Conference,
    t.Win,
    t.Lose
FROM Player p
INNER JOIN Team t ON p.Team_ID = t.Team_ID
ORDER BY p.Points DESC;");
            break;
        case 'query2':
            $stmt = $pdo->query("SELECT 
    Position,
    COUNT(*) AS Total_Players,
    AVG(Points) AS Avg_Points,
    AVG(Rebounds) AS Avg_Rebounds,
    AVG(Assists) AS Avg_Assists,
    MAX(Points) AS Highest_Scorer,
    MIN(Points) AS Lowest_Scorer
FROM Player
GROUP BY Position
ORDER BY Avg_Points DESC;");
            break;
        case 'query3':
            $stmt = $pdo->query("SELECT 
    p.F_Name,
    p.L_Name,
    p.Points,
    t.Team_Name,
    (SELECT AVG(Points) FROM Player) AS League_Average
FROM Player p
INNER JOIN Team t ON p.Team_ID = t.Team_ID
WHERE p.Points > (SELECT AVG(Points) FROM Player)
ORDER BY p.Points DESC;");
            break;
        case 'query4':
            $stmt = $pdo->query("SELECT 
    Position,
    COUNT(*) AS Total_Players,
    AVG(Rebounds) AS Avg_Rebounds,
    MAX(Rebounds) AS Best_Rebounder,
    MIN(Rebounds) AS Worst_Rebounder,
    SUM(Rebounds) AS Total_Rebounds
FROM Player
GROUP BY Position
HAVING AVG(Rebounds) > 6
ORDER BY Avg_Rebounds DESC;");
            break;
        case 'query5':
            $stmt = $pdo->query("SELECT 
    t.Team_Name,
    t.Location AS Conference,
    t.Win,
    t.Lose,
    m.Media_Type,
    m.Description,
    m.Like_Counter,
    COALESCE(m.Like_Counter, 0) AS Likes_Count
FROM Team t
LEFT OUTER JOIN Media m ON t.Team_ID = m.Team_ID
ORDER BY t.Win DESC, m.Like_Counter DESC;");
            break;
        case 'custom':
            $stmt = $pdo->query($sql_query);
            break;
        default:
            throw new Exception("Invalid query type");
    }

    $results = $stmt->fetchAll();
    
    // Start HTML output
    echo '<!DOCTYPE html>
    <html>
    <head>
        <title>Query Results</title>
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <div class="container">
            <h1>Query Results</h1>
            <div class="results-container">';
    
    if (count($results) > 0) {
        echo '<table class="results-table">
                <thead><tr>';
        // Print column headers
        foreach (array_keys($results[0]) as $column) {
            echo '<th>' . htmlspecialchars($column) . '</th>';
        }
        echo '</tr></thead><tbody>';
        
        // Print data rows
        foreach ($results as $row) {
            echo '<tr>';
            foreach ($row as $value) {
                echo '<td>' . htmlspecialchars($value) . '</td>';
            }
            echo '</tr>';
        }
        echo '</tbody></table>';
    } else {
        echo '<p>No results found.</p>';
    }
    
    echo '</div>
            <a href="index.html" class="back-button">Back to Home</a>
        </div>
    </body>
    </html>';
    
} catch(Exception $e) {
    echo '<!DOCTYPE html>
    <html>
    <head>
        <title>Error</title>
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <div class="container">
            <h1>Error</h1>
            <p class="error-message">' . htmlspecialchars($e->getMessage()) . '</p>
            <a href="index.html" class="back-button">Back to Home</a>
        </div>
    </body>
    </html>';
}
?> 