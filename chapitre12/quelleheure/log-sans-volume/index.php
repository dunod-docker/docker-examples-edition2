<!DOCTYPE html>
<html>
<body>
<?php 
$maintenant=date("h:i:sa");
$log="Access at " . $maintenant . "\n";
file_put_contents("/data/logs.txt", $log, FILE_APPEND);
?>
<h1>Quelle heure est-il ?</h1>
<p>Hello il est : <?php echo($maintenant);  ?></p>
<p>Il semble que je sois installé sur un hôte nommé : <?php echo(gethostname());  ?></p>
<p><u>Derniers accès à cette page</u></p>
<?php
if ($file = fopen("/data/logs.txt", "r")) {
    while(!feof($file)) {
        $line = fgets($file);
        ?>
<hr/>
<?php echo($line) ?><br/>
        <?php
    }
    fclose($file);
}
?>
</body>
</html>
