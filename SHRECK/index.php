<?php

$db = new PDO("mysql:host=localhost;dbname=ccsopi","root","");

$select = "select 
film.cim AS cim ,film.ev AS ev,film.idfilm AS idfilm,
count(ertekelo.idertekelo) as valaszok,
avg(ertekelo.ertek) as atlag from film
LEFT JOIN ertekelo ON ertekelo.film_idfilm=film.idfilm
WHERE  film.ev>'2000'
GROUP BY film.cim
ORDER BY film.ev ASC";
$statement= $db->prepare($select);
$statement->execute();


?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Film</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header>
        <h1>Filmek</h1>
        <br>
        <p1>Spasic Nikola, C044ND</p1>
    </header>
    <section class="container">
        <?php
        while($row=$statement->fetch()){
        ?>
        <article class="fo1">
            <br>
            <h2><?=$row['cim']?></h2>
            <i><?=$row['ev']?></i><br>
            <br>
            <p1><p2>Ertekeles:</p2> <?=!empty($row['atlag']) ? $row['atlag']:'0.00'?> (<?=$row['valaszok']?> valasz)</p1>
            <ul>
                <?php
                    $select1="select nev,ertek,film_idfilm from ertekelo";
                    $statement2 = $db->prepare($select1);
                    $statement2->execute();
                    while($row2=$statement2->fetch()){
                        if($row2['film_idfilm'] == $row['idfilm']){
                ?>
                <li><p2><?=$row2['nev']?>:</p2> <?=!empty($row2['ertek']) ? ($row2['ertek']."/5"):'Nincs ertekeles'?></li>
                <?php }} ?>
            </ul>
        </article>
        <?php } ?>   
    </section>
    <section class="aside">
        <h3>Ertekeles</h3>
        <form method="post" action="rate.php">
            <label>Film:</label>
            <select name="valasztott" id="movies">
                <option value="1">Shrek</option>
                <option value="2">Thor</option>
                <option value="3">Dune</option>
            </select>

            <br><br><label>Nev:</label><br>
            <input type="text" name="nev"><br>
            <br><label>Pontszam:</label><br>
            <input type="number" name="ertek"><br>
            <br><input type="submit" value="kuldes">

        </form>
    </section>
    
</body>
</html>