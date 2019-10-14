<?php
include("config.php");
if(isset($_POST['submit'])) {
	if (getimagesize($_FILES["signature"]["tmp_name"]) == false) {
		echo '<div class="alert alert-Warning"><strong>Warning!</strong> Please select a signature file to upload. </div>';
		goto DataForm;
	}

	$check = getimagesize($_FILES["image"]["tmp_name"]);
	if($check !== false){
		// Check image size
		if(($_FILES['image']['size'] >= $max_img_size) || ($_FILES["image"]["size"] == 0)) {
			echo '<div class="alert alert-danger"><strong>Image file size too large!</strong> Image must be less than ' . $max_img_size/1000 . ' KB.</div>';
			goto DataForm;
		}

		// Check signature size
		if(($_FILES['signature']['size'] >= $max_signature_size) || ($_FILES["signature"]["size"] == 0)) {
			echo '<div class="alert alert-danger"><strong>Signature file size too large!</strong> Signature must be less than ' . $max_signature_size/1000 . ' KB.</div>';
			goto DataForm;
		}

		$image_width = getimagesize($_FILES["image"]["tmp_name"])[0];
		$image_height = getimagesize($_FILES["image"]["tmp_name"])[1];
		// Check image height and width constraints
		if ($image_width < $min_img_width || $image_height < $min_img_height) {
			echo '<div class="alert alert-danger"><strong>Image dimensions are too small!</strong> Minimum image size is ' . $min_img_width . ' &times; ' . $min_img_height . 'px. Uploaded image size is ' . $image_width . ' &times; ' . $image_height . 'px.</div>';
			goto DataForm;
		}
		elseif ($image_width > $max_img_width || $image_height > $max_img_height) {
			echo '<div class="alert alert-danger"><strong>Image dimensions are too large!</strong> Maximum image size is ' . $max_img_width . ' &times; ' . $max_img_height . 'px. Uploaded image size is ' . $image_width . ' &times; ' . $image_height . 'px.</div>';
			goto DataForm;
		}

		$signature_width = getimagesize($_FILES["signature"]["tmp_name"])[0];
		$signature_height = getimagesize($_FILES["signature"]["tmp_name"])[1];
		// Check signature height and width constraints
		if ($signature_width < $min_signature_width || $signature_height < $min_signature_height) {
			echo '<div class="alert alert-danger"><strong>Signature dimensions are too small!</strong> Minimum signature size is ' . $min_signature_width . ' &times; ' . $min_signature_height . 'px. Uploaded signature size is ' . $signature_width . ' &times; ' . $signature_height . 'px.</div>';
			goto DataForm;
		}
		elseif ($signature_width > $max_img_width || $signature_height > $max_img_height) {
			echo '<div class="alert alert-danger"><strong>Signature dimensions are too large!</strong> Maximum signature size is ' . $max_img_width . ' &times; ' . $max_img_height . 'px. Uploaded signature size is ' . $signature_width . ' &times; ' . $signature_height . 'px.</div>';
			goto DataForm;
		}

		// Check document size
		if(($_FILES['document']['size'] >= $max_doc_size) || ($_FILES["document"]["size"] == 0)) {
			echo '<div class="alert alert-danger"><strong>Document file size too large!</strong> Document must be less than ' . $max_doc_size/1000 . ' KB.</div>';
			goto DataForm;
		}

		$roll_no = $_POST['rollno'];
		$random_hash = sha1(rand());
		$img_ftype = str_replace("image/", "", $_FILES['image']['type']);
		$target_img_file_name = $roll_no . "i" . $random_hash . "." . $img_ftype;
		$target_img_file = $target_img_dir . $target_img_file_name;
		$signature_ftype = str_replace("image/", "", $_FILES['signature']['type']);
		$target_signature_file_name = $roll_no . "s" . $random_hash . "." . $signature_ftype;
		$target_signature_file = $target_signature_dir . $target_signature_file_name;
		$target_doc_file_name = $roll_no . "d" . $random_hash . ".pdf";
		$target_doc_file = $target_doc_dir . $target_doc_file_name;

		$db = new mysqli($dbHost, $dbUsername, $dbPassword, $dbName);
		if($db->connect_error){
			echo '<div class="alert alert-danger"><strong>Something went wrong!</strong> Please try after some time or contact server-admin. </div>';
			goto DataForm;
		}

		$dataTime = date("Y-m-d H:i:s");

		$insert = $db->query("INSERT into client_data (rollno, image, signature, document, created) VALUES (" . $roll_no . ", '" . $name . "." . $img_ftype . "', '" . $name . "." . $signature_ftype . "', '" . $name . ".pdf', '" . $dataTime . "')");

		if($insert){
			// Store uploaded image, signature and document file
			move_uploaded_file($_FILES['image']['tmp_name'], $target_img_file);
			move_uploaded_file($_FILES['signature']['tmp_name'], $target_signature_file);
			move_uploaded_file($_FILES['document']['tmp_name'], $target_doc_file);
			echo '<div class="alert alert-success"><strong>Success!</strong> Your response has been recorded. </div>';
		}else{
			echo '<div class="alert alert-danger"><strong>Something went wrong!</strong> Your response cannot be recorded. </div>';
		}
	}
	else{
		echo '<div class="alert alert-Warning"><strong>Warning!</strong> Please select an image file to upload. </div>';
	}
}

DataForm:
echo '<html>';

echo '<head>';
echo '<!-- Latest compiled and minified CSS -->';
echo '<link rel="stylesheet" href="bootstrap/bootstrap.min.css">';
echo '';
echo '<!-- jQuery library -->';
echo '<script src="bootstrap/jquery.min.js"></script>';
echo '';
echo '<!-- Popper JS -->';
echo '<script src="bootstrap/popper.min.js"></script>';
echo '';
echo '<!-- Latest compiled JavaScript -->';
echo '<script src="bootstrap/bootstrap.min.js"></script>	';
echo '</head>';

echo '<body>';

echo '<div class="container">';
echo '<h2 align="center">Enter your data</h2>';
echo '<form action="" method="post" enctype="multipart/form-data">';

echo '<div class="form-group">';
echo '<label for="rollno">Roll No.:</label>';
echo '<input type="number" name="rollno" id="rollno" class="form-control" placeholder="1715083" required>';
echo '</div>';

echo '<div class="form-group">';
echo '<label for="image">Image (' . $min_img_width . '&times;' . $min_img_height . 'px to ' . $max_img_width . '&times;' . $max_img_height . 'px):</label>';
echo '<input type="file" name="image" id="image" class="form-control" accept="image/png, image/jpeg" required>';
echo '</div>';

echo '<div class="form-group">';
echo '<label for="signature">Signature (' . $min_signature_width . '&times;' . $min_signature_height . 'px to ' . $max_signature_width . '&times;' . $max_signature_height . 'px):</label>';
echo '<input type="file" name="signature" id="signature" class="form-control" accept="image/png, image/jpeg" required>';
echo '</div>';

echo '<div class="form-group">';
echo '<label for="document">Document:</label>';
echo '<input type="file" name="document" id="document" class="form-control" accept="application/pdf" required><br><br>';
echo '</div>';

echo '<input type="submit" name="submit" value="Submit" class="btn btn-primary">';

echo '</form>';

echo '</div>';
echo '</body>';
echo '</html>';

?>
