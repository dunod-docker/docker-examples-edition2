<!DOCTYPE html>
<html>
<body>
<?php
$maintenant=date("h:i:sa");
?>
<h1>Quelle heure est-il ?</h1>
<p>Hello il est : <?php echo($maintenant);  ?></p>
<p>Il semble que je sois installé sur un hôte nommé : <?php echo(gethostname());  ?></p>
</body>
</html>
