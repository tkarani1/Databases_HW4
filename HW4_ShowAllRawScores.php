<head><title>All Raw Scores</title></head>
<body>
<?php

	//open a connection to dbase server 
	include 'open.php';

	// collect the posted value in a variable called $item
	$item = $_POST['password'];

	// echo some basic header info onto the page
	echo "<h2>All Students Raw Scores</h2><br>";

    // proceed with query only if supplied SID is non-empty
	if (!empty($item)) {

       // call the stored procedure we already defined on dbase
	$result = $conn->query("CALL HW4_AllRawScores('".$item."');");

//	   if ($result = $conn->query("CALL ShowRawScores('".$item."');")) {
	    if (($result) && ($result->num_rows != 0)) {
	      echo "<table border=\"2px solid black\">";

          // output a row of table headers
	      echo "<tr>";
	      // collect an array holding all attribute names in $result
	      $flist = $result->fetch_fields();
          // output the name of each attribute in flist
	      foreach($flist as $fname){
	         echo "<td>".$fname->name."</td>";
	      }
	      echo "</tr>";

          // output a row of table for each row in result, using flist names
          // to obtain the appropriate attribute value for each column
	      foreach($result as $row){

              // reset the attribute names array
    	      $flist = $result->fetch_fields(); 
	          echo "<tr>";
	          foreach($flist as $fname){
                      echo "<td>".$row[$fname->name]."</td>";
              }
  	          echo "</tr>";
	      }
	      echo "</table>";

          } else {
			echo "ERROR: Invalid password<br>"; 
	  }   
   } else {
	echo "Call to ShowRawScores failed<br>"; 
 }

   // close the connection opened by open.php
   $conn->close();
?>
</body>
