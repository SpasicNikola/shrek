<?php
$db = new PDO("mysql:host=localhost;dbname=ccsopi","root","");
if(isset($_POST['nev']) && isset($_POST['ertek']) && isset($_POST['valasztott'])){
$valasztott = $_POST['valasztott'];
$ertek = $_POST['ertek'];
$nev = $_POST['nev'];
}
$inject = "INSERT INTO ertekelo(nev,ertek,film_idfilm) VALUES 
(:nev,:ertek,:valasztott)";
$statement2=$db->prepare($inject);
$statement2->bindParam(':nev',$nev,PDO::PARAM_STR);
$statement2->bindParam(':ertek',$ertek,PDO::PARAM_INT);
$statement2->bindParam(':valasztott',$valasztott,PDO::PARAM_INT);
$statement2->execute();






header("Location:index.php");
?>